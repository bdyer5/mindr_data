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
allocated_arm as arm_wra,
wom_dob,
dod as wom_dod,
consent,
consent_date,
wravfe_date,
wravfe_status,
wraeb_date,
wraeb_status,
wravf15_date,
wravf15_status,
wra15b_date,
wra15b_status,
wravf3_date,
wravf3_status,
wra3b_date,
wra3b_status,
ses_date,
ses_status,
saf_date,
saf_status,
supp_status,
drf1_date,
drf1_status,
drf2_date,
drf2_status,
drf3_date,
drf3_status,
suf1_date,
suf1_status,
suf1_urine,
suf1_stool,
suf2_date,
suf2_status,
suf2_urine,
suf3_date,
suf3_status,
suf3_urine,
suf3_stool,
px_bl_date,
px_ml_date,
discnt,
fdose_date,
edose_date,
totdose_days,
totdose_mns,
totdose_bep,
pcomp_mns,
pcomp_bep
FROM [mindr-live].dbo.wtrak_wra
") dsn("rammps");

fixdate wom_dob wravfe_date wraeb_date wravf15_date wra15b_date wravf3_date wra3b_date ses_date saf_date drf1_date drf2_date drf3_date suf1_date suf2_date suf3_date px_bl_date px_ml_date fdose_date edose_date ;

#delimit cr

save "..\datasets\stata\wtrak_wra.dta", replace
saveold "..\datasets\stata\wtrak_wra.dta",replace version(12)

log close
