rm(list = ls())
library(here)
library(tidyverse)
library(usethis)
library(haven)
library(FactoMineR)
library(DescTools)

# Read data
ses <- read_dta("data/ses_wra.dta")



# Replace all 9/99/999/9999 to missing
ses_cleaned <- ses %>%
  select(ssdoc:ssfswholedh) %>%
  mutate(across(where(is.character), ~ {
    try_col <- suppressWarnings(as.double(.))
    # Check if all non-NA values are converted without introducing new NAs
    if (all(is.na(try_col) == is.na(.))) {
      try_col
    } else {
      .  # Leave column as-is
    }
  }))


ses_cleaned_2 <- ses_cleaned %>%
  mutate(across(where(is.numeric), ~ replace(., . %in% c(9, 99, 999, 9999), NA_real_)))


# gather other columns (not cleaned) from original `ses`
ses_others <- ses %>%
  select(-c(ssdoc:ssfswholedh))

# Combine cleaned with others
ses_bnd <- bind_cols(ses_others, ses_cleaned_2)


# Define family size:
# missing valuses assign to 0 and then sum up all the sshhs variables to get total family size
# ?? should I keep the people overseas ??

ses_fs <- ses_bnd %>%
  # Replace NA with 0 in specific columns
  mutate(across(starts_with("sshh"), ~ ifelse(is.na(.), 0, .)))
ses_fs_2 <- ses_fs %>%
  mutate(ssfmoutside = ifelse(is.na(ssfmoutside), 0, ssfmoutside))

ses_fs_3 <- ses_fs_2 %>%
  mutate(across(c(starts_with("sshh"), ssfmoutside), ~ as.numeric(.))) %>%
    # Calculate the total size as a new column 'fsize'
  mutate(fsize = rowSums(across(c(starts_with("sshh"), ssfmoutside)), na.rm = TRUE))

head(ses_fs_3$fsize)

# Define no of rooms per family size
# ses_rmsz <- ses_fs_3 %>%
#   mutate(roomFsize=sslivrm/fsize) %>%
#   # Categorize roomFsize into roomFsize_g
#   mutate(roomFsize_g = case_when(
#     roomFsize <= 0.25 ~ 1,
#     roomFsize > 0.25 & roomFsize <= 0.34 ~ 2,
#     roomFsize > 0.34 & roomFsize <= 2 ~ 3,
#     TRUE ~ NA_real_
#   ))

ses_rmsz <- ses_fs_3 %>%
  mutate(
    roomFsize = as.numeric(sslivrm) / as.numeric(fsize),
    roomFsize_g = case_when(
      roomFsize <= 0.25 ~ 1,
      roomFsize > 0.25 & roomFsize <= 0.34 ~ 2,
      roomFsize > 0.34 & roomFsize <= 2 ~ 3,
      TRUE ~ NA_real_
    )
  )

ses_rmsz_a<- ses_fs_3 %>%
  mutate(roomFsize = as.numeric(sslivrm) / as.numeric(fsize))

unique(ses_fs_3$roomFsize)
unique(ses_rmsz_a$roomFsize)
table(ses_rmsz$roomFsize_g)

head(ses_rmsz$roomFsize_g)

#
# *-------------------------------------------------------------------------------------
# * Define the amount of land owned by HH in the same unit (shatak)
# foreach landvar of varlist sscropu ssgardenu ssgroveu sspondu sshomeu sslandu{
# recode `landvar' 1=33 2=1 3=1.5 4=100
# }
# gen crop=sscropnu*sscropu
# replace crop=0 if sscropnu==0
# gen garden=ssgardennu*ssgardenu
# replace garden=0 if ssgardennu==0
# gen grove= ssgrovenu*ssgroveu
# replace grove=0 if ssgrovenu==0
# gen pond=sspondnu*sspondu
# replace pond=0 if sspondnu==0
# gen home=sshomenu*sshomeu
# replace home=0 if sshomenu==0
# gen land=sslandnu*sslandu
# replace land=0 if sslandnu==0
#
# recode crop 0=1 1/98=2 99/max=3, generate(crop_g)
# recode garden 0=1 1/max=2, generate(garden_g)
# recode grove 0=1 1/max=2, generate(grove_g)
# recode pond 0=1 1/max=2, generate(pond_g)
# recode home 0=1 0.001/3.999=2 4/10=3 10.001/max=4, generate(home_g)

ses_lnd_own <- ses_rmsz %>%
  mutate(across(c(sslandu), ~ as.numeric(.)))  %>%
  mutate(across(c(ssland), ~ as.numeric(.)))  %>%
  # mutate(across(c(ssland), ~ ifelse(is.na(.), 0, .))) %>%
  # Recode land ownership values
  mutate(across(c(sslandu),
                ~ case_when(
                  . == 1 ~ 33,
                  . == 2 ~ 1,
                  . == 3 ~ 1.5,
                  . == 4 ~ 100,
                  TRUE ~ . # Keep other values unchanged
                ))) %>%

  # Generate new variables for crop, garden, grove, pond, home, land
  mutate(

         land = ssland * sslandu) %>%

  # Replace with 0 if certain conditions are met
  mutate(

         land = ifelse(sslandu == 0, 0, land))
# %>%

# -----------------------------------------------------------------------------------------------------------------------------
# other land use variables were not avaialable in MiNDR
# unique(ses$garden)


#
# *--------------------------------------------------------------------------------------------------
#   *  Dwelling Characteristic Variables: Generating dummy variables where the
# *  most frequent category will be the referent category and so make dummy varibales for each
# *  category except for the most frequent category
# *---------------------------------------------------------------------------------------------------
#   * Recoding the dwelling characteristics variables
#
# *------------------------------------------------------------------------------
#   * Before using Principal component analysis impute missing values with the mode
# foreach dc of varlist gfloor_g* kitchen_g* toilet_g* sselectric rmfsize_g*{
#   summarize `dc'
# if r(mean)>0.5{
# replace `dc'=1 if `dc'==.
# }
# else{
# replace `dc'=0 if `dc'==.
# }
# }
#
#
# * For GROUND FLOOR
# recode ssgfloor 0=1
# tab ssgfloor, generate(gfloor_g)
# drop gfloor_g3

# ses_gfloor <- ses_lnd_own %>%
#   mutate(across(c(ssgfloor), ~ as.numeric(.)))  %>%
#   mutate(ssgfloor = if_else(ssgfloor == 0, 1, ssgfloor),  # Recode 0 to 1
#   ssgfloor = if_else(is.na(ssgfloor), Mode(ssgfloor, na.rm = TRUE), ssgfloor))  # Impute NA with mode

ses_gfloor <- ses_lnd_own %>%
  mutate(across(c(ssgfloor), ~ as.numeric(.)))  %>%
  mutate(ssgfloor = if_else(ssgfloor == 0 | ssgfloor ==2, 1, ssgfloor),  # Recode 0 to 1
  ssgfloor = if_else(is.na(ssgfloor), Mode(ssgfloor, na.rm = TRUE), ssgfloor))  # Impute NA with mode

# # Generate dummy variables for ssgfloors
# ses_gfloor_2 <- ses_gfloor %>%
#   mutate(gfloor_g1 = if_else(ssgfloor == 1, 1, 0),
#          gfloor_g2 = if_else(ssgfloor == 2, 1, 0),
#          gfloor_g3 = if_else(ssgfloor == 3, 1, 0),
#          gfloor_g4 = if_else(ssgfloor == 4, 1, 0))

# Generate dummy variables for ssgfloors
ses_gfloor_2 <- ses_gfloor %>%
  mutate(gfloor_g1 = if_else(ssgfloor == 1  , 1, 0), # includes 0 and 2
         gfloor_g3 = if_else(ssgfloor == 3, 1, 0),
         gfloor_g4 = if_else(ssgfloor == 4, 1, 0))

Mode(ses_gfloor_2$ssgfloor) # determine most frequent category

table(ses$ssgfloor) # determine most frequent category
table(ses_gfloor_2$ssgfloor) # determine most frequent category

table(ses$ssgfloor, useNA = "always")

ses_gfloor_3 <- ses_gfloor_2 %>% select(- gfloor_g3) # drop most frequent category


# * ROOF has not been included as 98% roof are with TIN
# * Kitchen
# tab sskitchen, generate(kitchen_g)
# drop kitchen_g4

unique(ses_gfloor_3$sskitchen)

# Generate dummy variables for kitchen
ses_kitch <- ses_gfloor_3 %>%
  mutate (sskitchen = if_else(is.na(sskitchen), Mode(sskitchen, na.rm = TRUE), sskitchen)) %>%  # Impute NA with mode
  mutate(kitchen_g0 = if_else(sskitchen == 0, 1, 0),
          kitchen_g1 = if_else(sskitchen == 1, 1, 0),
         kitchen_g2 = if_else(sskitchen == 2, 1, 0),
         kitchen_g3 = if_else(sskitchen == 3, 1, 0))

Mode(ses_kitch$sskitchen)
table(ses_kitch$sskitchen)
# Remove kitchen_g3
ses_kitch_lg3 <- ses_kitch %>% select(-kitchen_g3)  # drop most frequent category

# * Toilet
# *combine "flash toilet" in to "Water-sealed/slap"
# recode sstoilet 4=3
# tab sstoilet, generate(toilet_g)
# drop toilet_g4

# ses_tlt <- ses_kitch_lg3 %>%
#   mutate(across(c(sstoilet), ~ as.numeric(.)))  %>%
#   mutate(sstoilet = if_else(sstoilet == 4, 3, sstoilet),  # Recode
#          sstoilet = if_else(is.na(sstoilet), Mode(sstoilet, na.rm = TRUE), sstoilet))  # Impute NA with mode
#
ses_tlt <- ses_kitch_lg3 %>%
  mutate(across(c(sstoilet), ~ as.numeric(.)))  %>%
  mutate(sstoilet = if_else(sstoilet == 4, 3, sstoilet),  # Recode
         sstoilet = if_else(sstoilet == 1 | sstoilet ==2, 0, sstoilet),# Recode
         sstoilet = if_else(is.na(sstoilet), Mode(sstoilet, na.rm = TRUE), sstoilet))  # Impute NA with mode


unique(ses_tlt$sstoilet)
table(ses_tlt$sstoilet)
# Generate dummy variables for toilet
#
# ses_tlt_2 <- ses_tlt %>%
#   mutate(toilet_g0 = if_else(sstoilet == 0, 1, 0),
#          toilet_g1 = if_else(sstoilet == 1, 1, 0),
#          toilet_g2 = if_else(sstoilet == 2, 1, 0),
#          toilet_g3 = if_else(sstoilet == 3, 1, 0),
#          toilet_g5 = if_else(sstoilet == 5, 1, 0))

ses_tlt_2 <- ses_tlt %>%
  mutate(toilet_g0 = if_else(sstoilet == 0, 1, 0), # includes 1 and 2
         #toilet_g2 = if_else(sstoilet == 2, 1, 0),
         toilet_g3 = if_else(sstoilet == 3, 1, 0), # includes 4
         toilet_g5 = if_else(sstoilet == 5, 1, 0))


Mode(ses_tlt_2$sstoilet)
unique(ses_tlt_2$sstoilet)
table(ses_tlt_2$sstoilet)
# Remove toilet_g3
ses_tlt_3 <- ses_tlt_2 %>% select(-toilet_g3)

# * Family size
# tab roomFsize_g, generate(rmfsize_g)
# drop rmfsize_g1
unique(ses_tlt_3$roomFsize_g)

# Generate dummy variables for room size
ses_rm_dmy <- ses_tlt_3 %>%
  mutate(roomFsize_g = if_else(is.na(roomFsize_g), Mode(roomFsize_g, na.rm = TRUE), roomFsize_g)) %>%  # Impute NA with mode
  mutate(rmfsize_g1 = if_else(roomFsize_g == 1, 1, 0),
         rmfsize_g2 = if_else(roomFsize_g == 2, 1, 0),
         rmfsize_g3 = if_else(roomFsize_g == 3, 1, 0))

summary(ses_rm_dmy$roomFsize_g)
Mode(ses_rm_dmy$roomFsize_g)
table(ses_rm_dmy$roomFsize_g)
# Remove rmfsize_g3
ses_rm_dmy_2 <- ses_rm_dmy %>% select (-rmfsize_g1)

#impute for sselectric
ses_rm_dmy_3 <- ses_rm_dmy_2 %>%
  mutate(across(c(sselectric), ~ as.numeric(.))) %>%
  mutate (sselectric = if_else(is.na(sselectric), Mode(sselectric, na.rm = TRUE), sselectric))

# * Use PCA
# pca gfloor_g* kitchen_g* toilet_g* sselectric rmfsize_g*
# predict pc1
# * Dwelling characteristics index is defined as DCI
# rename pc1 dci
#
# Selecting the columns to use for PCA
dci_columns <- ses_rm_dmy_3 %>%
  select(starts_with("gfloor_g"), starts_with("kitchen_g"), starts_with("toilet_g"), sselectric, starts_with("rmfsize_g"))

# Performing PCA
dci_result <- PCA(dci_columns, ncp = 1, graph = FALSE)

ses_dci<- ses_rm_dmy_3
# Extracting the first component and adding it to the original dataframe
ses_dci$dci <- dci_result$ind$coord[, 1]

# *-------------------------------------------------------------------------------------
# * Now construct durable assets index
# *-------------------------------------------------------------------------------------
# * Generat dummy varibales
# foreach da of varlist ssirrpump ssradios sscycle ssrickshaw ssdtable sssewmach sstv ssmotorc{
# recode `da' 0=0 1/max=1, generate(`da'_g)
# }

# Performing transformations and renaming
ses_dai_1 <- ses_dci %>%
  # Step 1: Transform original variables and create new columns with _g suffix
  mutate(across(c(ssirrpump, ssradios, sscycle, ssmrickshaw, ssdtable, sssewmach, sstv, ssmotorc),
                ~ ifelse(. == 0, 0, 1), .names = "{.col}_g")) %>%
  # Step 2: Replace NA values with mode for the newly created columns
  mutate(across(ends_with("_g"),
                ~ if_else(is.na(.), Mode(., na.rm = TRUE), .)))


#
# * Almira categorization
# recode ssalmira 0=1 1=2 2/max=3, generate(ssalmira_g)
# tab ssalmira_g, generate(almira_g)
# drop almira_g2

unique(ses_dai_1$ssalmira)
ses_dai_2 <- ses_dai_1 %>%
  mutate(ssalmira = if_else(is.na(ssalmira), Mode(ssalmira, na.rm = TRUE), ssalmira)) %>%
  mutate(almira_g1 = if_else(ssalmira == 0, 1, 0),
         almira_g2 = if_else(ssalmira== 1, 1, 0),
         almira_g3 = if_else(ssalmira >= 2, 1, 0))

Mode(ses_dai_1$ssalmira)
table(ses_dai_1$ssalmira)
table(ses_dai_2$almira_g1)
table(ses_dai_2$almira_g2)
table(ses_dai_2$almira_g3)
unique(ses_dai_2$ssalmira)
ses_dai_3 <- ses_dai_2 %>% select (-almira_g2)
#
# *Clock categorization
# recode ssclock 0=1 1=2 2/max=3, generate(ssclock_g)
# tab ssclock_g, generate(clock_g)
# drop clock_g1

unique(ses_dai_3$ssclock)
ses_dai_clk_1 <- ses_dai_3 %>%
  mutate(ssclock = if_else(is.na(ssclock), Mode(ssclock, na.rm = TRUE), ssclock)) %>%
  mutate(ssclock_g1 = if_else(ssclock == 0, 1, 0),
        ssclock_g2 = if_else(ssclock== 1, 1, 0),
         ssclock_g3 = if_else(ssclock >= 2, 1, 0))

Mode(ses_dai_clk_1$ssclock, na.rm=T)
table(ses_dai_clk_1$ssclock)
table(ses_dai_clk_1$ssclock_g1)
table(ses_dai_clk_1$ssclock_g2)
table(ses_dai_clk_1$ssclock_g3)
ses_dai_clk_2 <- ses_dai_clk_1 %>% select (-ssclock_g1)

# * Mobile categorization
# recode ssmobile 0=1 1=2 2/max=3, generate(ssmobile_g)
# tab ssmobile_g, generate(mobile_g)
# drop mobile_g2

unique(ses_dai_clk_2$ssmobile)
# ses_dai_mbl_1 <- ses_dai_clk_2 %>%
#   mutate(ssmobile = if_else(is.na(ssmobile), Mode(ssmobile, na.rm = TRUE), ssmobile)) %>%
#   mutate(mobile_g1 = if_else(ssmobile == 0, 1, 0),
#          mobile_g2 = if_else(ssmobile== 1, 1, 0),
#          mobile_g3 = if_else(ssmobile >= 2, 1, 0))

ses_dai_mbl_1 <- ses_dai_clk_2 %>%
  mutate(ssmobile = if_else(is.na(ssmobile), Mode(ssmobile, na.rm = TRUE), ssmobile)) %>%
  mutate(mobile_g1 = if_else(ssmobile == 0 | ssmobile == 1, 1, 0),
         mobile_g2 = if_else(ssmobile== 2, 1, 0),
         mobile_g3 = if_else(ssmobile == 3, 1, 0),
         mobile_g4 = if_else(ssmobile >3, 1, 0))



ses_dai_mbl_1 %>% mutate(ssmobile_g = case_when(
  mobile_g1 ==1 ~1,
  mobile_g2 ==1 ~2,
  mobile_g3 ==1 ~3,
  mobile_g4 ==1 ~4
)) %>%
  summarise(Mode(ssmobile_g, na.rm = T))

Mode(ses_dai_mbl_1$ssmobile, na.rm=T)

# mode now is 2

table(ses_dai_mbl_1$ssmobile)
table(ses_dai_mbl_1$mobile_g1)
table(ses_dai_mbl_1$mobile_g2)
table(ses_dai_mbl_1$mobile_g3)


ses_dai_mbl_2 <- ses_dai_mbl_1 %>% select (-mobile_g2)

# *wood bed per household size
#
# gen sswoodbedHhs=sswoodbed/fsize
# recode sswoodbedHhs 0/0.33=1 0.331/0.50=2 0.501/max=3, generate(sswoodbedHhs_g)
# tab sswoodbedHhs_g, generate(woodbedHhs_g)
# drop woodbedHhs_g2
#
# ses_dai_wbed_1 <- ses_dai_mbl_2 %>%
#   mutate(across(c(sswoodbed), ~ as.numeric(.))) %>%
#   mutate(sswoodbed = if_else(is.na(sswoodbed), Mode(sswoodbed, na.rm = TRUE), sswoodbed)) %>%
#   mutate(sswoodbedHhs = sswoodbed / fsize) %>%
#   mutate(sswoodbedHhs_g1 = if_else(sswoodbedHhs == 0 , 1, 0),
#            sswoodbedHhs_g2 = if_else(sswoodbedHhs > 0 & sswoodbedHhs <= 0.33, 1,0),
#            sswoodbedHhs_g3 = if_else(sswoodbedHhs > 0.33 & sswoodbedHhs <= 0.50,1,0)
#          )



ses_dai_wbed_1 <- ses_dai_mbl_2 %>%
  mutate(across(c(sswoodbed), ~ as.numeric(.))) %>%
  mutate(sswoodbed = if_else(is.na(sswoodbed), Mode(sswoodbed, na.rm = TRUE), sswoodbed)) %>%
  mutate(sswoodbedHhs = sswoodbed / fsize) %>%
  mutate(sswoodbedHhs_g1 = if_else(sswoodbedHhs >= 0 & sswoodbedHhs <= 0.33, 1,0),
         sswoodbedHhs_g2 = if_else(sswoodbedHhs > 0.33 & sswoodbedHhs <= 0.50,1,0),
         sswoodbedHhs_g3 = if_else(sswoodbedHhs > 0.5,1,0)
  )


ses_dai_wbed_1 %>% mutate(sswoodbedHhs_g = case_when(
  sswoodbedHhs_g1 ==1 ~ 1,
  sswoodbedHhs_g2 ==1 ~ 2,
  sswoodbedHhs_g3 ==1 ~ 3,
  TRUE ~ NA_real_)) %>%
  summarize(mode = Mode(sswoodbedHhs_g, na.rm = T))

# I think the mode changes here with sswoodbedHhs

Mode(ses_dai_wbed_1$sswoodbed , na.rm=T)

Mode(ses_dai_wbed_1$sswoodbedHhs , na.rm=T)
table(ses_dai_mbl_2$sswoodbed)
table(ses_dai_wbed_1$sswoodbedHhs_g1)
table(ses_dai_wbed_1$sswoodbedHhs_g2)
table(ses_dai_wbed_1$sswoodbedHhs_g3)

table(ses_dai_wbed_1$sswoodbedHhs)
ses_dai_wbed_2 <- ses_dai_wbed_1 %>% select(-sswoodbedHhs_g2)
# ses_dai_wbed_2 <- ses_dai_wbed_1 %>% select(-sswoodbedHhs_g3)



#
# *------------------------------------------------------------------------------
# * Before using Principal component analysis impute missing values with mode
# foreach daVars of varlist ssirrpump_g ssradios_g sscycle_g ssrickshaw_g almira_g* ssdtable_g clock_g* sssewmach_g sstv_g ssmotorc_g mobile_g* woodbedHhs_g*{
# summarize `daVars'
# if r(mean)>0.5 {
#   replace `daVars'=1 if `daVars'==.
# }
# else {
# replace `daVars'=0 if `daVars'==.
# }
# }
#
# * Now use PCA
# pca ssirrpump_g ssradios_g sscycle_g ssrickshaw_g almira_g* ssdtable_g clock_g* sssewmach_g sstv_g ssmotorc_g mobile_g* woodbedHhs_g*
# predict pc1
# * Durable Asset index is defined as DAI
# rename pc1 dai

# Selecting the specific columns to use for PCA based on the provided variable names
# Brian note - not sure if these ss from ssalmira_g and ssmobile_g should be removed to capture what is actually in the dataset
dai_columns <- ses_dai_wbed_2 %>%
  select(ssirrpump_g,
         ssradios_g,
         sscycle_g,
         ssmrickshaw_g,
         starts_with("almira_g"),
         ssdtable_g,
         starts_with("ssclock_g"),
         sssewmach_g,
         sstv_g,
         ssmotorc_g,
         starts_with("mobile_g"),
         starts_with("sswoodbedHhs_g")
         )

# Performing PCA
# ncp = 1 means we only want the first principal component
dai_result <- PCA(dai_columns, ncp = 1, graph = FALSE)

ses_dai<- ses_dai_wbed_2
# Extracting the first component and adding it to the original dataframe
# Rename the first principal component as DAI (Durable Asset Index)
ses_dai$dai <- dai_result$ind$coord[, 1]

# Print summary of PCA results
print(summary(dai_result))

#
#
# *-----------------------------------------------------------------------------------------------------------
# *          Now construct the living standard index (LSI)
# *It consists of both dwelling characteristics and durable asset variables
# *----------------------------------------------------------------------------------------------------------
#
# pca gfloor_g* kitchen_g* toilet_g* sselectric rmfsize_g* ssirrpump_g ssradios_g sscycle_g ssrickshaw_g almira_g* ssdtable_g clock_g* sssewmach_g sstv_g ssmotorc_g mobile_g* woodbedHhs_g*
# predict pc1
# * Living standard index is defined as LSI
# rename pc1 lsi
# Brian changed clock_g to ssclock_g
# Brian changed woodbedHhs_g to sswoodbedHhs_g
lsi_columns <- ses_dai %>%
  select(starts_with("gfloor_g"),
         starts_with("kitchen_g"),
         starts_with("toilet_g"),
         sselectric,
         starts_with("rmfsize_g"),
         starts_with("ssirrpump_g"),
         starts_with("ssradios_g"),
         starts_with("sscycle_g"),
         starts_with("ssrickshaw_g"),
         starts_with("almira_g"),
         starts_with("ssdtable_g"),
         starts_with("ssclock_g"),
         starts_with("sssewmach_g"),
         starts_with("sstv_g"),
         starts_with("ssmotorc_g"),
         starts_with("mobile_g"),
         starts_with("sswoodbedHhs_g"))

writeLines(colnames(lsi_columns))


# Perform PCA
lsi_result <- PCA(lsi_columns, ncp = 1, graph = FALSE)

ses_lsi <- ses_dai

# Extract the first principal component and add it to the original dataframe
ses_lsi$lsi <- lsi_result$ind$coord[, 1]




hist(ses_lsi$lsi)
summary(ses_lsi$sshde1)

#77=Non-formal education
ed<- ses_lsi %>% mutate (ed = case_when(
  sshde1 == 0 ~0,
  sshde1 >=1 & sshde1 <=4 ~1,
  sshde1 >=5 & sshde1 <=9 ~2,
  sshde1 >=10 & sshde1 <77 ~3,
  sshde1  == 77 ~0,
  TRUE ~ NA_real_))

summary(ses_lsi$sshde1)
summary(ed$ed)
table(ed$ed, ed$sshde1, useNA = "ifany")
ed %>%
  group_by(ed) %>%
  summarise(mean_lsi = mean(lsi, na.rm = TRUE))
plot(ed$sshde1, ed$lsi)

table(ses_lsi$sswood)
table(ed$sswoodbed, ed$ed)
table(ed$sstoilet, ed$ed)
lsi_result$var$coord
table(ses_lsi$ssmobile)
# n = 4062

# View the updated dataset with Living Standard Index
print(summary(lsi_result))

# *---------------------------------------------------------------------------------------------------------
# *    Now construct land ownership index
# * In consits of all type land owned by HH
# *--------------------------------------------------------------------------------------------------------
#
# * Define the dummy variables
# tab crop_g, generate(crop_dum)
# drop crop_dum1
# tab garden_g, generate(garden_dum)
# drop garden_dum1
# tab grove_g, generate(grove_dum)
# drop grove_dum1
# tab pond_g, generate(pond_dum)
# drop pond_dum1
# tab home_g, generate(home_dum)
# drop home_dum1
#
# * Before using Principal component analysis impute missing values with mode
# foreach landvar of varlist crop_dum* garden_dum* grove_dum* pond_dum* home_dum*{
# summarize `landvar'
# if r(mean)>0.5 {
#   replace `landvar'=1 if `landvar'==.
# }
# else{
# replace `landvar'=0 if `landvar'==.
# }
# }
#

# -----
# NOTE that LOI variables do not exist in the MiNDR PW SES dataset
# -----
# unique(ses$home_g)
# # Define the dummy variables
# ses <- ses %>%
#   mutate(crop_dum1 = if_else(crop_g == 1, 1, 0),
#          crop_dum2 = if_else(crop_g == 2, 1, 0),
#          crop_dum3 = if_else(crop_g == 3, 1, 0),
#          garden_dum = if_else(garden_g ==1, 1, 0),
#          grove_dum = if_else(grove_g ==1, 1, 0),
#          pond_dum = if_else(pond_g ==1, 1, 0),
#          home_dum1 = if_else(home_g ==1, 1, 0),
#          home_dum2 = if_else(home_g ==2, 1, 0),
#          home_dum3 = if_else(home_g ==3, 1, 0),
#          home_dum4 = if_else(home_g ==4, 1, 0)) %>%
#   select (-home_dum1, -crop_dum1)
#
#
# # Impute missing values for dummy variables
# dummy_vars <- ses %>% select(starts_with("crop_dum"), "garden_dum", "grove_dum", "pond_dum", starts_with("home_dum")) %>%
#   colnames()
#
# for (var in dummy_vars) {
#   ses[[var]] <- ifelse(is.na(ses[[var]]), Mode(ses[[var]], na.rm = TRUE), ses[[var]])
# }
# # * Now use PCA
# # pca  crop_dum* garden_dum* grove_dum* pond_dum* home_dum*
# # predict pc1
# #
# # * Land ownership index is defined as LOI
# # rename pc1 loi
# loi_columns <- ses %>% select(starts_with("crop_dum"), "garden_dum", "grove_dum", "pond_dum", starts_with("home_dum"))
#
# # Run PCA
# loi_result <- PCA(loi_columns, ncp = 1, graph = FALSE)
#
# # Extract the first principal component and add it to the original dataframe
# ses$loi <- loi_result$ind$coord[, 1]
#
# # View the updated dataset with Land Ownership Index
# print(summary(loi_result))
# #
# *---------------------------------------------------------------------------------------------------------
# *    Now construct Productive asset index
# * In consits of all type land owned by HH
# *--------------------------------------------------------------------------------------------------------
#
# * Categorizing all the productive asset variables
#
# * No of cattles
# recode sscattle 0=1 1=2 2/5=3 6/max=4, generate(cattle_g)

ses_pa_1 <- ses_lsi %>%
  mutate(sscattle = if_else(is.na(sscattle), Mode(sscattle, na.rm = TRUE), sscattle)) %>%
  mutate(cattle_dum1 = if_else(sscattle == 0, 1, 0),
         cattle_dum2 = if_else(sscattle == 1, 1, 0),
         cattle_dum3 = if_else(sscattle >= 2 & sscattle <=5, 1, 0),
         cattle_dum4 = if_else(sscattle >= 6, 1, 0))


Mode(ses_pa_1$sscattle , na.rm=T)
ses_pa_2 <- ses_pa_1 %>% select(-cattle_dum1)

# * No of goats
# recode ssgoats 0=1 1=2 2/max=3, generate(goats_g)

ses_pa_gt <- ses_pa_2 %>%
  mutate(ssgoats = if_else(is.na(ssgoats), Mode(ssgoats, na.rm = TRUE), ssgoats)) %>%
  mutate(goats_dum1 = if_else(ssgoats == 0, 1, 0),
         goats_dum2 = if_else(ssgoats == 1, 1, 0),
         goats_dum3 = if_else(ssgoats >= 2 , 1, 0))


Mode(ses_pa_gt$ssgoats , na.rm=T)
table(ses_pa_gt$goats_dum1)
table(ses_pa_gt$goats_dum2)
table(ses_pa_gt$goats_dum3)


ses_pa_gt_2 <- ses_pa_gt %>% select(-goats_dum1)
# * No. of chickens
# recode sschickens 0=1 1/5=2 6/max=3, generate(chickens_g)
ses_pa_ckn_1 <- ses_pa_gt_2 %>%
  mutate(across(c(sschickens), ~ as.numeric(.))) %>%
  mutate(sschickens = if_else(is.na(sschickens), Mode(sschickens, na.rm = TRUE), sschickens)) %>%
  mutate(chickens_dum1 = if_else(sschickens == 0, 1, 0),
         chickens_dum2 = if_else(sschickens >= 1 & sschickens <=5, 1, 0),
         chickens_dum3 = if_else(sschickens >5, 1, 0))



Mode(ses_pa_ckn_1$sschickens , na.rm=T)
table(ses_pa_ckn_1$chickens_dum1)
table(ses_pa_ckn_1$chickens_dum2)
table(ses_pa_ckn_1$chickens_dum3)

# this should probably drop _dum2 instead of _dum1 given that the
ses_pa_ckn_2 <- ses_pa_ckn_1 %>% select(-chickens_dum2)

# * No of ducks
# recode ssducks 0=1 1/5=2 6/max=3, generate(ducks_g)
ses_pa_dck_1 <- ses_pa_ckn_2 %>%
  mutate(across(c(ssducks), ~ as.numeric(.))) %>%
  mutate(ssducks = if_else(is.na(ssducks), Mode(ssducks, na.rm = TRUE), ssducks)) %>%
  mutate(ducks_dum1 = if_else(ssducks == 0, 1, 0),
         ducks_dum2 = if_else(ssducks >= 1 & ssducks <=5, 1, 0),
         ducks_dum3 = if_else(ssducks >5, 1, 0))

df <- ses_pa_dck_1 %>%
  mutate(duck_mode = pmap_int(
    list(ducks_dum1, ducks_dum2, ducks_dum3),
    function(g1, g2, g3) {
      dummies <- c(g1, g2, g3)
      if (all(is.na(dummies)) || all(dummies == 0)) {
        NA_integer_
      } else {
        which.max(dummies)
      }
    }
  ))



Mode(ses_pa_dck_1$ssducks , na.rm=T)
Mode(df$duck_mode , na.rm=T)
table(ses_pa_dck_1$ducks_dum1)
table(ses_pa_dck_1$ducks_dum2)
table(ses_pa_dck_1$ducks_dum3)


ses_pa_dck_2 <- ses_pa_dck_1 %>% select(-ducks_dum1)

# * No. of mango trees
# recode ssmango 0=1 1=2 2/5=3 6/max=4, generate(mango_g)
# ses <- ses %>%
#   mutate(ssmango = if_else(is.na(ssmango), Mode(ssmango, na.rm = TRUE), ssmango)) %>%
#   mutate(mango_dum1 = if_else(ssmango == 0, 1, 0),
#          mango_dum2 = if_else(ssmango == 1, 1, 0),
#          mango_dum3 = if_else(ssmango >= 2 & ssmango <=5, 1, 0),
#          mango_dum4 = if_else(ssmango >= 6, 1, 0))
#
#
# Mode(ses$ssmango , na.rm=T)
# ses <- ses %>% select(-mango_dum3)

# * No. of papaya trees
# recode sspapaya 0=1 1=2 2/max=3, generate(papaya_g)

# ses <- ses %>%
#   mutate(sspapaya = if_else(is.na(sspapaya), Mode(sspapaya, na.rm = TRUE), sspapaya)) %>%
#   mutate(papaya_dum1 = if_else(sspapaya == 0, 1, 0),
#          papaya_dum2 = if_else(sspapaya == 1, 1, 0),
#          papaya_dum3 = if_else(sspapaya >= 2, 1, 0))
#
# Mode(ses$sspapaya , na.rm=T)
# ses <- ses %>% select(-papaya_dum1)
#
# # *No of banana trees
# # recode ssbanana 0=1 1=2 2/5=3 6/max=4, generate(banana_g)
# ses <- ses %>%
#   mutate(ssbanana = if_else(is.na(ssbanana), Mode(ssmango, na.rm = TRUE), ssbanana)) %>%
#   mutate(banana_dum1 = if_else(ssbanana == 0, 1, 0),
#          banana_dum2 = if_else(ssbanana == 1, 1, 0),
#          banana_dum3 = if_else(ssbanana >= 2 & ssbanana <=5, 1, 0),
#          banana_dum4 = if_else(ssbanana >= 6, 1, 0))
#
#
# Mode(ses$ssbanana , na.rm=T)
# ses <- ses %>% select(-banana_dum1)
#
# # * No of coconut trees
# # recode sscoconut 0=1 1=2 2/max=3, generate(coconut_g)
#
# ses <- ses %>%
#   mutate(sscoconut = if_else(is.na(sscoconut), Mode(sscoconut, na.rm = TRUE), sscoconut)) %>%
#   mutate(coconut_dum1 = if_else(sscoconut == 0, 1, 0),
#          coconut_dum2 = if_else(sscoconut == 1, 1, 0),
#         coconut_dum3 = if_else(sscoconut >= 2, 1, 0))
#
# Mode(ses$sscoconut , na.rm=T)
# ses <- ses %>% select(-coconut_dum1)
#
# # * No of jackfruit trees
# # recode ssjfruit 0=1 1=2 2/max=3, generate(jfruit_g)
# ses <- ses %>%
#   mutate(ssjfruit = if_else(is.na(ssjfruit), Mode(ssjfruit, na.rm = TRUE), ssjfruit)) %>%
#   mutate(jfruit_dum1 = if_else(ssjfruit == 0, 1, 0),
#          jfruit_dum2 = if_else(ssjfruit == 1, 1, 0),
#          jfruit_dum3 = if_else(ssjfruit >= 2, 1, 0))
#
# Mode(ses$ssjfruit , na.rm=T)
# ses <- ses %>% select(-jfruit_dum1)

#
# * Generate dummy variables for all the variables
# tab cattle_g, generate(cattle_dum)
# drop cattle_dum1
#
# tab goats_g, generate(goats_dum)
# drop goats_dum1
#
# tab chickens_g, generate(chickens_dum)
# drop chickens_dum2
#
# tab ducks_g, generate(ducks_dum)
# drop ducks_dum1
#
# tab mango_g, generate(mango_dum)
# drop mango_dum3
#
# tab papaya_g, generate(papaya_dum)
# drop papaya_dum1
#
# tab banana_g, generate(banana_dum)
# drop banana_dum1
#
# tab coconut_g, generate(coconut_dum)
# drop coconut_dum1
#
# tab jfruit_g, generate(jfruit_dum)
# drop jfruit_dum1
#
# * Before using Principal component analysis impute missing values with mode
# foreach paVars of varlist cattle_dum* goats_dum* chickens_dum* ducks_dum* mango_dum* papaya_dum* banana_dum* coconut_dum* jfruit_dum*{
# summarize `paVars'
# if r(mean)>0.5 {
#   replace `paVars'=1 if `paVars'==.
# }
# else{
# replace `paVars'=0 if `paVars'==.
# }
# }
#
# * Now use PCA
# pca cattle_dum* goats_dum* chickens_dum* ducks_dum* mango_dum* papaya_dum* banana_dum* coconut_dum* jfruit_dum*
# predict pc1
#

pai_columns <- ses_pa_dck_2 %>% select(starts_with("cattle_dum"), starts_with("goats_dum"), starts_with("ducks_dum"),
                              starts_with("chickens_dum"))

# Run PCA
pai_result <- PCA(pai_columns, ncp = 1, graph = FALSE)


# # Extract the first principal component and add it to the original dataframe
ses_pa_dck_2$pai <- pai_result$ind$coord[, 1]

# # View the updated dataset with Land Ownership Index
print(summary(pai_result))

# * Productive asset index is defined as PAI
# rename pc1 pai
#
# *---------------------------------------------------------------------------------------------------------------
# * Now construct wealth index which include all the variables used for different indices
# *
# *---------------------------------------------------------------------------------------------------------------
#
# pca gfloor_g* kitchen_g* toilet_g* sselectric rmfsize_g* ///
#     ssirrpump_g ssradios_g sscycle_g ssrickshaw_g almira_g* ssdtable_g clock_g* sssewmach_g sstv_g ssmotorc_g mobile_g* woodbedHhs_g* ///
#     crop_dum* garden_dum* grove_dum* pond_dum* home_dum* ///
#     cattle_dum* goats_dum* chickens_dum* ducks_dum* mango_dum* papaya_dum* banana_dum* coconut_dum* jfruit_dum*
# predict pc1

wi_columns <- ses_pa_dck_2 %>% select(starts_with("gfloor_g"),
                             starts_with("kitchen_g"),
                             starts_with("toilet_g"),
                             sselectric,
                             starts_with("rmfsize_g"),
                             starts_with("ssirrpump_g"),
                             starts_with("ssradios_g"),
                             starts_with("sscycle_g"),
                             starts_with("ssrickshaw_g"),
                             starts_with("almira_g"),
                             starts_with("ssdtable_g"),
                             starts_with("ssclock_g"),
                             starts_with("sssewmach_g"),
                             starts_with("sstv_g"),
                             starts_with("ssmotorc_g"),
                             starts_with("mobile_g"),
                             starts_with("sswoodbedHhs_g"),
                             starts_with("crop_dum"),
                             starts_with("garden_dum"),
                             starts_with("grove_dum"),
                             starts_with("pond_dum"),
                             starts_with("home_dum"),
                             starts_with("cattle_dum"), starts_with("goats_dum"), starts_with("chickens_dum"), starts_with("ducks_dum"),
                     #        starts_with("mango_dum"), starts_with("papaya_dum"), starts_with("coconut_dum"), starts_with("jfruit_dum")
                     )

# Run PCA
wi_result <- PCA(wi_columns, ncp = 1, graph = FALSE)

# Extract the first principal component and add it to the original dataframe
ses_pa_dck_2$wi <- wi_result$ind$coord[, 1]

# View the updated dataset with Land Ownership Index
print(summary(wi_result))

#
# * Wealth index is defined as WI
# rename pc1 wi
#
# *----------------------------------------------------------------------------------------------------------------------
# * Now keep only the SES indices and the UID variables
# keep uid dci dai lsi loi pai wi
# index_df <- ses_pa_dck_2 %>% select(uid, dci, dai, lsi, loi, pai, wi)
index_df <- ses_pa_dck_2 %>% select(uid, dci, dai, lsi, pai, wi)
#
# *------------------------------------------------------------------------------------------------------------
# * Now check the validity of the indices
# * Categorize indices in to 4 quartiles and comapre the variables used to construct indices
# *------------------------------------------------------------------------------------------------------------
#
# egen lsi_g= cut(lsi), group(4)
ses_pa_dck_2$lsi_groups <- cut(ses_pa_dck_2$lsi, breaks = 4, labels = c("Group 1", "Group 2", "Group 3", "Group 4"))

#
# tab lsi_g ssgfloor, r
round(prop.table(table(ses_pa_dck_2$lsi_groups, ses_pa_dck_2$ssgfloor), margin = 1) * 100, 2)

# tab lsi_g sskitchen, r
round(prop.table(table(ses_pa_dck_2$lsi_groups, ses_pa_dck_2$sskitchen), margin = 1) * 100, 2)

# tab lsi_g sstoilet, r
round(prop.table(table(ses_pa_dck_2$lsi_groups, ses_pa_dck_2$sstoilet), margin = 1) * 100, 2)


table(ses_pa_dck_2$ssclock)
table(ses_pa_dck_2$sswoodbed)

colnames(ses_pa_dck_2)
# indices <- ses_pa_dck_2 %>% select(c("uid", "tlpin", "sector", "hhid", "ssdate", "dci", "dai", "lsi", "loi", "pai", "wi", "lsi_groups"))
indices <- ses_pa_dck_2 %>% select(c("uid", "tlpin", "sector", "hhid", "ssdate", "dci", "dai", "lsi", "pai", "wi", "lsi_groups"))
write_csv(indices, "indices_wra.csv")
#https://www.gastonsanchez.com/visually-enforced/how-to/2012/06/17/PCA-in-R/
