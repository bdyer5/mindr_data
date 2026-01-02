use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='wra_3b_mv')
begin 
drop view wra_3b_mv
end 
go 

Create view wra_3b_mv as 
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
convert(smalldatetime,eb.w3bdate,121) as w3bdate,
workerid,
w3bstatus,
w3bdod,
w3btemp,
w3btempn1,
w3bsysto1,
w3bdiast1,
w3bbptime1,
workerid_bp,
w3bweight,
w3bmuac1,
w3bmuac2,
w3bmuac3,
w3bsysto2,
w3bdiast2,
w3bbptime2,
w3bbptime2n,
workerid_an,
convert(smalldatetime,eb.w3bmealdate,121) as w3bmealdate,
w3bmealtime,
w3bmealtimec,
timegap,
w3bfood,
w3bblood1,
w3bblood2,
w3bspecid1,
st,
vt,
supt,
w3bspecid2,
st1,
vt1,
supt1,
w3bbldtime,
w3bhemo,
w3bhemotab,
workerid_bl,
w3bbsmns,
w3bbsmnsd,
workerid_blm,
version,
today,
start,
[end],
/*form_order,*/
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
FROM [mindr-live].dbo.all_wra3b eb INNER JOIN
shapla.dbo.JiVitAWeek AS jw ON jw.RomanDate = CONVERT(smalldatetime,eb.w3bdate,121)
left join [mindr-live].dbo.schedule_wra s on s.id = eb.scheduleid
left join (select b.uid,b.schedule_week,b.w3bdate,max(b._submission_time) _submission_time
from (
select eb1.uid,s.jivita_week as schedule_week,eb1.w3bdate,_submission_time 
from [mindr-live].dbo.all_wra3b eb1
left join [mindr-live].dbo.schedule_wra s on s.id = eb1.scheduleid
left join (select eb2.uid,max(s.jivita_week) as schedule_week,max(w3bdate) w3bdate 
from [mindr-live].dbo.all_wra3b eb2
left join [mindr-live].dbo.schedule_wra s on s.id = eb2.scheduleid
where eb2.duplicate is null
group by eb2.uid
) a on a.uid = eb1.uid and eb1.w3bdate =a.w3bdate and s.jivita_week =a.schedule_week  
where a.w3bdate is not null
and eb1.duplicate is null 
) b group by b.uid,b.schedule_week,b.w3bdate) c on c.uid = eb.uid and c.schedule_week = s.jivita_week
and c.w3bdate = eb.w3bdate and c._submission_time = eb._submission_time
where duplicate is null and c.uid is not null

