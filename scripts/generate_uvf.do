 cd "./"
#delimit ;
clear;
/*uvf*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\uvf.log", replace;
odbc load,exec("
select
id,
uid,
tlpin,
sector,
hhid,
/*womname,*/
/*husbname,*/
uvwkint,
uvdate,
workerid,
uvstatus,
uvpregstatus,
uvfetus,
dob,
doc,
/*Sec B 1 - Embryo/fetus number 1*/
uvcrl11,
uvcrl21,
uvcrl31,
uvcrlcmt1,
uvbpd11,
uvbpd21,
uvbpd31,
uvbpdcmt1,
uvhc11,
uvhc21,
uvhc31,
uvhccmt1,
uvfl11,
uvfl21,
uvfl31,
uvflcmt1,
uvpregperiod1,
uvusref1,
/*Sec B 2 - Embryo/fetus number 2*/
uvcrl12,
uvcrl22,
uvcrl32,
uvcrlcmt2,
uvbpd12,
uvbpd22,
uvbpd32,
uvbpdcmt2,
uvhc12,
uvhc22,
uvhc32,
uvhccmt2,
uvfl12,
uvfl22,
uvfl32,
uvflcmt2,
uvpregperiod2,
uvusref2,
/*Sec B 3 - Embryo/fetus number 3*/
uvcrl13,
uvcrl23,
uvcrl33,
uvcrlcmt3,
uvbpd13,
uvbpd23,
uvbpd33,
uvbpdcmt3,
uvhc13,
uvhc23,
uvhc33,
uvhccmt3,
uvfl13,
uvfl23,
uvfl33,
uvflcmt3,
uvpregperiod3,
uvusref3	,
/*Sec B 4 - Embryo/fetus number 4*/
uvcrl14,
uvcrl24,
uvcrl34,
uvcrlcmt4,
uvbpd14,
uvbpd24,
uvbpd34,
uvbpdcmt4,
uvhc14,
uvhc24,
uvhc34,
uvhccmt4,
uvfl14,
uvfl24,
uvfl34,
uvflcmt4,
uvpregperiod4,
uvusref4,
/* meta data */
version,
today,
start,
[end],
schedule_id,
hhchange,
newhhid,
idenconf,
insert_time,
update_time,
inserted_by,
updateed_by,
_submission_time,
_submitted_by,
_date_modified,
_xform_id,
instance_id,
_duration,
_media_all_received,
_media_count,
_id,
_uuid,
_version,
duplicate
from [mindr-live].dbo.uvf_mv uv
") dsn("rammps");

fixdate uvdate;

#delimit cr


save "..\datasets\stata\uvf.dta", replace
saveold "..\datasets\stata\uvf.dta", replace version(12)
log close
