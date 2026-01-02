 cd "./"
#delimit ;
clear;
/*wef*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\woman.log", replace;
odbc load,exec("select
uid,
insert_time,
update_time,
changed_hhid,
enroll_hhid,
enroll_mobile,
enroll_sector,
enroll_tlpin,
husband_name,
nwef_hhid,
nwef_sector,
nwef_tlpin,
surt,
wecurpreg,
woman_dob_dd,
woman_dob_mm,
woman_dob_yy,
wef_consent,
wef_done_date,
wef_mobile_others,
wef_mobile_woman,
wef_pw_consent,
wef_stata,
weinfant,
welmp,
wemarrlhus,
wetfpm,
weurt,
woman_age,
woman_dob,
woman_name,
woman_source,
inserted_by,
updateed_by,
hhid,
sector,
wef_mopup_done_date,
wef_mopup_stata,
woman_status,
mopup2_surt,
wef_mopup2_done_date,
wef_mopup2_stata
from [mindr-live].dbo.woman
") dsn("rammps");

#delimit cr

save "..\datasets\stata\woman.dta", replace
saveold "..\datasets\stata\woman.dta",replace version(12)

log close
