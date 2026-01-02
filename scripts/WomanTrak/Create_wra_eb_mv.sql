use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='wra_eb_mv')
begin 
drop view wra_eb_mv
end 
go 

Create view wra_eb_mv as 
SELECT
eb.uid,
eb.tlpin,
eb.sector,
eb.hhid,
hhchange,
newhhid,
womname,
husbname,
idenconf,
convert(smalldatetime,eb.webdate,121) as webdate,
jw.jivitaweek as webwkint,
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
convert(smalldatetime,webmealdate,121) as webmealdate,
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
workerid_me,
version,
today,
start,
[end],
--formorder,
schedule_id as  scheduleid,
duplicate,
_date_modified,
_duration,
_media_all_received,
_media_count,
_id,
_uuid,
_version,
eb._submission_time,
_submitted_by,
_total_media,
_xform_id,
eb.id,
eb.insert_time,
eb.update_time
FROM [mindr-live].dbo.all_wraeb eb INNER JOIN
shapla.dbo.JiVitAWeek AS jw ON jw.RomanDate = CONVERT(smalldatetime, eb.webdate, 121)
left join [mindr-live].dbo.schedule_wra s on s.id = eb.schedule_id
left join (select b.uid,b.schedule_week,b.webdate,max(b._submission_time) _submission_time
from (
select eb1.uid,s.jivita_week as schedule_week,eb1.webdate,_submission_time 
from [mindr-live].dbo.all_wraeb eb1
left join [mindr-live].dbo.schedule_wra s on s.id = eb1.schedule_id
left join (select eb2.uid,max(s.jivita_week) as schedule_week,max(webdate) webdate 
from [mindr-live].dbo.all_wraeb eb2
left join [mindr-live].dbo.schedule_wra s on s.id = eb2.schedule_id
where eb2.duplicate is null
group by eb2.uid
) a on a.uid = eb1.uid and eb1.webdate =a.webdate and s.jivita_week =a.schedule_week  
where a.webdate is not null
and eb1.duplicate is null 
) b group by b.uid,b.schedule_week,b.webdate) c on c.uid = eb.uid and c.schedule_week = s.jivita_week
and c.webdate = eb.webdate and c._submission_time = eb._submission_time
where duplicate is null and c.uid is not null

