 cd "./"
#delimit ;
clear;
/*wra_vf*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\wratrak.log", replace;
odbc load,exec("
SELECT
uid,
tlpin,
sector,
hhid,
wom_dob,
age_wef,
age_wra,
arm_wra,
consent,
consent_date,
lsi,
wb_date,
wb_status,
wbb_date,
wbb_time,
wbb_meal_time,
wbb_fast_time,
wbb_status,
wm_date,
wm_status,
wmb_date,
wmb_time,
wmb_meal_time,
wmb_fast_time,
wmb_status,
mid_study_status,
we_date,
we_status,
web_date,
web_time,
web_meal_time,
web_fast_time,
web_status,
end_study_status,
ses_date,
ses_status,
saf_date,
saf_status,
supp_status,
adh_mns,
adh_bep,
discnt
/*fdose_date,*/
/*edose_date,*/
/*totdose_days,*/
/*totdose_mns,*/
/*totdose_bep,*/
/*pcomp_mns,*/
/*pcomp_bep*/
FROM [mindr-live].dbo.wtrak_wra
") dsn("rammps");

fixdate wom_dob consent_date wb_date wbb_date wm_date wmb_date we_date web_date ses_date saf_date  ;

#delimit cr

save "..\datasets\stata\wratrak.dta", replace
saveold "..\datasets\stata\wratrak.dta",replace version(12)

log close
