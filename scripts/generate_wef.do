 cd "./"
#delimit ;
clear;
/*wef*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\wef.log", replace;
odbc load,exec("
select
uid,
tlpin,
sector,
hhid,
/*womname,*/
/*husbname,*/
jw.jivitaweek as wewkint,
convert(smalldatetime,wedate,121) as wedate,
workerid,
westatus,
wef_consent,
wef_fconsent,
wef_dconsent,
weagen,
wemarrlhus,
wecurpreg,
welmpddc,
welmpmm,
welmpyy,
welmpdd,
welmp,
lmp_display,
weurt,
weinft,
wecurbfd,
wewant6m,
wefpm,
wefpt,
wef_pw_consent,
welrins,
weownmob,
wemobno,
wecont,
wecontno,
wecontown,
weothmarr,
wenomarr,
/*--not in table pw,*/
/*--not in table wra,*/
surt,
surtc,
version,
today,
start,
[end],
subdd,
submm,
subyy,
/*pwcon,*/
scheduleid,
hhchange,
newhhid,
idenconf,
insert_time,
update_time,
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
from [mindr-live].dbo.all_wef
join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,wedate,121)
where duplicate is null

") dsn("rammps");

fixdate wedate;

#delimit cr


save "..\datasets\stata\wef.dta", replace
saveold "..\datasets\stata\wef.dta", replace version(12)
log close
