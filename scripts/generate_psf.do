 cd "./"
#delimit ;
clear;
/*psf*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\psf.log", replace;
odbc load,exec("
select
p.id,
p.uid,
p.tlpin,
p.sector,
p.hhid,
jw.jivitaweek as psfwkint,
convert(smalldatetime,p.psfdate,121) as psfdate,
hhchange,
newhhid,
/*womname,*/
/*husbname,*/
workerid,
psstatus,
subyy,
pslmpddc,
pslmpmm,
pslmpyy,
pslmpdd,
pslmp,
lmp_display,
lmp_displayt,
lmp_displayt1,
psurt,
version,
today,
start,
[end],
scheduleid,
idenconf,
p.insert_time,
p.update_time,
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
from [mindr-live].dbo.all_psf p 
join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,psfdate,121)
left join [mindr-live].dbo.schedule_pw s on s.id = p.scheduleid
where duplicate is null
order by p.uid asc 
") dsn("rammps");

fixdate psfdate;

#delimit cr


save "..\datasets\stata\psf.dta", replace
saveold "..\datasets\stata\psf.dta", replace version(12)
log close
