 cd "./"
#delimit ;
clear;
/*ibaf*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\ibaf.log", replace;
odbc load,exec("
SELECT
uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
ibwkint,
ibdate,
/*womname,*/
/*husbname,*/
workerid,
childuid,
childname,
childno,
ibsex,
ibrelat1,
ibrelat2,
ibrelat3,
ibstatus,
ibdob,
ibbtimehr,
ibbtimemn,
ibbtimeap,
ibdod,
ibdtimehr,
ibdtimemn,
ibdtimeap,
ibpart,
ibparts,
ibstuck,
ibneck,
ibbrth,
ibcry1,
ibcry1s,
ibcry2,
ibcry2s,
ibcry3,
ibcry3s,
ibbrthc,
iblimb,
ibblue,
ibblueh,
ibbluef,
ibbluel,
ibblueb,
ibbfed,
ibbfedw,
ibbfhr,
ibbfclst,
ibbfoth1,
ibbfoth2,
ibbfoth3,
ibbfoth1s,
ibatimehr,
ibatimemn,
ibatimeap,
ibweight,
ibmuac1,
ibmuac2,
ibmuac3,
ibcc1,
ibcc2,
ibcc3,
ibhc1,
ibhc2,
ibhc3,
ibheight1,
ibheight2,
ibheight3,
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
FROM     [mindr-live].dbo.ibaf_mv
") dsn("rammps");

fixdate ibdate ibdob ibdod;

#delimit cr

save "..\datasets\stata\ibaf.dta", replace
saveold "..\datasets\stata\ibaf.dta",replace version(12) 

log close
