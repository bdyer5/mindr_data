 cd "./"
#delimit ;
clear;
/*mpfb*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\mpfb_pw.log", replace;
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
mpbwkint,
mpbdate,
workerid,
mpbstatus,
mpbdoc,
mpbdod,
mpbtemp,
mpbtempn1,
mpbsysto1,
mpbdiast1,
mpbbptime1,
workerid_bp,
mpbweight,
mpbmuac1,
mpbmuac2,
mpbmuac3,
mpbsysto2,
mpbdiast2,
mpbbptime2,
mpbbptime1n,
workerid_an,
mpbmealdate,
mpbmealtime,
mpbmealtimec,
mpbfood,
mpbblood1,
mpbblood2,
mpbspecid1,
st,
vt,
supt,
mpbspecid2,
st1,
vt1,
supt1,
mpbbldtime,
mpbhemo,
mpbfetab,
workerid_bl,
version,
today,
start,
[end],
scheduleid,
/*insert_time,*/
/*update_time,*/
/*_submission_time,*/
/*_submitted_by,*/
/*_date_modified,*/
/*_xform_id,*/
instanceid,
/*_duration,*/
/*_media_all_received,*/
/*_media_count,*/
_id
/*_uuid,*/
/*_version,*/
/*duplicate*/
from [mindr-live].dbo.mpfb_mv mp
") dsn("rammps");

fixdate mpbdate mpbdoc mpbdod;


destring mpbweight, force replace;
destring mpbmuac1, force replace;
destring mpbmuac2, force replace;
destring mpbmuac3, force replace;


save "..\datasets\stata\mpfb_pw.dta", replace ;


#delimit cr

foreach v of varlist mpbmuac* {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}

save "..\datasets\stata\mpfb_pw.dta", replace

gen byte n_missing = (missing(mpbmuac1))+(missing(mpbmuac2))+(missing(mpbmuac3))
gen medmpbmuac = mpbmuac1+mpbmuac2+mpbmuac3-min(mpbmuac1, mpbmuac2, mpbmuac3)-max(mpbmuac1, mpbmuac2, mpbmuac3) if n_missing==0
replace medmpbmuac = (min(mpbmuac1, mpbmuac2, mpbmuac3)+max(mpbmuac1, mpbmuac2, mpbmuac3))/2 if n_missing==1
replace medmpbmuac = max(mpbmuac1, mpbmuac2, mpbmuac3) if n_missing==2
drop n_missing

save "..\datasets\stata\mpfb_pw.dta", replace

foreach v of varlist mpbweight {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}



save "..\datasets\stata\mpfb_pw.dta", replace
saveold "..\datasets\stata\mpfb_pw.dta", replace version(12)
log close
