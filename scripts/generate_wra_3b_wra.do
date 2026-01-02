 cd "./"
#delimit ;
clear;
/*wra_3b_wra*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\wra_3b_wra.log", replace;
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
w3bdate,
workerid,
w3bstatus,
w3bdod,
w3btemp,
w3btempn1,
w3bsysto1,
w3bdiast1,
w3bbptime1,
workerid_bp,
w3bweight,
w3bmuac1,
w3bmuac2,
w3bmuac3,
w3bsysto2,
w3bdiast2,
w3bbptime2,
w3bbptime2n,
workerid_an,
w3bmealdate,
w3bmealtime,
w3bmealtimec,
timegap,
w3bfood,
w3bblood1,
w3bblood2,
w3bspecid1,
st,
vt,
supt,
w3bspecid2,
st1,
vt1,
supt1,
w3bbldtime,
w3bhemo,
w3bhemotab,
workerid_bl,
w3bbsmns,
w3bbsmnsd,
workerid_blm as workerid_mns,
version,
today,
start,
[end],
/*form_order,*/
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
FROM [mindr-live].dbo.wra_3b_mv


") dsn("rammps");

fixdate w3bdate w3bmealdate;

#delimit cr

destring w3bweight, force replace
destring w3bmuac1, force replace
destring w3bmuac2, force replace
destring w3bmuac3, force replace


foreach v of varlist w3bmuac* {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)  
}


gen byte n_missing = (missing(w3bmuac1))+(missing(w3bmuac2))+(missing(w3bmuac3))
gen medw3bmuac = w3bmuac1+w3bmuac2+w3bmuac3-min(w3bmuac1, w3bmuac2, w3bmuac3)-max(w3bmuac1, w3bmuac2, w3bmuac3) if n_missing==0
replace medw3bmuac = (min(w3bmuac1, w3bmuac2, w3bmuac3)+max(w3bmuac1, w3bmuac2, w3bmuac3))/2 if n_missing==1
replace medw3bmuac = max(w3bmuac1, w3bmuac2, w3bmuac3) if n_missing==2
drop n_missing


replace w3bweight = . if (w3bweight == 0.00 | w3bweight == 99.9)




save "..\datasets\stata\wra_3b_wra.dta", replace
saveold "..\datasets\stata\wra_3b_wra.dta",replace version(12)

log close
