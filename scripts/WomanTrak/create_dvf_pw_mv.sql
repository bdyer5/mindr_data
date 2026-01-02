use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='dvf_pw_mv')
begin 
drop view dvf_pw_mv
end 
go 


create view dvf_pw_mv as 
select 
uid,
tlpin,
sector,
hhid,
womname,
husbname,
convert(smalldatetime,date,121) as dvfdate,
workerid,
visittype,
visitstatus,
disdone,
dissupp,
referal,
hhchange,
newhhid,
idenconf,
today,
start,
[end],
version,
scheduleid,
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
duplicate,
id,
insert_time,
inserted_by,
instance_id,
update_time,
updateed_by
from all_dvf_pw m
where duplicate is null 


