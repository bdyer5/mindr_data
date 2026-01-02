use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='i69mop_sf_mv')
begin 
drop view i69mop_sf_mv
end 
go 

create view i69mop_sf_mv as 
select 
uid,
i69.childuid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
childname,
husbname,
idenconf,
convert(smalldatetime,i69.i6date,121) as i6date,
workerid,
i6relat1,
i6status,
convert(smalldatetime,i6dod,121) as i6dod,
i6suscol,
i6suins,
i6sucons,
i6susts,
i6suddef,
i6sutdef,
i6suddefc,
i6susbkcb,
i6sutdecc,
i6susspcid,
i6susssts,
workerid_stl,
version,
today,
start,
[end],
/*schedule_id as scheduleid,*/
_date_modified,
_duration,
_id,
_media_all_received,
_media_count,
_notes,
i69._submission_time,
_submitted_by,
_tags,
_total_media,
_uuid,
_version,
_xform_id,
duplicate,
i6suddefcc,
i6susbkcbfcc,
id,
insert_time,
inserted_by,
instance_id,
st1,
supts,
update_time,
updateed_by,
vts

from [mindr-live].dbo.all_i6_9sf i69
join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,i69.i6date,121)
left join 
(select b.childuid,b.i6date,max(b._submission_time) _submission_time
from (select i69_1.childuid,i69_1.i6date,_submission_time from [mindr-live].dbo.all_i6_9sf i69_1
left join (select i69_2.childuid, max(i6date) i6date 
from [mindr-live].dbo.all_i6_9sf i69_2
where duplicate is null
group by i69_2.childuid) a on a.childuid = i69_1.childuid and i69_1.i6date =a.i6date where a.i6date is not null
and i69_1.duplicate is null 

) b group by b.childuid,b.i6date) c on c.childuid = i69.childuid  and c.i6date = i69.i6date and c._submission_time = i69._submission_time 
where i69.duplicate is null and c.childuid is not null                  
go 

