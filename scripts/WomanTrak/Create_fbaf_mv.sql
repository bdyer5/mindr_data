use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='fbaf_mv')
begin 
drop view fbaf_mv
end 
go 

create view fbaf_mv as 
select
fb.[uid],
tlpin,
sector,
hhid,
hhchange,
newhhid,
jw.jivitaweek as fbwkint ,
convert(smalldatetime,fb.fbdate,121) as fbdate,
womname,
husbname,
workerid,
fb.childuid,
childname,
childno,
fbsex,
fbrelat1,
fbstatus,
convert(smalldatetime,fbdob,121) as fbdob,
fbbtimehr,
fbbtimemn,
fbbtimeap,
convert(smalldatetime,fbdod,121) as fbdod,
fbdtimehr,
fbdtimemn,
fbdtimeap,
fbatimehr,
fbatimemn,
fbatimeap,
fbweight,
fbmuac1,
fbmuac2,
fbmuac3,
fbcc1,
fbcc2,
fbcc3,
fbhc1,
fbhc2,
fbhc3,
fbheight1,
fbheight2,
fbheight3,
version,
today,
start,
[end],
scheduleid,
/*submm,*/
/*subyy,*/
/*todaymmyy,*/
idenconf,
insert_time,
update_time,
inserted_by,
updateed_by,
fb._submission_time,
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
duplicate
from [mindr-live].dbo.all_fbaf fb
join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,fb.fbdate,121)
left join 
(select b.childuid,b.fbdate,max(b._submission_time) _submission_time
from (select fb1.childuid,fb1.fbdate,_submission_time from [mindr-live].dbo.all_fbaf fb1
left join (select fb2.childuid, max(fbdate) fbdate 
from [mindr-live].dbo.all_fbaf fb2
where duplicate is null
group by fb2.childuid) a on a.childuid = fb1.childuid and fb1.fbdate =a.fbdate where a.fbdate is not null
and fb1.duplicate is null 

) b group by b.childuid,b.fbdate) c on c.childuid = fb.childuid  and c.fbdate = fb.fbdate and c._submission_time = fb._submission_time 
where fb.duplicate is null and c.childuid is not null                  
