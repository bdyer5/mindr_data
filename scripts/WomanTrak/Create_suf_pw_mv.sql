use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='suf_pw_mv')
begin 
drop view suf_pw_mv 
end 
go 

create view suf_pw_mv 
as 

select
su.uid,
su.formorder,
tlpin,
sector,
hhid,
womname,
husbname,
convert(smalldatetime,su.sudate,121) as sudate,
workerid,
sustatus,
suvisit,
convert(smalldatetime,sudod,121) as sudod,
suucol,
sufrsturin,
suebcu,
sutimebcu,
convert(smalldatetime,suudt,121) as suudt,
suucoltm,
sumidu,
suubkcb,
convert(smalldatetime,suupudt,121) as suupudt,
susampt,
suuspcid,
suussts,
workerid_urn,
suscol,
suins,
sucons,
convert(smalldatetime,suddef,121) as suddef,
sutdef,
suddefc,
convert(smalldatetime,susbkcb,121) as susbkcb,
sutdecc,
susspcid,
susssts,
workerid_stl,
version,
today,
start,
[end],
schedule_id as scheduleid,
suucolres,
suscolres,
/*st,*/
vt,
supt,
/*st1,*/
vts,
supts,
_date_modified,
_duration,
_id,
_media_all_received,
_media_count,
_notes,
su._submission_time,
_submitted_by,
_tags,
_total_media,
_uuid,
_version,
_xform_id,
duplicate,
id,
insert_time,
inserted_by,
instance_id,
hhchange,
newhhid,
idenconf,
update_time,
updateed_by
FROM [mindr-live].dbo.all_suf_pw su
left join 
----
(select b.uid,b.formorder,b.sudate,max(b._submission_time) _submission_time
from (select rb1.uid,rb1.formorder,convert(smalldatetime,rb1.sudate,121) as sudate,_submission_time from [mindr-live].dbo.all_suf_pw rb1
left join (select rb2.uid,rb2.formorder, max(convert(smalldatetime,sudate,121)) sudate 
from [mindr-live].dbo.all_suf_pw rb2
where duplicate is null -- and _id!=168558037 -- 532689 woman who did not get met for a swab and not met was entered after met visit , so keeping the status =1 
group by rb2.uid,rb2.formorder) a on a.uid = rb1.uid  and rb1.formorder=a.formorder and  convert(smalldatetime,rb1.sudate,121) =a.sudate where a.sudate is not null
and rb1.duplicate is null  --1166
) b group by b.uid,b.formorder,b.sudate) c on c.uid = su.uid and c.formorder = su.formorder  and c.sudate = su.sudate and c._submission_time = su._submission_time 
where duplicate is null and c.uid is not null
