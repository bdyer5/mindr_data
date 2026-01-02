use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='sif_mv')
begin 
drop view sif_mv 
end 
go 
/*Salt test dataset*/
create view sif_mv 
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
convert(smalldatetime,sidate,121) as sidate,
workerid,
sistatus,
sistmnt,
sisalttype,
sisaltstore,
sisaltstores,
silid,
siresult,
version,
today,
start,
[end],
update_time,
updateed_by,
insert_time,
inserted_by,
instance_id,
scheduleid,
id,
_date_modified,
_duration,
_id,
_media_all_received,
_media_count,
_notes,
_submission_time,
_submitted_by,
_tags,
_total_media,
_uuid,
_version,
_xform_id,
duplicate
from all_sit
WHERE duplicate is null
