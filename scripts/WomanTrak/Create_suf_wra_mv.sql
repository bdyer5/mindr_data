use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='suf_wra_mv')
begin 
drop view suf_wra_mv 
end 
go 

create view suf_wra_mv 
as 

select
uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
idenconf,
CONVERT(smalldatetime, sudate, 121) as sudate,
jw.jivitaweek as suwkint,
workerid,
sustatus,
suvisit,
sudod,
suucol,
sufrsturin,
suebcu,
sutimebcu,
suudt,
suucoltm,
sumidu,
suubkcb,
suupudt,
susampt,
suuspcid,
--st,
vt,
supt,
suussts,
workerid_urn,
suscol,
suins,
sucons,
suddef,
sutdef,
suddefc,
susbkcb,
sutdecc,
susspcid,
--st1,
vts,
supts,
susssts,
workerid_stl,
version,
today,
start,
[end],
formorder,
schedule_id as scheduleid,
case when suucolres ='null' then null else suucolres end as suucolres ,
insert_time,
update_time,
_submission_time,
_submitted_by,
_date_modified,
_xform_id,
instance_id as instanceid,
_duration,
_media_all_received,
_media_count,
_id,
_uuid,
_version,
_total_media,
id,   
duplicate 
FROM        [mindr-live].dbo.all_suf_wra LEFT OUTER JOIN
                  shapla.dbo.JiVitAWeek AS jw ON jw.RomanDate = CONVERT(smalldatetime, sudate, 121)
WHERE     (duplicate IS null)