 cd "./"
#delimit ;
clear;
/*wra_vf*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\wtrak_wra.log", replace;
odbc load,exec("
SELECT
uid,
tlpin,
sector,
hhid,
allocated_arm as arm,
bgdob as wom_dob,
/*age,*/
/*age_grp,*/
convert(smalldatetime,dod,121) as wom_dod,
convert(smalldatetime,blood_cal_date_15b,121) as blood_date_15b,
blood_cal_status_15b as blood_status_15b,
convert(smalldatetime,blood_cal_date_3b,121) as blood_date_3b,
blood_cal_status_3b as blood_status_3b,
convert(smalldatetime,blood_cal_date_eb,121) as blood_date_eb,
blood_cal_status_eb as blood_status_eb,
consent,
convert(smalldatetime,consent_date,121) as consent_date,
drf1_complete,
convert(smalldatetime,drf1_done_date,121) as drf1_done_date,
drf1_status,
convert(smalldatetime,drf2_done_date,121) as drf2_done_date,
drf2_status,
convert(smalldatetime,drf3_done_date,121) as drf3_done_date,
drf3_status,
enroll_id_age,
enroll_id_overall,
husband_name,
mobile,
rpt_drf_eligible,
sadf1,
sadfp1,
convert(smalldatetime,saf_done_date,121) as saf_done_date,
saf_past_order,
convert(smalldatetime,saf_start,121) as saf_start,
saf_status,
selection_status,
convert(smalldatetime,serf_14d_done_date,121) as serf_14d_done_date,
serf_14d_saf_stop,
serf_14d_status,
convert(smalldatetime,serf_7d_done_date,121) as serf_7d_done_date,
serf_7d_saf_stop,
serf_7d_status,
serf_decision,
convert(smalldatetime,serf_done_date,121) as serf_done_date,
convert(smalldatetime,serf_end_date,121) as serf_end_date,
convert(smalldatetime,serf_hv_done_date,121) as serf_hv_done_date,
serf_hv_saf_stop,
serf_hv_status,
serf_saf_stop,
convert(smalldatetime,serf_start_date,121) as serf_start_date,
serf_status,
convert(smalldatetime,ses_done_date,121) as ses_done_date,
ses_status,
convert(smalldatetime,stool_cal_date_suf1,121) as stool_cal_date_suf1,
convert(smalldatetime,stool_cal_date_suf3,121) as stool_cal_date_suf3,
stool_cal_status_suf1,
stool_cal_status_suf3,
convert(smalldatetime,sudf1_done_date,121) as sudf1_done_date,
sudf1_status,
convert(smalldatetime,sudf2_done_date,121) as sudf2_done_date,
sudf2_status,
convert(smalldatetime,sudf3_done_date,121) as sudf3_done_date,
sudf3_status,
convert(smalldatetime,suf1_done_date,121) as suf1_done_date,
suf1_status,
convert(smalldatetime,suf2_done_date,121) as suf2_done_date,
suf2_status,
convert(smalldatetime,suf3_done_date,121) as suf3_done_date,
suf3_status,
convert(smalldatetime,urine_cal_date_suf1,121) as urine_cal_date_suf1,
convert(smalldatetime,urine_cal_date_suf2,121) as urine_cal_date_suf2,
convert(smalldatetime,urine_cal_date_suf3,121) as urine_cal_date_suf3,
urine_cal_status_suf1,
urine_cal_status_suf2,
urine_cal_status_suf3,
convert(smalldatetime,wmf_done_date,121) as wmf_done_date,
wmf_past_order,
convert(smalldatetime,wmf_start,121) as wmf_start,
wmf_status,
woman_name,
woman_status,
convert(smalldatetime,wra15b_done_date,121) as wra15b_done_date,
wra15b_status,
convert(smalldatetime,wra3b_done_date,121) as wra3b_done_date,
wra3b_status,
convert(smalldatetime,weaeb_done_date,121) as weaeb_done_date,
wraeb_status,
wra_serial,
convert(smalldatetime,wravf1_1attm_date,121) as wravf1_1attm_date,
convert(smalldatetime,wravf1_done_date,121) as wravf1_done_date,
wravf1_status,
convert(smalldatetime,wravf2_done_date,121) as wravf2_done_date,
wravf2_status,
convert(smalldatetime,wravf3_done_date,121) as wravf3_done_date,
wravf3_status,
convert(smalldatetime,dvf_done_date,121) as dvf_done_date,
dvf_status,
convert(smalldatetime,eser_done_date,121) as eser_done_date,
eser_rpdesc,
convert(smalldatetime,px_done_date,121) as px_done_date,
drink_status,
convert(smalldatetime,serf_2nd7hv_done_date,121) as serf_2nd7hv_done_date,
serf_2nd7hv_status,
serf_hv_rp_assmt,
discnt,
supplementation_status,
w1b_status,
w1b_date,
w3b_status,
w3b_date
/*insert_time,*/
/*inserted_by,*/
/*update_time,*/
/*updateed_by,*/
/*changed_hhid,*/
FROM [mindr-live].dbo.wtrak_wra
") dsn("rammps");

fixdate wom_dob blood_cal_date_15b blood_cal_date_3b blood_cal_date_eb consent_date dod drf1_done_date drf2_done_date drf3_done_date saf_done_date saf_start serf_14d_done_date serf_7d_done_date serf_done_date serf_end_date serf_hv_done_date serf_start_date ses_done_date stool_cal_date_suf1 stool_cal_date_suf3 sudf1_done_date sudf2_done_date sudf3_done_date suf1_done_date suf2_done_date suf3_done_date urine_cal_date_suf1 urine_cal_date_suf2 urine_cal_date_suf3 wmf_done_date wmf_start wra15b_done_date wra3b_done_date weaeb_done_date wravf1_1attm_date wravf1_done_date wravf2_done_date wravf3_done_date dvf_done_date eser_done_date px_done_date serf_2nd7hv_done_date w1b_date w3b_date;

#delimit cr

save "..\datasets\stata\wtrak_wra.dta", replace
saveold "..\datasets\stata\wtrak_wra.dta",replace version(12)

log close
