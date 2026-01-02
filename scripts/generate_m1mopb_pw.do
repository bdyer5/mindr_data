 cd "./"
#delimit ;
clear;
/*mpfb*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\m1mopb_pw.log", replace;
odbc load,exec("
select 
uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
/*womname,*/
/*husbname,*/
idenconf,
m1bdate,
workerid,
m1bstatus,
m1bdod,
m1btemp,
m1btempn1,
m1bsysto1,
m1bdiast1,
m1bbptime1,
workerid_bp,
m1bweight,
m1bmuac1,
m1bmuac2,
m1bmuac3,
m1bsysto2,
m1bdiast2,
m1bbptime2,
m1bbptime2n,
workerid_an,
m1blastfedt,
m1blastfedbu,
m1bbrstused,
m1bbrstcln,
m1bcols,
m1bcole,
m1bbmilkv,
m1bbrstemty,
m1bbmspecid,
stb,
vtb,
suptb,
workerid_bm,
m1bmealdate,
m1bmealtime,
m1bmealtimec,
m1bfood,
m1bblood1,
m1bblood2,
m1bspecid1,
st,
vt,
supt,
m1bspecid2,
st1,
vt1,
supt1,
m1bbldtime,
m1bhemo,
m1bfetab,
workerid_bl,
childvts,
version,
today,
start,
[end],
scheduleid,
/*insert_time,*/
/*update_time,*/
_submission_time,
/*_submitted_by,*/
/*_date_modified,*/
/*_xform_id,*/
/*instanceid,*/
/*_duration,*/
/*_media_all_received,*/
/*_media_count,*/
_id
/*_uuid,*/
/*_version,*/
/*duplicate*/
from [mindr-live].dbo.m1mopb_mv mp
") dsn("rammps");

fixdate m1bdate m1bdod m1bmealdate;

#delimit cr

destring m1bweight, force replace
destring m1bmuac1, force replace
destring m1bmuac2, force replace
destring m1bmuac3, force replace


save "..\datasets\stata\m1mopb_pw.dta", replace 


foreach v of varlist m1bmuac* {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}

save "..\datasets\stata\m1mopb_pw.dta", replace

gen byte n_missing = (missing(m1bmuac1))+(missing(m1bmuac2))+(missing(m1bmuac3))
gen medm1bmuac = m1bmuac1+m1bmuac2+m1bmuac3-min(m1bmuac1, m1bmuac2, m1bmuac3)-max(m1bmuac1, m1bmuac2, m1bmuac3) if n_missing==0
replace medm1bmuac = (min(m1bmuac1, m1bmuac2, m1bmuac3)+max(m1bmuac1, m1bmuac2, m1bmuac3))/2 if n_missing==1
replace medm1bmuac = max(m1bmuac1, m1bmuac2, m1bmuac3) if n_missing==2
drop n_missing

save "..\datasets\stata\m1mopb_pw.dta", replace

foreach v of varlist m1bweight {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}


save "..\datasets\stata\m1mopb_pw.dta", replace
saveold "..\datasets\stata\m1mopb_pw.dta", replace version(12)
log close

