 cd "./"
#delimit ;
clear;
/*wra_eb_wra*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\wra_eb_wra.log", replace;
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
webdate,
webwkint,
workerid,
webstatus,
webdod,
webtemp,
webtempn1,
websysto1,
webdiast1,
webbptime1,
workerid_bp,
webweight,
webheight1,
webheight2,
webheight3,
webmuac1,
webmuac2,
webmuac3,
websysto2,
webdiast2,
webbptime2,
webbptime2n,
workerid_an,
webmealdate,
webmealtime,
webmealtimec,
timegap,
webfood,
webblood1,
webblood2,
webspecid1,
st,
vt,
supt,
webspecid2,
st1,
vt1,
supt1,
webbldtime,
webhemo,
webhemotab,
webbltype,
webrhtype,
workerid_bl,
webbsmns,
webbsmnsd,
workerid_me as workerid_mns,
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
FROM [mindr-live].dbo.wra_eb_mv
") dsn("rammps");

fixdate webdate webmealdate;

#delimit cr

destring webweight, force replace
destring webmuac1, force replace
destring webmuac2, force replace
destring webmuac3, force replace


foreach v of varlist webmuac* {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}


gen byte n_missing = (missing(webmuac1))+(missing(webmuac2))+(missing(webmuac3))
gen medwebmuac = webmuac1+webmuac2+webmuac3-min(webmuac1, webmuac2, webmuac3)-max(webmuac1, webmuac2, webmuac3) if n_missing==0
replace medwebmuac = (min(webmuac1, webmuac2, webmuac3)+max(webmuac1, webmuac2, webmuac3))/2 if n_missing==1
replace medwebmuac = max(webmuac1, webmuac2, webmuac3) if n_missing==2
drop n_missing


replace webweight = . if (webweight == 0.00 | webweight == 99.9)



save "..\datasets\stata\wra_eb_wra.dta", replace
saveold "..\datasets\stata\wra_eb_wra.dta",replace version(12)

log close
