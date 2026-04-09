rm(list = ls())
library(readr)
library(dplyr)
library(haven)
library(tidyverse)
# install.packages("pak")
# pak::pkg_install(pkg = "ropensci/gigs")
library(gigs)
setwd("C:/Users/bdyer/OneDrive - Johns Hopkins/CHN/JiVitA/MiNDR/data/scripts/womantrak/IG_Rcodes")

# -------------------------

n3bwt_data <- read_dta("C:/Users/bdyer/OneDrive - Johns Hopkins/CHN/JiVitA/MiNDR/data/scripts/womantrak/IG_Rcodes/n3bwt.dta")
kt_data <- read_dta("./data/kidtrak.dta")



## Check how Gigs file works and the syntax.
# 
# ```{r combine, echo=TRUE}
# ?gigs
# help(package = "gigs")
# ```

## Recode sex.

# Create sex_mf variable: 1 = "M" (male), 2 = "F" (female)
kt_data$sex_mf <- ifelse(kt_data$sex == 1, "M", "F")

# ```


## Obtain birthweight in kg.

# ```{r Get kg BW, echo=TRUE}
# kt_data$bwt <- kt_data$bwt_comb/1000
unique(kt_data$wt_birth)
n3bwt_data$bwt <- n3bwt_data$bwt_comb/1000
kt_data$bwt <- kt_data$wt_birth

table(kt_data$bwt, exclude= FALSE)
# ```

## Classify size for GA.

# ```{r Birthweight percentile for GA, echo=TRUE}
# Create classified dataset
# n3bwt_classified <- n3bwt_data
kt_classified <- kt_data
# n3bwt_classified$ga
kt_classified$ga <- kt_classified$bggady
kt_classified$sex_mf



# removing children that don't have birth weights for bafs 
# kt_classified <- kt_classified %>% 
#   filter(!is.na(bwt))
# which weights should I use? all? only within 72 hrs of birth? 


# Convert birth weight values to centiles using IG-NBS extension
kt_classified$birthweight_centile <- value2centile(
  y = kt_classified$bwt,           # weight in kg
  x = kt_classified$ga,            # gestational age in days
  sex = kt_classified$sex_mf,      # sex as "M"/"F"
  family = "ig_nbs_ext",              # IG-NBS extension standards
  acronym = "wfga"                    # weight-for-gestational-age
) |>
  round(digits = 3)


# Create individual binary indicators (SGA, LGA and AGA)
# n3bwt_classified <- n3bwt_classified %>%
#   mutate(
#     sga = as.numeric(birthweight_centile < 0.10),
#     lga = as.numeric(birthweight_centile > 0.90),
#     aga = as.numeric(between(birthweight_centile, 0.10, 0.90))
#   )

kt_classified <- kt_classified %>%
  mutate(
    sga = as.numeric(birthweight_centile < 0.10),
    lga = as.numeric(birthweight_centile > 0.90),
    aga = as.numeric(between(birthweight_centile, 0.10, 0.90))
  )

# # Create a categorical variable 
# n3bwt_classified$sfga_category <- case_when(
#   is.na(n3bwt_classified$birthweight_centile) ~ NA_character_,
#   n3bwt_classified$birthweight_centile < 0.10 ~ "SGA",
#   n3bwt_classified$birthweight_centile > 0.90 ~ "LGA",
#   TRUE ~ "AGA"
# )

# Create a categorical variable 
kt_classified$sfga_category <- case_when(
  is.na(kt_classified$birthweight_centile) ~ NA_character_,
  kt_classified$birthweight_centile < 0.10 ~ "SGA",
  kt_classified$birthweight_centile > 0.90 ~ "LGA",
  TRUE ~ "AGA"
)

# Add labels
kt_classified$sfga_category <- factor(kt_classified$sfga_category, 
                                         levels = c("SGA", "AGA", "LGA"))
# ```
## Calculate Z-scores birthweight

# ```{r Birthweight for gestational age z-score, echo=TRUE}
# Define z-score cutoffs (including 0)
z_cutoffs <- c(-6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6)

# Create labels for the categories
z_labels <- c("< -6 SD", "-6 to -5 SD", "-5 to -4 SD", "-4 to -3 SD", 
              "-3 to -2 SD", "-2 to -1 SD", "-1 to 0 SD", "0 to +1 SD", 
              "+1 to +2 SD", "+2 to +3 SD", "+3 to +4 SD", "+4 to +5 SD", 
              "+5 to +6 SD", "> +6 SD")

# Function to categorize z-scores
categorize_zscore <- function(zscore) {
  cut(zscore, 
      breaks = c(-Inf, z_cutoffs, Inf),
      labels = z_labels,
      include.lowest = TRUE)
}

# # Convert birth weight values to z-scores using IG-NBS extension
# n3bwt_classified$birthweight_zscore <- value2zscore(
#   y = n3bwt_classified$bwt,           # weight in kg
#   x = n3bwt_classified$ga,            # gestational age in days
#   sex = n3bwt_classified$sex_mf,      # sex as "M"/"F"
#   family = "ig_nbs_ext",              # IG-NBS extension standards
#   acronym = "wfga"                    # weight-for-gestational-age
# ) |>
#   round(digits = 3)
# 
# Convert birth weight values to z-scores using IG-NBS extension
kt_classified$birthweight_zscore <- value2zscore(
  y = kt_classified$bwt,           # weight in kg
  x = kt_classified$ga,            # gestational age in days
  sex = kt_classified$sex_mf,      # sex as "M"/"F"
  family = "ig_nbs_ext",              # IG-NBS extension standards
  acronym = "wfga"                    # weight-for-gestational-age
) |>
  round(digits = 3)

# # Create birthweight categories
# n3bwt_classified$birthweight_category <- categorize_zscore(n3bwt_classified$birthweight_zscore)
# Create birthweight categories
kt_classified$birthweight_category <- categorize_zscore(kt_classified$birthweight_zscore)

# Create zscore_outlier variable for +/- 5 SD as numeric
kt_classified$zscore_5sd_outlier <- as.numeric(
  kt_classified$birthweight_zscore < -5 | kt_classified$birthweight_zscore > 5
)

# ```

## Birth length classification - by GIGS

# ```{r GIGS for birth length, echo=TRUE}

# # Convert birth length values to centiles using IG-NBS extension
# n3bwt_classified$blen_centile <- value2centile(
#   y = n3bwt_classified$blth,          # length in cm
#   x = n3bwt_classified$ga,            # gestational age in days
#   sex = n3bwt_classified$sex_mf,      # sex as "M"/"F"
#   family = "ig_nbs_ext",              # IG-NBS extension standards
#   acronym = "lfga"                    # length-for-gestational-age
# ) |>
#   round(digits = 3)


kt_classified$blth <- kt_classified$len_birth

table(kt_classified$blth)

# Lets see if both length and weight have the same number of measures for both individuals 
kt_data <- kt_data %>% 
  mutate(lb_e= case_when(!is.na(len_birth)~1,
                         TRUE ~NA),
         wb_e= case_when(!is.na(wt_birth)~1,
                         TRUE ~NA))

table(kt_data$lb_e,kt_data$wb_e,exclude=FALSE)

table(kt_data$len_birth)



# update the 9.99 for len to missing 
kt_classified <- kt_classified %>% 
  mutate(blth=ifelse(blth=="99.9" ,NA, blth))



# Convert birth length values to centiles using IG-NBS extension
kt_classified$blen_centile <- value2centile(
  y = kt_classified$blth,          # length in cm
  x = kt_classified$ga,            # gestational age in days
  sex = kt_classified$sex_mf,      # sex as "M"/"F"
  family = "ig_nbs_ext",              # IG-NBS extension standards
  acronym = "lfga"                    # length-for-gestational-age
) |>
  round(digits = 3)

kt_classified <- kt_classified %>% 
  mutate(blen_centile=case_when(is.na(blth)==TRUE ~NA,
                                TRUE ~blen_centile))

# kt_classified_ln_flt <- kt_classified_ln %>% 
#   filter(is.na(blth))

# # Convert birth length values to z-scores using IG-NBS extension
# n3bwt_classified$blen_zscore <- value2zscore(
#   y = n3bwt_classified$blth,          # length in cm
#   x = n3bwt_classified$ga,            # gestational age in days
#   sex = n3bwt_classified$sex_mf,      # sex as "M"/"F"
#   family = "ig_nbs_ext",              # IG-NBS extension standards
#   acronym = "lfga"                    # length-for-gestational-age
# ) |>
#   round(digits = 3)

kt_classified_zscr_prep <- kt_classified %>% 
  filter(!is.na(blth))

# Convert birth length values to z-scores using IG-NBS extension
kt_classified$blen_zscore <- value2zscore(
  y = kt_classified$blth,          # length in cm
  x = kt_classified$ga,            # gestational age in days
  sex = kt_classified$sex_mf,      # sex as "M"/"F"
  family = "ig_nbs_ext",              # IG-NBS extension standards
  acronym = "lfga"                    # length-for-gestational-age
) |>
  round(digits = 3)
# 
# kt_classified <- kt_classified %>%
#   left_join(kt_classified_zscr_prep %>% select(childuid, blen_zscore), by = "childuid")


# # Create birth length categories
# n3bwt_classified$blen_category <- categorize_zscore(n3bwt_classified$blen_zscore)

# Create birth length categories
kt_classified$blen_category <- categorize_zscore(kt_classified$blen_zscore)

# # Create zscore_outlier variable for +/- 5 SD as numeric
# n3bwt_classified$blen_zscore_5sd_outlier <- as.numeric(
#   n3bwt_classified$blen_zscore < -5 | n3bwt_classified$blen_zscore > 5
# )

# Create zscore_outlier variable for +/- 5 SD as numeric
kt_classified$blen_zscore_5sd_outlier <- as.numeric(
  kt_classified$blen_zscore < -5 | kt_classified$blen_zscore > 5
)
# 
# # Create zscore_6sd_outlier variable for +/- 6 SD as numeric
# n3bwt_classified$blen_zscore_6sd_outlier <- as.numeric(
#   n3bwt_classified$blen_zscore < -6 | n3bwt_classified$blen_zscore > 6
# )

# Create zscore_6sd_outlier variable for +/- 6 SD as numeric
kt_classified$blen_zscore_6sd_outlier <- as.numeric(
  kt_classified$blen_zscore < -6 | kt_classified$blen_zscore > 6
)

# ```
## Birth head circumference classification - by GIGS

# ```{r GIGS for birth head circumference, echo=TRUE}

# # Convert head circumference values to centiles using IG-NBS extension
# n3bwt_classified$hc_centile <- value2centile(
#   y = n3bwt_classified$bhc,           # head circumference in cm
#   x = n3bwt_classified$ga,            # gestational age in days
#   sex = n3bwt_classified$sex_mf,      # sex as "M"/"F"
#   family = "ig_nbs_ext",              # IG-NBS extension standards
#   acronym = "hcfga"                   # head circumference-for-gestational-age
# ) |>
#   round(digits = 3)
# 


table(kt_classified$hc_birth)
kt_classified$bhc <- kt_classified$hc_birth

# Convert head circumference values to centiles using IG-NBS extension
kt_classified$hc_centile <- value2centile(
  y = kt_classified$bhc,           # head circumference in cm
  x = kt_classified$ga,            # gestational age in days
  sex = kt_classified$sex_mf,      # sex as "M"/"F"
  family = "ig_nbs_ext",              # IG-NBS extension standards
  acronym = "hcfga"                   # head circumference-for-gestational-age
) |>
  round(digits = 3)

# 
# # Convert head circumference values to z-scores using IG-NBS extension
# n3bwt_classified$hc_zscore <- value2zscore(
#   y = n3bwt_classified$bhc,           # head circumference in cm
#   x = n3bwt_classified$ga,            # gestational age in days
#   sex = n3bwt_classified$sex_mf,      # sex as "M"/"F"
#   family = "ig_nbs_ext",              # IG-NBS extension standards
#   acronym = "hcfga"                   # head circumference-for-gestational-age
# ) |>
#   round(digits = 3)

# Convert head circumference values to z-scores using IG-NBS extension
kt_classified$hc_zscore <- value2zscore(
  y = kt_classified$bhc,           # head circumference in cm
  x = kt_classified$ga,            # gestational age in days
  sex = kt_classified$sex_mf,      # sex as "M"/"F"
  family = "ig_nbs_ext",              # IG-NBS extension standards
  acronym = "hcfga"                   # head circumference-for-gestational-age
) |>
  round(digits = 3)

# # Create head circumference categories
# n3bwt_classified$hc_category <- categorize_zscore(n3bwt_classified$hc_zscore)
# 

# Create head circumference categories
kt_classified$hc_category <- categorize_zscore(kt_classified$hc_zscore)

# # Create zscore_outlier variable for +/- 5 SD as numeric
# n3bwt_classified$hc_zscore_5sd_outlier <- as.numeric(
#   n3bwt_classified$hc_zscore < -5 | n3bwt_classified$hc_zscore > 5
# )

# Create zscore_outlier variable for +/- 5 SD as numeric
kt_classified$hc_zscore_5sd_outlier <- as.numeric(
  kt_classified$hc_zscore < -5 | kt_classified$hc_zscore > 5
)

# # Create zscore_6sd_outlier variable for +/- 6 SD as numeric
# n3bwt_classified$hc_zscore_6sd_outlier <- as.numeric(
#   n3bwt_classified$hc_zscore < -6 | n3bwt_classified$hc_zscore > 6
# )

# Create zscore_6sd_outlier variable for +/- 6 SD as numeric
kt_classified$hc_zscore_6sd_outlier <- as.numeric(
  kt_classified$hc_zscore < -6 | kt_classified$hc_zscore > 6
)

# ```


kt_classified$wt_birth

table(kt_classified$wt1)
table(kt_classified$len1)
table(kt_classified$hc1)
table(kt_classified$ga)


kt_classified <- kt_classified %>% 
  mutate(wt1=ifelse(wt1==0 ,NA, wt1),
         len1=ifelse(len1==0 ,NA, len1),
         hc1=ifelse(hc1==0 ,NA, hc1))


report_units(family = "ig_png", acronym = "wfa")
report_units(family = "ig_nbs", acronym = "wfga")
report_units(family = "who_gs", acronym = "wfa")
report_units(family = "ig_nbs", acronym = "wlrfga")

kt_classified$wtlnr_birth <- kt_classified$bwt/(kt_classified$blth/100)

table(kt_classified$blth)


# Convert head circumference values to z-scores using IG-NBS extension
# We have 1 bgga that is >300 for the IG21st and this is not avaialble in the extension version so what do we do here? 
# Just use the WHO standard ? 
kt_classified$wtl_zscore <- value2zscore(
  y = kt_classified$wtlnr_birth,           # head circumference in cm
  x = kt_classified$ga,            # gestational age in days
  sex = kt_classified$sex_mf,      # sex as "M"/"F"
  family = "ig_nbs",              # IG-NBS extension standards
  acronym = "wlrfga"                   # head circumference-for-gestational-age
) |>
  round(digits = 3)



kt_classified$agewga1 <- (kt_classified$ga+kt_classified$aged1)/7

table(kt_classified$ga)

# # Convert 1 month weight values to centiles using IG-PNG
# kt_classified$weight1_centile <- value2centile(
#   y = kt_classified$wt1,           # weight in kg
#   x = kt_classified$agewga1,            # gestation age at 1 month in weeks 
#   sex = kt_classified$sex_mf,      # sex as "M"/"F"
#   family = "ig_png",              # IG-NBS extension standards
#   acronym = "wfa"                    # weight-for-age
# ) |>
#   round(digits = 3)

# # Convert 1 month weight values to centiles using IG-PNG
# kt_classified$weight1_centile <- value2centile(
#   y = kt_classified$wt1,           # weight in kg
#   x = kt_classified$aged1,            # gestation age at 1 month in weeks 
#   sex = kt_classified$sex_mf,      # sex as "M"/"F"
#   family = "who_gs",              # IG-NBS extension standards
#   acronym = "wfa"                    # weight-for-age
# ) |>
#   round(digits = 3)


# kt_classified$weight1_zscore <- value2zscore(
#   y = kt_classified$wt1,           # head circumference in cm
#   x = kt_classified$agewga1,            # gestational age in days
#   sex = kt_classified$sex_mf,      # sex as "M"/"F"
#   family = "ig_png",              # IG-NBS extension standards
#   acronym = "wfa"                   # head circumference-for-gestational-age
# ) |>
#   round(digits = 3)

kt_classified$weight1_zscore_who <- value2zscore(
  y = kt_classified$wt1,           # head circumference in cm
  x = kt_classified$aged1,            # gestational age in days
  sex = kt_classified$sex_mf,      # sex as "M"/"F"
  family = "who_gs",              # IG-NBS extension standards
  acronym = "wfa"                   # head circumference-for-gestational-age
) |>
  round(digits = 3)


kt_classified$len1_zscore <- value2zscore(
  y = kt_classified$len1,           # head circumference in cm
  x = kt_classified$agewga1,            # gestational age in days
  sex = kt_classified$sex_mf,      # sex as "M"/"F"
  family = "ig_png",              # IG-NBS extension standards
  acronym = "lfa"                   # head circumference-for-gestational-age
) |>
  round(digits = 3)


kt_classified$hc1_zscore <- value2zscore(
  y = kt_classified$hc1,           # head circumference in cm
  x = kt_classified$agewga1,            # gestational age in days
  sex = kt_classified$sex_mf,      # sex as "M"/"F"
  family = "ig_png",              # IG-NBS extension standards
  acronym = "hcfa"                   # head circumference-for-gestational-age
) |>
  round(digits = 3)



writeLines(colnames(kt_classified))

kt_classified_cut<- kt_classified %>% 
  select(childuid,
         birthweight_zscore,
         blen_zscore,
         hc_zscore,
         wtl_zscore,
         birthweight_centile,
         blen_centile,
         hc_centile
  ) %>% 
  rename(wapig_birth=birthweight_centile,
         wlzig_birth=wtl_zscore,
         wazig_birth=birthweight_zscore,
         lapig_birth=blen_centile,
         lazig_birth=blen_zscore,
         hcpig_birth=hc_centile,
         hczig_birth=hc_zscore
         )



# ```{r Export in Stata format, echo=TRUE}
# Export the dataset as a Stata .dta file
write_dta(kt_classified_cut, "./output/mindr_gigs_1.dta")

write.csv(kt_classified_cut, "./output/mindr_gigs_20250926.csv", row.names = FALSE, na="")

# ```
