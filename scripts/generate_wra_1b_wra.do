 cd "./"
#delimit ;
clear;
/*wra_1b_wra*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\wra_1b_wra.log", replace;
odbc load,exec("
SELECT
uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
idenconf,
w1bdate,
w1bwkint,
workerid,
w1bstatus,
w1bdod,
w1btemp,
w1btempn1,
w1bsysto1,
w1bdiast1,
w1bbptime1,
workerid_bp,
w1bweight,
w1bmuac1,
w1bmuac2,
w1bmuac3,
w1bsysto2,
w1bdiast2,
w1bbptime2,
w1bbptime2n,
workerid_an,
w1bmealdate,
w1bmealtime,
timegap,
w1bfood,
w1bblood1,
w1bblood2,
w1bspecid1,
w1bspecid2,
w1bbldtime,
w1bhemo,
w1bhemotab,
workerid_bl,
w1bbsmns,
w1bbsmnsd,
workerid_blm as workerid_mns,
version,
today,
start,
[end],
/*formorder,*/
scheduleid,
duplicate,
_date_modified,
_duration,
_media_all_received,
_media_count,
_id,
_uuid,
_version,
_submission_time,
_submitted_by,
_total_media,
_xform_id,
id,
insert_time,
update_time
FROM [mindr-live].dbo.wra_1b_mv


") dsn("rammps");

fixdate w1bdate w1bmealdate;

#delimit cr

destring w1bweight, force replace
destring w1bmuac1, force replace
destring w1bmuac2, force replace
destring w1bmuac3, force replace


foreach v of varlist w1bmuac* {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}


gen byte n_missing = (missing(w1bmuac1))+(missing(w1bmuac2))+(missing(w1bmuac3))
gen medw1bmuac = w1bmuac1+w1bmuac2+w1bmuac3-min(w1bmuac1, w1bmuac2, w1bmuac3)-max(w1bmuac1, w1bmuac2, w1bmuac3) if n_missing==0
replace medw1bmuac = (min(w1bmuac1, w1bmuac2, w1bmuac3)+max(w1bmuac1, w1bmuac2, w1bmuac3))/2 if n_missing==1
replace medw1bmuac = max(w1bmuac1, w1bmuac2, w1bmuac3) if n_missing==2
drop n_missing


replace w1bweight = . if (w1bweight == 0.00 | w1bweight == 99.9)





save "..\datasets\stata\wra_1b_wra.dta", replace
saveold "..\datasets\stata\wra_1b_wra.dta",replace version(12)

log close
