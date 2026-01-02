 cd "./"
#delimit ;
clear;
/*lpfb_pw*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\lpfb_pw.log", replace;
odbc load,exec("
select 
uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
idenconf,
lpbdate,
workerid,
lpbstatus,
lpbdoc,
lpbdod,
lpbtemp,
lpbtempn1,
lpbsysto1,
lpbdiast1,
lpbbptime1,
workerid_bp,
lpbweight,
lpbmuac1,
lpbmuac2,
lpbmuac3,
lpbsysto2,
lpbdiast2,
lpbbptime2,
lpbbptime2n,
workerid_an,
lpbmealdate,
lpbmealtime,
lpbmealtimec,
lpbfood,
lpbblood1,
lpbblood2,
lpbspecid1,
st,
vt,
supt,
lpbspecid2,
st1,
vt1,
supt1,
lpbbldtime,
lpbhemo,
lpbfetab,
workerid_bl,
version,
today,
start,
[end],
scheduleid,
/*insert_time,*/
/*update_time,*/
/*inserted_by,*/
/*updateed_by,*/
/*_submission_time,*/
/*_submitted_by,*/
/*_date_modified,*/
/*_xform_id,*/
instance_id,
/*_duration,*/
/*_media_all_received,*/
/*_media_count,*/
_id
/*_uuid,*/
/*_version,*/
/*duplicate*/
from [mindr-live].dbo.lpfb_mv  lpb
") dsn("rammps");

fixdate lpbdate lpbdoc lpbdod;

destring lpbweight, force replace;
destring lpbmuac1, force replace;
destring lpbmuac2, force replace;
destring lpbmuac3, force replace;


save "..\datasets\stata\lpfb_pw.dta", replace ;


#delimit cr

foreach v of varlist lpbmuac* {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}

save "..\datasets\stata\lpfb_pw.dta", replace

gen byte n_missing = (missing(lpbmuac1))+(missing(lpbmuac2))+(missing(lpbmuac3))
gen medlpbmuac = lpbmuac1+lpbmuac2+lpbmuac3-min(lpbmuac1, lpbmuac2, lpbmuac3)-max(lpbmuac1, lpbmuac2, lpbmuac3) if n_missing==0
replace medlpbmuac = (min(lpbmuac1, lpbmuac2, lpbmuac3)+max(lpbmuac1, lpbmuac2, lpbmuac3))/2 if n_missing==1
replace medlpbmuac = max(lpbmuac1, lpbmuac2, lpbmuac3) if n_missing==2
drop n_missing

save "..\datasets\stata\lpfb_pw.dta", replace

foreach v of varlist lpbweight {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}



save "..\datasets\stata\lpfb_pw.dta", replace
saveold "..\datasets\stata\lpfb_pw.dta", replace version(12)
log close
