use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='i36mop_sf_mv')
begin 
drop view i36mop_sf_mv
end 
go 

create view i36mop_sf_mv as 
select 
uid,
i36.childuid,
tlpin,
sector,
hhid,
womname,
childname,
husbname,
i36.i3date,
workerid,
case when len(i3relat1)>=1 then  substring(i3relat1,1,1) end as i3relat1,
case when len(i3relat1)>1 then substring(i3relat1,3,1) else null end as i3relat2,
case when len(i3relat1)>3 then substring(i3relat1,5,1) else null end as i3relat3,
--null as i3relat3,
i3status,
i3dod,
i3suscol,
i3suins,
i3sucons,
i3susts,
i3suddef,
i3sutdef,
i3suddefc,
i3susbkcb,
i3sutdecc,
i3susspcid,
i3susssts,
workerid_stl,
version,
today,
start,
[end],
--formorder,
scheduleid,
suucolres,
i3suscolres,
hhchange,
newhhid,
idenconf,
_date_modified,
_duration,
_id,
_media_all_received,
_media_count,
_notes,
i36._submission_time,
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
st1,
supts,
update_time,
updateed_by,
vts

from [mindr-live].dbo.all_i3_6sf i36
join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,i36.i3date,121)
left join 
(select b.childuid,b.i3date,max(b._submission_time) _submission_time
from (select i36_1.childuid,i36_1.i3date,_submission_time from [mindr-live].dbo.all_i3_6sf i36_1
left join (select i36_2.childuid, max(i3date) i3date 
from [mindr-live].dbo.all_i3_6sf i36_2
where duplicate is null
group by i36_2.childuid) a on a.childuid = i36_1.childuid and i36_1.i3date =a.i3date where a.i3date is not null
and i36_1.duplicate is null 

) b group by b.childuid,b.i3date) c on c.childuid = i36.childuid  and c.i3date = i36.i3date and c._submission_time = i36._submission_time 
where i36.duplicate is null and c.childuid is not null                  
go 

