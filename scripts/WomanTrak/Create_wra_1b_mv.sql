use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='wra_1b_mv')
begin 
drop view wra_1b_mv
end 
go 

Create view wra_1b_mv as 
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
convert(smalldatetime,eb.w1bdate,121) as w1bdate,
jw.jivitaweek as w1bwkint,
workerid,
w1bstatus,
w1bdod,
w1btemp,
w1btempn1,
w1bsysto1,
w1bdiast1,
w1bbptime1,
workerid_bp,
w1bweight,
w1bmuac1,
w1bmuac2,
w1bmuac3,
w1bsysto2,
w1bdiast2,
w1bbptime2,
w1bbptime2n,
workerid_an,
convert(smalldatetime,w1bmealdate,121) as w1bmealdate,
w1bmealtime,
timegap,
w1bfood,
w1bblood1,
w1bblood2,
w1bspecid1,
w1bspecid2,
w1bbldtime,
w1bhemo,
w1bhemotab,
workerid_bl,
w1bbsmns,
w1bbsmnsd,
workerid_blm,
version,
today,
start,
[end],
/*formorder,*/
scheduleid,
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
FROM [mindr-live].dbo.all_wra1b eb INNER JOIN
shapla.dbo.JiVitAWeek AS jw ON jw.RomanDate = CONVERT(smalldatetime, eb.w1bdate, 121)
left join [mindr-live].dbo.schedule_wra s on s.id = eb.scheduleid
left join (select b.uid,b.schedule_week,b.w1bdate,max(b._submission_time) _submission_time
from (
select eb1.uid,s.jivita_week as schedule_week,eb1.w1bdate,_submission_time 
from [mindr-live].dbo.all_wra1b eb1
left join [mindr-live].dbo.schedule_wra s on s.id = eb1.scheduleid
left join (select eb2.uid,max(s.jivita_week) as schedule_week,max(w1bdate) w1date 
from [mindr-live].dbo.all_wra1b eb2
left join [mindr-live].dbo.schedule_wra s on s.id = eb2.scheduleid
where eb2.duplicate is null
group by eb2.uid
) a on a.uid = eb1.uid and eb1.w1bdate =a.w1date and s.jivita_week =a.schedule_week  
where a.w1date is not null
and eb1.duplicate is null 
) b group by b.uid,b.schedule_week,b.w1bdate) c on c.uid = eb.uid and c.schedule_week = s.jivita_week
and c.w1bdate = eb.w1bdate and c._submission_time = eb._submission_time
where duplicate is null and c.uid is not null

