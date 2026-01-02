 cd "./"
#delimit ;
clear;
/*dvf_pw*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\dvf_pw.log", replace;
odbc load,exec("
select 
uid,
tlpin,
sector,
hhid,
/*womname,*/
/*husbname,*/
dvfdate,
workerid,
visittype,
visitstatus,
disdone,
dissupp,
referal,
hhchange,
newhhid,
idenconf,
today,
start,
[end],
version,
scheduleid,
_date_modified,
_duration,
_id,
_media_all_received,
_media_count,
_submission_time,
_submitted_by,
_total_media,
_uuid,
_version,
_xform_id,
duplicate,
id,
insert_time,
inserted_by,
instance_id,
update_time,
updateed_by
from [mindr-live].dbo.dvf_pw_mv d
") dsn("rammps");

fixdate dvfdate;

#delimit cr



foreach v of varlist * {
     if !inlist("`v'", "dvfdate","insert_time","inserted_by","update_time","updateed_by") {
        di `v'
	    replace `v' = "" if (`v' == "n/a" )
        //destring `v', force replace
     }
}


save "..\datasets\stata\dvf_pw.dta", replace
saveold "..\datasets\stata\dvf_pw.dta",replace version(12)

log close
