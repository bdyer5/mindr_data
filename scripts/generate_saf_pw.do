 cd "./"
#delimit ;
clear;
/*wef*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\saf_pw.log", replace;
odbc load,exec("
select 
uid,
tlpin,
sector,
hhid,
/*womname,*/
/*husbname,*/
/*sawkint,*/
sadate,
workerid,
sastatus,
sadoc,
sadaydrink,
sadawtwat,
sadawata,
sadawatatc,
sadafdrink,
sadafdrinkwt,
sadawtjpp,
sadajppb,
sadamett,
sadawhr,
sadafmv,
sadasmv,
sadpydrink,
sadpwtwat,
sadpwata,
sadpfdrink,
sadpyjpp,
sadpmett,
sawateradd,
safrotoadd,
sadaydrinkr,
samarkw,
samarkwvl,
samarkf,
samarkfvl,
sadawtjppr,
sadajppbr,
sadamettr,
sadawhrr,
sadafmvr,
sadasmvr,
version,
today,
start,
[end],
sadf1,
sadfp1,
formorder,
arm,
ramadan,
samarkw1,
samarkf1,
scheduleid,
hhchange,
newhhid,
idenconf,
sadawtwatc,
sadod,
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
/*_total_media,*/
/*id,*/
/*duplicate,*/
from [mindr-live].dbo.safpw_mv 
") dsn("rammps");

fixdate sadate sadoc sadod;

#delimit cr


save "..\datasets\stata\saf_pw.dta", replace
saveold "..\datasets\stata\saf_pw.dta", replace version(12)
log close
