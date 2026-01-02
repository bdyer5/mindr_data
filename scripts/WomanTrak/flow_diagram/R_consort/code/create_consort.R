rm(list=ls())

setwd("C:/Users/bdyer/OneDrive - Johns Hopkins/CHN/JiVitA/MiNDR/data/scripts/WomanTrak/flow_diagram/R_consort/code")
library(tidyr)
library(dplyr)
library(tidyverse)
library(readxl)
library(REDCapR)
library(consortr)
library(haven)
library(patchwork)
library(consort)
library(tinytex)
install_tinytex()
# install.packages("htmlwidgets")
library(htmlwidgets)
# source("./ids_exist_function.R")

df <- read_dta("C:/Users/bdyer/OneDrive - Johns Hopkins/CHN/JiVitA/MiNDR/data/datasets/2024-09-12/stata/wtrak_pw.dta")

 # women eligible for pregnancy surveilance 
wtrak_pw <- df %>% 
  filter(woman_status!=8)
# 
# # pregnancies detected 
# preg_pw <- wtrak_pw %>% 
#   filter(psfurt==1 )
# 
# preg_pw_consent <- preg_pw %>% 
#   filter(peconsent==1)
# 
# preg_pw_consent_w <- preg_pw_consent %>% 
#   filter(allocated_arm=="W")
# preg_pw_consent_x <- preg_pw_consent %>% 
#   filter(allocated_arm=="X")
# preg_pw_consent_y <- preg_pw_consent %>% 
#   filter(allocated_arm=="Y")
# preg_pw_consent_z <- preg_pw_consent %>% 
#   filter(allocated_arm=="Z")
# 
# 
# wtrak_pw %>% count(peconsent)
wtrak_pw_prepped <- wtrak_pw %>% 
  mutate(pregnant=case_when(psfurt==1 ~"pregnant",
                            TRUE ~as.character(NA))
         ,consented=case_when(peconsent==1 ~"consented",
                             TRUE ~as.character(NA)),
        
         # pregnancies_not=case_when(psfurt!=1 ),
         pef_status_desc=case_when(
           is.na(pefstatus) & pef_eligible==0 ~"PEF - ineligible",
           is.na(pefstatus) & pef_eligible==1  ~"PEF - pending interview",
           pefstatus==1  & pef_eligible==1 & pef_consent==1  ~"PEF - met - consented",
           pefstatus==1  & pef_eligible==1 & pef_consent==6  ~"PEF - met - refused consented",
           pefstatus==1  & pef_eligible==1 & pef_consent==3  ~"PEF - met - pending consent",
           pefstatus==1  & pef_eligible==1  ~"pef - met",
           pefstatus==2  & pef_eligible==1  ~"Not met (up to 17 weeks post-LMP)",
           pefstatus==3  & pef_eligible==1  ~"Woman had Menstrual Regulation",
           pefstatus==4  & pef_eligible==1  ~"Woman had Miscarriage",
           pefstatus==6  & pef_eligible==1  ~"Woman refused PEF",
           pefstatus==7  & pef_eligible==1  ~"Woman permanently moved",
           pefstatus==8  & pef_eligible==1  ~"Woman Died' end as pef_status_desc"
           )) %>% 
  mutate(pef_not_consented=case_when(pef_status_desc=="PEF - met - consented" ~as.character(NA),
                                     TRUE ~as.character(pef_status_desc)),
         consented2=consented,
         allocated_arm=case_when(allocated_arm==""  ~as.character(NA),
                                 is.na(consented) ~as.character(NA),
                                 TRUE ~as.character(allocated_arm)),
         
         saf_flow_status_desc=case_when(pef_consent==1 & saf_flow_status ==1 ~"SAF - Met",
                                       pef_consent==1 & saf_flow_status ==2 ~"SAF - Not Met",
                                       pef_consent==1 & saf_flow_status ==3 ~"SAF - Met over phone",
                                       pef_consent==1 & saf_flow_status ==4 ~"SAF - Miscarriage",
                                       pef_consent==1 & saf_flow_status ==5 ~"SAF - Menstrual Regulation ",
                                       pef_consent==1 & saf_flow_status ==6 ~"SAF - Live Birth",
                                       pef_consent==1 & saf_flow_status ==7 ~"SAF - Still Birth",
                                       pef_consent==1 & saf_flow_status ==8 ~"SAF - Not observed due to fasting",
                                       pef_consent==1 & saf_flow_status ==61 ~"SAF - discontinued due to USG GA > 16  ",
                                       pef_consent==1 & saf_flow_status ==62 ~"SAF - discontinued due to PX measure",
                                       pef_consent==1 & saf_flow_status ==63 ~"UVF - Menstrual Regulation",
                                       pef_consent==1 & saf_flow_status ==64 ~"UVF - Miscarriage",
                                       pef_consent==1 & saf_flow_status ==65 ~"UVF - Refused interview",
                                       pef_consent==1 & saf_flow_status ==66 ~"SAF - Refused",
                                       pef_consent==1 & saf_flow_status ==67 ~"UVF - Permanent Move",
                                       pef_consent==1 & saf_flow_status ==68 ~"UVF - Died",
                                       pef_consent==1 & saf_flow_status ==77 ~"SAF - Permanently moved",
                                       pef_consent==1 & saf_flow_status ==88 ~"SAF - Died",
                                       TRUE ~as.character(NA)),
         not_supplemented=case_when(
                                        pef_consent==1 & saf_flow_status ==2 ~"Not Met",
                                        # pef_consent==1 & saf_flow_status ==3 ~"Met over phone",
                                        pef_consent==1 & saf_flow_status ==4 ~"Miscarriage",
                                        pef_consent==1 & saf_flow_status ==5 ~"Menstrual Regulation",
                                        pef_consent==1 & saf_flow_status ==6 ~"Live Birth",
                                        pef_consent==1 & saf_flow_status ==7 ~"Still Birth",
                                        pef_consent==1 & saf_flow_status ==8 ~"Not observed due to fasting",
                                        pef_consent==1 & saf_flow_status ==61 ~"Discontinued due to 16 wk GA (Ultrasound)",
                                        pef_consent==1 & saf_flow_status ==62 ~"Discontinued (PX)",
                                        pef_consent==1 & saf_flow_status ==63 ~"Menstrual Regulation",
                                        pef_consent==1 & saf_flow_status ==64 ~"Miscarriage",
                                        pef_consent==1 & saf_flow_status ==65 ~"Refused Ultrasound",
                                        pef_consent==1 & saf_flow_status ==66 ~"Refused",
                                        pef_consent==1 & saf_flow_status ==67 ~"Permanent Move",
                                        pef_consent==1 & saf_flow_status ==68 ~"Died",
                                        pef_consent==1 & saf_flow_status ==77 ~"Permanent Move",
                                        pef_consent==1 & saf_flow_status ==88 ~"Died",
                                        TRUE ~as.character(NA)),
         supplemented=case_when(pef_consent==1 & saf_flow_status ==1 ~"Started Supplementation",
                                pef_consent==1 & saf_flow_status ==3 ~"Started Supplementation",
                                TRUE ~as.character(NA))
          ) %>% 
  mutate(mpf_met=case_when(!is.na(supplemented) & mpf_status =="01" & mpfb_status=="01" ~"Mid-pregnancy visits",
                           TRUE ~as.character(NA)
                            ),
         consented2=consented,
         mpf_not=case_when(!is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") ~"Under follow-up",
           !is.na(supplemented) & mpf_status =="01" & (is.na(mpfb_status) | trimws(mpfb_status)=="") ~"Pending MPF Specimen",
                           !is.na(supplemented) & mpf_status =="66" ~"Refused MPF",
                           !is.na(supplemented) & mpf_status =="02" ~"Not met (up to 35 weeks GA) ",
                           !is.na(supplemented) & mpf_status =="06" ~"Still birth",
                           !is.na(supplemented) & mpf_status =="03" ~"MR",
                           !is.na(supplemented) & mpf_status =="04" ~"Miscarriage",
                           !is.na(supplemented) & mpf_status =="05" ~"Live birth",
                           TRUE ~as.character(NA))) %>% 
  mutate(lpf_met=case_when(!is.na(mpf_met) & lpf_status =="01"& lpfb_status =="01" ~"Late pregnancy visits",
                           TRUE ~as.character(NA)),
         lpf_not=case_when(!is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & bgoutc!="05" ~"Under follow-up",
                           !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & bgoutc=="05" ~"Live birth",
                           !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & bgoutc=="06" ~"Still birth",
                           !is.na(mpf_met) & lpf_status =="01" & (is.na(lpfb_status) | trimws(lpfb_status)=="") ~"Pending LPF Specimen",
                           !is.na(mpf_met) & lpf_status =="66" ~"Refused LPF",
                           !is.na(mpf_met) & lpf_status =="02" ~"Not met (up to any outcome)",
                           !is.na(mpf_met) & lpf_status =="06" ~"Still birth",
                           !is.na(mpf_met) & lpf_status =="03" ~"MR",
                           !is.na(mpf_met) & lpf_status =="04" ~"Miscarriage",
                           !is.na(mpf_met) & lpf_status =="05" ~"Live birth",
                           TRUE ~as.character(NA))) %>% 
  mutate(live_births=case_when(!is.na(lpf_met) & bgoutc=="05" ~"Live birth",
                               TRUE ~as.character(NA)),
         live_births_not=case_when(!is.na(lpf_met) & (is.na(bgoutc) | trimws(bgoutc) =="") ~"Pending outcome",
                                   !is.na(lpf_met) & bgoutc =="02" ~"Miscarriage",
                                   !is.na(lpf_met) & lpf_status =="06" ~"Still birth",
                                   !is.na(lpf_met) & lpf_status =="00" ~"No outcome reported",
                                   TRUE ~as.character(NA)))


wtrak_pw_prepped %>% count(pregnant)
wtrak_pw_prepped %>% count(uid)
wtrak_pw_prepped %>% count(pef_status_desc)
wtrak_pw_prepped %>% count(consented)
wtrak_pw_prepped %>% count(consented2)
wtrak_pw_prepped %>% count(not_supplemented)
wtrak_pw_prepped %>% count(saf_flow_status_desc)
wtrak_pw_prepped %>% count(supplemented)
wtrak_pw_prepped %>% count(mpf_met)
wtrak_pw_prepped %>% count(mpf_not)
wtrak_pw_prepped %>% count(lpf_met)
wtrak_pw_prepped %>% count(lpf_not)
wtrak_pw_prepped %>% count(live_births)
wtrak_pw_prepped %>% count(live_births_not)
wtrak_pw_prepped %>% count(allocated_arm)



# 246 ineligible gestational age (>=17 weeks)
# 9 Miscarriage
# 32 MR
# 1 Refused Consent
# 28 Enrolment pending


# 3 Miscarriage
# 1 Discontinued due to 16wk GA (ultrasound)
# 5 Discontinued (PX)
# 5 Supplementation visit pending
# 1 Refusing Supplementation/not met  
# 2 Refused Ultrasound


data(dispos.data)


df <- dispos.data[!dispos.data$arm3 %in% "Trt C", ]
p <- consort_plot(data = wtrak_pw_prepped,
                  orders = list(c(uid = "Women eligible for pregnancy surveilance"),
                                c(pregnant = "Pregnancies detected"),
                                c(pef_not_consented=" a"),
                                c(consented="Pregnant Women consented and randomized"),
                                # c(pef_not_consented=" nc"),
                                c(allocated_arm = " Arm"),
                                c(consented2="Pregnant Women enrolled"),
                                c(not_supplemented = " b"),
                                c(supplemented = "started supplementation"),
                                c(mpf_not = " c"),
                                c(mpf_met = "Mid-pregnancy visits"),
                                c(lpf_not = "de"),
                                c(lpf_met = "LPF-pregnancy visits"),
                                c(live_births_not = "eks"),
                                c(live_births = "live born infants")),
                  side_box = c("pef_not_consented", "not_supplemented","mpf_not","lpf_not","live_births_not"),
                  allocation = c("allocated_arm"),
                  labels = c("1" = "Screening", "2" = "Randomization",
                             "5" = "Follow-up", "7" = "Final analysis"),
                  cex = 0.7
)


# p <- consort_plot(data = df,
#                   orders = list(c(trialno = "Population"),
#                                 c(exclusion = "Excluded"),
#                                 c(arm     = "Randomized patient"),
#                                 c(arm3     = "", 
#                                   subjid_notdosed="Participants not treated"),
#                                 c(followup    = "Pariticpants planned for follow-up",
#                                   lost_followup = "Reason for tot followed"),
#                                 c(assessed = "Assessed for final outcome"),
#                                 c(no_value = "Reason for not assessed"),
#                                 c(mitt = "Included in the mITT analysis")),
#                   side_box = c("exclusion", "no_value"),
#                   allocation = c("arm", "arm3"),
#                   labels = c("1" = "Screening", "2" = "Randomization",
#                              "5" = "Follow-up", "7" = "Final analysis"),
#                   cex = 0.7)
# 
plot(p)



# Save the plot as an HTML file
htmlwidgets::saveWidget(as_widget(p), "consort_plot.html")


out <- consort_plot(data = wtrak_pw,
                    orders = c(uid = "Women eligible for pregnancy surveilance",
                               # exclusion = "Excluded",
                               psfurt = "Pregnancies detected",
                               consented = "Pregnant women consented and randomized"
                               # subjid_notdosed = "Not dosed",
                               # followup = "Followup",
                               # lost_followup = "Not evaluable for the final analysis",
                               # mitt = "Final Analysis"
                               ),
                    side_box = c(""),
                    cex = 0.9)



# print'Started Pregnancy Surveilance' 
# select * from wtrak_pw where 
# last_psf_status is not null 


# Step 1: Define the overall structure of the CONSORT diagram
participants <- add_box("Participants assessed for eligibility (n = 500)")

# Step 2: Add stages of exclusion
excluded <- add_side_box(participants, "Excluded (n = 100)\n- Not meeting inclusion criteria (n = 70)\n- Declined to participate (n = 30)")

# Step 3: Define the groups after randomization
randomized <- add_box(participants, "Randomized (n = 400)")

# Step 4: Add treatment groups
group_a <- add_box(randomized, "Allocated to intervention X (n = 200)")
group_b <- add_box(randomized, "Allocated to intervention Y (n = 200)")

# Step 5: Add follow-up and exclusion during study
group_a_followup <- add_box(group_a, "Lost to follow-up (n = 10)")
group_b_followup <- add_box(group_b, "Lost to follow-up (n = 15)")

# Step 6: Add analysis groups
group_a_analysis <- add_box(group_a, "Analyzed (n = 190)")
group_b_analysis <- add_box(group_b, "Analyzed (n = 185)")

# Step 7: Plot the diagram
flow_diagram(participants)

