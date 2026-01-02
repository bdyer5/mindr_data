 cd "./"
#delimit ;
clear;
/*mpfb*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\m1mop_pw.log", replace;
odbc load,exec("
select 
uid,
tlpin,
sector,
hhid,
/*hhchange,*/
/*newhhid,*/
/*womname,*/
/*husbname,*/
/*idenconf,*/
m1date,
workerid,
m1status,
m1dod,
m1cgh30,
m1cgh30d,
m1cghtx1,
m1cghtx2,
m1cgh7,
m1cgh7n,
m1brth30,
m1brth30d,
m1brthtx1,
m1brthtx2,
m1brth7,
m1brth7n,
m1conv30,
m1conv30d,
m1convtx1,
m1convtx2,
m1conv7,
m1conv7n,
m1swlh30,
m1swlh30d,
m1swlhtx1,
m1swlhtx2,
m1swlh7,
m1swlh7n,
m1swlf30,
m1swlf30d,
m1swlftx1,
m1swlftx2,
m1swlf7,
m1swlf7n,
m1hach30,
m1hach30d,
m1hachtx1,
m1hachtx2,
m1hach7,
m1hach7n,
m1hfvr30,
m1hfvr30d,
m1hfvrtx1,
m1hfvrtx2,
m1hfvr7,
m1hfvr7n,
m1lfvr30,
m1lfvr30d,
m1lfvrtx1,
m1lfvrtx2,
m1lfvr7,
m1diar30,
m1diar30d,
m1diartx1,
m1diartx2,
m1diar7,
m1diar7n,
m1dys30,
m1dys30d,
m1dystx1,
m1dystx2,
m1dys7,
m1dys7n,
m1wdys30,
m1wdys30d,
m1wdystx1,
m1wdystx2,
m1wdys7,
m1labd30,
m1labd30d,
m1labdtx1,
m1labdtx2,
m1labd7,
m1labd7n,
m1urin30,
m1urin30d,
m1urintx1,
m1urintx2,
m1urin7,
m1urin7n,
m1vagd30,
m1vagd30d,
m1vagdtx1,
m1vagdtx2,
m1vagd7,
m1vagd7n,
m1xn30,
m1xn30d,
m1xntx1,
m1xntx2,
m1xn7,
m1xn7n,
m1tab30,
m1tabphoto30,
m1tabn30,
m1tab30o1,
m1tabphoto301,
m1tabn301,
m1tab30o2,
m1tabphoto302,
m1tabn302,
m1tab30o3,
m1tabphoto303,
m1tabn303,
m1tab30o4,
m1tabphoto304,
m1tabn304,
m1tab30o5,
m1tabphoto305,
m1tabn305,
version,
today,
start,
[end],
scheduleid,
insert_time,
update_time,
_submission_time,
/*_xform_id,*/
/*instanceid,*/
_id,
_uuid,
_version
from [mindr-live].dbo.m1mop_mv mp
") dsn("rammps");

fixdate m1date m1dod;

#delimit cr


save "..\datasets\stata\m1mop_pw.dta", replace
saveold "..\datasets\stata\m1mop_pw.dta", replace version(12)
log close
