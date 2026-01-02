 cd "./"
#delimit ;
clear;
/*pefb*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\mbaf.log", replace;
odbc load,exec("
SELECT
uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
/*womname,*/
/*husbname,*/
mbwkint,
mbdate,
workerid,
mbrelat,
mbrelats,
mbstatus,
mbvital,
mbweight,
mbsysto1,
mbdiast1,
mbbptime1,
mblbn,
mbsbn,
mb1sex,
mb1pof,
mb1stk,
mb1wrap,
mb1fresh,
mb1def,
mb2sex,
mb2pof,
mb2stk,
mb2wrap,
mb2fresh,
mb2def,
mb3sex,
mb3pof,
mb3stk,
mb3wrap,
mb3fresh,
mb3def,
mbtype,
mbtypes,
mbcsecres,
mbcsecrec,
mbwhr,
mbwhrs,
mbwho,
mbwhos,
mblaborp,
mbwhtl1,
mbwhtl2,
mbwhtl3,
mbbabyown,
mabomass,
mbbohand,
mbbovmt,
mbbosal,
mbbosalij,
mbboij,
mbbodoc,
mbboforc,
mbbovac,
mbboepis,
mbbocsec,
mbplown,
mbplmass,
mbplhand,
mbplvmt,
mbpldoc,
mbplhosp,
mbploth,
mbenpl,
mbbleed,
mbsysto2,
mbdiast2,
mbbptime2,
version,
today,
start,
[end],
scheduleid,
idenconf,
/*insert_time,*/
/*update_time,*/
/*inserted_by,*/
/*updateed_by,*/
_submission_time,
/*_submitted_by,*/
/*_date_modified,*/
/*_xform_id,*/
/*instance_id,*/
/*_duration,*/
/*_media_all_received,*/
/*_media_count,*/
_id
/*_uuid,*/
/*_version,*/
/*duplicate,*/
FROM [mindr-live].dbo.mbaf_mv
") dsn("rammps");

fixdate mbdate;


destring mbweight, force replace;

#delimit cr

foreach v of varlist mbweight {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}


save "..\datasets\stata\mbaf.dta", replace
saveold "..\datasets\stata\mbaf.dta",replace version(12)

log close
