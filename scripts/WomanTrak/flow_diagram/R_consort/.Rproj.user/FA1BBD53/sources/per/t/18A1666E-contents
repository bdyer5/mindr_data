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
# library(tinytex)
# install_tinytex()
# install.packages("htmlwidgets")
library(htmlwidgets)
# source("./ids_exist_function.R")

# df <- read_dta("C:/Users/bdyer/OneDrive - Johns Hopkins/CHN/JiVitA/MiNDR/data/datasets/2024-09-12/stata/wtrak_pw.dta")

df <- read_dta("C:/Users/bdyer/OneDrive - Johns Hopkins/CHN/JiVitA/MiNDR/data/datasets/20241015_2024-11-18/stata/PW_study/pregtrak.dta")
 # women eligible for pregnancy surveilance 
wtrak_pw <- df 

wtrak_pw_p <- wtrak_pw
wtrak_pw_p$mpf_status <- as.numeric(wtrak_pw_p$mpf_status)
wtrak_pw_p$mpfb_status <- as.numeric(wtrak_pw_p$mpfb_status)
wtrak_pw_p$lpf_status <- as.numeric(wtrak_pw_p$lpf_status)
wtrak_pw_p$lpfb_status <- as.numeric(wtrak_pw_p$lpfb_status)
wtrak_pw_p$outc <- as.numeric(wtrak_pw_p$outc)

wtrak_pw_p %>% count(pefb_status)
wtrak_pw_p %>% count(mpfb_status)
wtrak_pw_p %>% count(lpfb_status)
wtrak_pw_p %>% count(lpf_status)
wtrak_pw_p %>% count(outc)
wtrak_pw_p %>% count(saf_flow_status)
wtrak_pw_p %>% count(mid_preg_status)


# # pregnancies detected 
# preg_pw <- wtrak_pw %>% 
#   filter(psfurt==1 )
# 
# preg_pw_consent <- preg_pw %>% 
#   filter(consent==1)
# 
# preg_pw_consent_w <- preg_pw_consent %>% 
#   filter(arm_pw=="W")
# preg_pw_consent_x <- preg_pw_consent %>% 
#   filter(arm_pw=="X")
# preg_pw_consent_y <- preg_pw_consent %>% 
#   filter(arm_pw=="Y")
# preg_pw_consent_z <- preg_pw_consent %>% 
#   filter(arm_pw=="Z")
# 
# 
# wtrak_pw %>% count(consent)
wtrak_pw_prepped <- wtrak_pw_p %>% 
  mutate(pregnant=case_when(psfurt==1 ~"pregnant",
                            TRUE ~as.character(NA))
         ,consented=case_when(pef_consent==1 ~"consented",
                              TRUE ~as.character(NA)),
         
         # pregnancies_not=case_when(psfurt!=1 ),
         pef_status_desc=case_when(
           is.na(pef_status) & pef_eligible==0 ~"PEF - ineligible",
           is.na(pef_status) & pef_eligible==1  ~"PEF - pending interview",
           pef_status==1  & pef_eligible==1 & pef_consent==1  ~"PEF - met - consented",
           pef_status==1  & pef_eligible==1 & pef_consent==6  ~"PEF - met - refused consented",
           pef_status==1  & pef_eligible==1 & pef_consent==3  ~"PEF - met - pending consent",
           pef_status==1  & pef_eligible==1  ~"pef - met",
           pef_status==2  & pef_eligible==1  ~"Not met (up to 17 weeks post-LMP)",
           pef_status==3  & pef_eligible==1  ~"Woman had Menstrual Regulation",
           pef_status==4  & pef_eligible==1  ~"Woman had Miscarriage",
           pef_status==6  & pef_eligible==1  ~"Woman refused PEF",
           pef_status==7  & pef_eligible==1  ~"Woman permanently moved",
           pef_status==8  & pef_eligible==1  ~"Woman Died' end as pef_status_desc"
         )) %>% 
  mutate(pef_not_consented=case_when(pef_status_desc=="PEF - met - consented" ~as.character(NA),
                                     TRUE ~as.character(pef_status_desc)),
         consented2=consented,
         arm_pw=case_when(arm_pw==""  ~as.character(NA),
                          is.na(consented) ~as.character(NA),
                          TRUE ~as.character(arm_pw)),
         
         saf_flow_status_desc=case_when(pef_consent==1 & saf_flow_status ==1 ~"SAF - Met",
                                        pef_consent==1 & saf_flow_status ==2 ~"SAF - Not Met",
                                        pef_consent==1 & saf_flow_status ==3 ~"SAF - Met over phone",
                                        pef_consent==1 & saf_flow_status ==4 ~"SAF - Miscarriage",
                                        pef_consent==1 & saf_flow_status ==5 ~"SAF - Menstrual Regulation ",
                                        pef_consent==1 & saf_flow_status ==6 ~"SAF - Live Birth",
                                        pef_consent==1 & saf_flow_status ==7 ~"SAF - Still Birth",
                                        pef_consent==1 & saf_flow_status ==8 ~"SAF - Not observed due to fasting",
                                        pef_consent==1 & saf_flow_status ==60 ~"Refused PEF Blood visit",
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
           pef_consent==1 & saf_flow_status ==60 ~"Refused PEF Blood visit",
           pef_consent==1 & saf_flow_status ==61 ~"Discontinued due to 16 wk GA (Ultrasound)",
           pef_consent==1 & saf_flow_status ==62 ~"Discontinued (PX)",
           pef_consent==1 & saf_flow_status ==63 ~"Menstrual Regulation",
           pef_consent==1 & saf_flow_status ==64 ~"Miscarriage",
           pef_consent==1 & saf_flow_status ==65 ~"Refused Ultrasound",
           pef_consent==1 & saf_flow_status ==66 ~"Refused",
           pef_consent==1 & saf_flow_status ==67 ~"Permanent Move",
           pef_consent==1 & saf_flow_status ==68 ~"Died",
           pef_consent==1 & saf_flow_status ==69 ~"PX Data Midline Discontinuation of supplement",
           pef_consent==1 & saf_flow_status ==70 ~"PX_Data LP Discontinuation of supplement",
           pef_consent==1 & saf_flow_status ==71 ~"Discontinued due to 16 wk GA (Ultrasound)",
           pef_consent==1 & saf_flow_status ==77 ~"Permanent Move",
           pef_consent==1 & saf_flow_status ==88 ~"Died",
           TRUE ~as.character(NA)),
         supplemented=case_when(pef_consent==1 & saf_flow_status ==1 ~"Started Supplementation",
                                pef_consent==1 & saf_flow_status ==3 ~"Started Supplementation",
                                TRUE ~as.character(NA))
  ) %>% 
  mutate(mpf_met=case_when(!is.na(supplemented) & mpf_status ==1 & mpfb_status==1 ~"Mid-pregnancy visits",
                           TRUE ~as.character(NA)
  ),
  consented2=consented,
  mpf_not=case_when(
    !is.na(supplemented) & mpf_status ==1 & (is.na(mpfb_status) | trimws(mpfb_status)=="") ~"Pending MPF Specimen",
    !is.na(supplemented) & mpf_status ==1 & mpfb_status==2 ~"MPF done - MPF Specimen - Not met ",
    !is.na(supplemented) & mpf_status ==66 ~"Refused MPF",
    !is.na(supplemented) & mpf_status ==2 ~"Not met (up to 35 weeks GA)",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 2 ~"No supplementation before MPF",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 66 ~"Refused further study participation",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 3 ~"Outcome before the mid pregnancy visit",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 6 ~"Pending a Mid - pregnancy visit",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 8 ~"Discontinued due to PX data at the midline visit",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & is.na(mid_preg_status) ~"Under follow-up",
    !is.na(supplemented) & mpf_status ==6 ~"Still birth",
    !is.na(supplemented) & mpf_status ==3 ~"MR",
    !is.na(supplemented) & mpf_status ==4 ~"Miscarriage",
    !is.na(supplemented) & mpf_status ==5 ~"Live birth",
    TRUE ~as.character(NA)),
  mpf_not2=case_when(
    !is.na(supplemented) & mpf_status ==1 & (is.na(mpfb_status) | trimws(mpfb_status)=="") ~"Pending MPF Specimen",
    !is.na(supplemented) & mpf_status ==1 & mpfb_status==2 ~"MPF done - MPF Specimen - Not met ",
    !is.na(supplemented) & mpf_status ==66 ~"Refused MPF",
    !is.na(supplemented) & mpf_status ==2 ~"Not met (up to 35 weeks GA)",
    # !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 2 ~"No supplementation before MPF",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 66 ~"Refused further study participation",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 3 ~"Outcome before the mid pregnancy visit",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 6 ~"Pending a Mid - pregnancy visit",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 8 ~"Discontinued due to PX data at the midline visit",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & is.na(mid_preg_status) ~"Under follow-up",
    !is.na(supplemented) & mpf_status ==6 ~"Still birth",
    !is.na(supplemented) & mpf_status ==3 ~"MR",
    !is.na(supplemented) & mpf_status ==4 ~"Miscarriage",
    !is.na(supplemented) & mpf_status ==5 ~"Live birth",
    TRUE ~as.character(NA)),
  mpf_not3=case_when(
    !is.na(supplemented) & mpf_status ==1 & (is.na(mpfb_status) | trimws(mpfb_status)=="") ~"Pending MPF Specimen",
    # !is.na(supplemented) & mpf_status ==1 & mpfb_status==2 ~"MPF done - MPF Specimen - Not met ",
    !is.na(supplemented) & mpf_status ==66 ~"Refused MPF",
    # !is.na(supplemented) & mpf_status ==2 ~"Not met (up to 35 weeks GA)",
    # !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 2 ~"No supplementation before MPF",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 66 ~"Refused further study participation",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 3 ~"Outcome before the mid pregnancy visit",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 6 ~"Pending a Mid - pregnancy visit",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 8 ~"Discontinued due to PX data at the midline visit",
    !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & is.na(mid_preg_status) ~"Under follow-up",
    !is.na(supplemented) & mpf_status ==6 ~"Still birth",
    !is.na(supplemented) & mpf_status ==3 ~"MR",
    !is.na(supplemented) & mpf_status ==4 ~"Miscarriage",
    !is.na(supplemented) & mpf_status ==5 ~"Live birth",
    TRUE ~as.character(NA))
  ) %>% 
  mutate(mpf_temp_out=case_when(mpf_not %in% c("Not met (up to 35 weeks GA)","No supplementation before MPF","MPF done - MPF Specimen - Not met ","Refused MPF","Under follow-up") ~as.character(mpf_not),
                                TRUE ~as.character(NA)),
         lpf_met=case_when(!is.na(mpf_met) & lpf_status ==1 & lpfb_status ==1 ~"Late pregnancy visits",
                           is.na(mpf_met) & lpf_status ==1 & lpfb_status ==1 & mid_preg_status== 2 ~"Late pregnancy visits",
                           !is.na(supplemented)  & lpf_status ==1 & lpfb_status ==1 & mpf_status ==2 ~"Late pregnancy visits",
                           TRUE ~as.character(NA)),
         lpf_not=case_when(
           # !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & outc==5 ~"Live birth",
           # !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & outc==6 ~"Still birth",
           !is.na(supplemented) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="")  & mid_preg_status== 2 & outc==5 ~"Live birth",
           !is.na(supplemented) & (!is.na(lpf_status))  & (is.na(lpfb_status))  & mid_preg_status== 2 & outc==5 ~"Live birth",
           !is.na(supplemented) & (!is.na(lpf_status))  & (lpfb_status==66)  & mid_preg_status== 2 & outc==5 ~"Refused LPF",
           !is.na(supplemented) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="")  & mid_preg_status== 2 & outc==6 ~"Still born",
           !is.na(supplemented) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="")  & mid_preg_status== 2 & outc==8 ~"1 live born / 1 still born",
           
           !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & late_preg_status==3 & outc==6 ~"Still born",
           !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & late_preg_status==3 & outc==8 ~"1 live born / 1 still born",
           !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & late_preg_status==3 & outc==5 ~"Live birth",
           !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & late_preg_status==3 ~"outcome before LPF visit",
           # !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & late_preg_status==3 & (is.na(outc) | outc=="") ~"outcome before LPF visit",
           !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & late_preg_status==7 ~"Discontinued due to PX from mid-pregnancy visit",
           !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & late_preg_status==4 ~"outcome happened just after LPF visit sched.",
           !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & late_preg_status==6 & (is.na(outc) | outc=="") ~"Not eligible for LPF visit yet",
           !is.na(mpf_met) & (is.na(lpf_status) | trimws(lpf_status) =="")  & (is.na(lpfb_status) | trimws(lpfb_status)=="") & outc!=5 ~"Under follow-up",
           !is.na(mpf_met) & lpf_status ==1 & (is.na(lpfb_status) | trimws(lpfb_status)=="") ~"Pending LPF Specimen",
           !is.na(mpf_met) & lpf_status ==66 ~"Refused LPF",
           !is.na(mpf_met) & lpf_status ==2 ~"Not met (up to any outcome)",
           !is.na(supplemented)  & (lpf_status ==2 | lpfb_status ==2) & mpf_status ==2 ~"Not met (up to any outcome)",
           !is.na(mpf_met) & lpf_status ==6 ~"Still birth",
           !is.na(mpf_met) & lpf_status ==3 ~"MR",
           !is.na(mpf_met) & lpf_status ==4 ~"Miscarriage",
           !is.na(mpf_met) & lpf_status ==5 ~"Live birth",
           TRUE ~as.character(NA))) %>% 
  mutate(
    # mpf_not=case_when(!is.na(mpf_temp_out) ~as.character(NA),TRUE ~as.character(mpf_not)),
    live_births=case_when(!is.na(lpf_met) & outc==5 ~"Live birth",
                          TRUE ~as.character(NA)),
    live_births_not=case_when(!is.na(lpf_met) & (is.na(outc)) ~"Pending outcome",
                              !is.na(lpf_met) & outc ==2 ~"Miscarriage",
                              !is.na(lpf_met) & lpf_status ==6 ~"Still birth",
                              !is.na(lpf_met) & lpf_status ==0 ~"No outcome reported",
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
wtrak_pw_prepped %>% count(lpf_status)
wtrak_pw_prepped %>% count(mid_preg_status)
wtrak_pw_prepped %>% count(mpf_status)
wtrak_pw_prepped %>% count(mpfb_status)
wtrak_pw_prepped %>% count(lpf_not)
wtrak_pw_prepped %>% count(live_births)
wtrak_pw_prepped %>% count(live_births_not)
wtrak_pw_prepped %>% count(arm_pw)
wtrak_pw_prepped %>% count(late_preg_status)
wtrak_pw_prepped %>% count(mpf_temp_out)
wtrak_pw_prepped %>% count(lpf_not,arm_pw) %>% print(n = Inf)

wtrak_pw_prepped %>% count(mpf_not,mid_preg_status)
wtrak_pw_prepped %>% count(late_preg_status,arm_pw)

wtrak_pw_prepped_no_sup_bef_ml <- wtrak_pw_prepped %>% 
filter(!is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 2) %>% 
arrange(arm_pw)

wtrak_pw_prepped_no_sup_bef_ml_lpfb <- wtrak_pw_prepped_no_sup_bef_ml %>% 
filter(lpf_status==1 & lpfb_status==1) %>% 
arrange(arm_pw) %>% 
  rename(no_supp_bef_mpf_w_lpf=arm_pw)

wtrak_pw_prepped_no_sup_bef_ml_lpfb %>% count(no_supp_bef_mpf_w_lpf)

wtrak_pw_prepped_mpf_nmlt <- wtrak_pw_prepped %>% 
  filter(mpf_not=="Not met (up to 35 weeks GA)")

wtrak_pw_prepped_mpf_uf <- wtrak_pw_prepped %>% 
  filter(mpf_not=="Under follow-up")

wtrak_pw_prepped_lpf_uf <- wtrak_pw_prepped %>% 
  filter(lpf_not=="Under follow-up")

wtrak_pw_prepped_mpf_refused_stdy <- wtrak_pw_prepped %>% 
  filter(mpf_not=="Refused further study participation")
writeLines(wtrak_pw_prepped_mpf_refused_stdy$uid)


wtrak_pw_prepped_x_lpf_stat <- wtrak_pw_prepped %>% 
  filter(!is.na(mpf_met) & (is.na(lpf_status) | lpf_status==2 | (lpf_status==1 & is.na(lpfb_status)) )  & (is.na(lpfb_status) | lpfb_status==2 ) & arm_pw=="X")

late_preg_status_4 <- wtrak_pw_prepped %>% 
  filter(late_preg_status==4)


writeLines(wtrak_pw_prepped_mpf_uf$uid)
writeLines(wtrak_pw_prepped_mpf_nmlt$uid)

# All of these should get pulled back in to the LPF calculation 

# "Not met (up to 35 weeks GA)" should get pulled backin 
# No supplementation before MPF should get pulled backin 
# MPF done − MPFB Specimen − Not met (n=1) should get pulled back in 
# Refused MPF
# Under followup 
# Pending MPF Specimen



# 
# !is.na(supplemented) & mpf_status ==1 & (is.na(mpfb_status) | trimws(mpfb_status)=="") ~"Pending MPF Specimen",
# !is.na(supplemented) & mpf_status ==1 & mpfb_status==2 ~"MPF done - MPF Specimen - Not met ",
# !is.na(supplemented) & mpf_status ==66 ~"Refused MPF",
# !is.na(supplemented) & mpf_status ==2 ~"Not met (up to 35 weeks GA)",
# !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 2 ~"No supplementation before MPF",
# !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 3 ~"Outcome before the mid pregnancy visit",
# !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 6 ~"Pending a Mid - pregnancy visit",
# !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & mid_preg_status== 8 ~"Discontinued due to PX data at the midline visit",
# !is.na(supplemented) & (is.na(mpf_status) | trimws(mpf_status) =="")  & (is.na(mpfb_status) | trimws(mpfb_status)=="") & is.na(mid_preg_status) ~"Under follow-up",
# !is.na(supplemented) & mpf_status ==6 ~"Still birth",
# !is.na(supplemented) & mpf_status ==3 ~"MR",
# !is.na(supplemented) & mpf_status ==4 ~"Miscarriage",
# !is.na(supplemented) & mpf_status ==5 ~"Live birth",

wtrak_pw_prepped_back_in <- wtrak_pw_prepped %>% 
  filter(mpf_not %in% c("Not met (up to 35 weeks GA)","No supplementation before MPF","MPF done - MPF Specimen - Not met ","Refused MPF","Under follow-up"))







wtrak_pw_prepped %>% count(saf_flow_status)

wtrak_pw_prepped_uvf_ref <- wtrak_pw_prepped %>% 
  filter(saf_flow_status==65)


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
p <- consort_plot(
  data = wtrak_pw_prepped,
  orders = list(
    c(uid = "Women eligible for pregnancy surveillance"),
    c(pregnant = "Pregnancies detected"),
    c(pef_not_consented = ""),
    # c(consented = "Pregnant Women consented and randomized"),
    c(arm_pw = "Pregnant Women consented and randomized"),
    c(consented2 = "Pregnant Women enrolled"),
    c(not_supplemented = ""),
    c(supplemented = "Started supplementation"),
    # c(mpf_temp_out = "Temporary takeout after supplementation"),  # Add as main flow
    c(mpf_not = ""),
    c(mpf_met = "Mid-pregnancy visits"),
    c(lpf_not = ""),
    c(lpf_met = "Late-pregnancy visits"),
    c(live_births_not = ""),
    c(live_births = "Pregnancies with live infants")
  ),
  side_box = c("pef_not_consented", "not_supplemented", "mpf_not", "lpf_not", "live_births_not"),
  allocation = c("arm_pw"),
  labels = c("3" = "Randomization", "5" = "Enrollment", "9" = "Outcomes"),
  cex = 1.5
)

a<- add_side_box(p, "live_births" )


# p <- consort_plot(data = df,
#                   orders = list(c(trialno = "Population"),
#                                 c(exclusion = "Excluded"),
#                                 c(arm_pw     = "Randomized patient"),
#                                 c(arm3     = "", 
#                                   subjid_notdosed="Participants not treated"),
#                                 c(followup    = "Pariticpants planned for follow-up",
#                                   lost_followup = "Reason for tot followed"),
#                                 c(assessed = "Assessed for final outcome"),
#                                 c(no_value = "Reason for not assessed"),
#                                 c(mitt = "Included in the mITT analysis")),
#                   side_box = c("exclusion", "no_value"),
#                   allocation = c("arm_pw", "arm3"),
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

# Consort option 2 

eligible <-  nrow(wtrak_pw_prepped)

txt1 <- paste("Women eligible for pregnancy surveillance (n=",eligible,")")
txt1_side <- "Excluded (n=15):\n\u2022 MRI not collected (n=3)\n\u2022 Tissues not collected (n=4)\n\u2022 Other (n=8)"

# supports pipeline operator
g <- add_box(txt = txt1) |>
  add_side_box(txt = txt1_side) |> 
  add_box(txt = "Randomized (n=200)") |> 
  add_split(txt = c("Arm A (n=100)", "Arm B (n=100)")) |> 
  add_side_box(txt = c("Excluded (n=15):\n\u2022 MRI not collected (n=3)\n\u2022 Tissues not collected (n=4)\n\u2022 Other (n=8)",
                       "Excluded (n=7):\n\u2022 MRI not collected (n=3)\n\u2022 Tissues not collected (n=4)")) |> 
  add_box(txt = c("Final analysis (n=85)", "Final analysis (n=93)")) |> 
  add_label_box(txt = c("1" = "Screening",
                        "3" = "Randomized",
                        "4" = "Final analysis"))
plot(g)

