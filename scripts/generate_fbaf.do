 cd "./"
#delimit ;
clear;
/*fbaf*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\fbaf.log", replace;
odbc load,exec("
SELECT
uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
fbwkint,
fbdate,
womname,
husbname,
workerid,
childuid,
childname,
childno,
fbsex,
fbrelat1,
fbstatus,
fbdob,
fbbtimehr,
fbbtimemn,
fbbtimeap,
fbdod,
fbdtimehr,
fbdtimemn,
fbdtimeap,
fbatimehr,
fbatimemn,
fbatimeap,
fbweight,
fbmuac1,
fbmuac2,
fbmuac3,
fbcc1,
fbcc2,
fbcc3,
fbhc1,
fbhc2,
fbhc3,
fbheight1,
fbheight2,
fbheight3,
version,
today,
start,
[end],
scheduleid,
idenconf,
insert_time,
update_time,
inserted_by,
updateed_by,
_submission_time,
_submitted_by,
_date_modified,
_xform_id,
instanceid,
_duration,
_media_all_received,
_media_count,
_id,
_uuid,
_version,
duplicate
FROM     [mindr-live].dbo.fbaf_mv
") dsn("rammps");

fixdate fbdate fbdob fbdod;

#delimit cr

save "..\datasets\stata\fbaf.dta", replace
saveold "..\datasets\stata\fbaf.dta",replace version(12)  

log close
