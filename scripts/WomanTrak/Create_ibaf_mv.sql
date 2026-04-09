use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='ibaf_mv')
begin 
drop view ibaf_mv
end 
go 

create view ibaf_mv as 
select
ib.[uid],
tlpin,
sector,
hhid,
hhchange,
newhhid,
jw.jivitaweek as ibwkint,
convert(smalldatetime,ib.ibdate,121) as ibdate,
womname,
husbname,
workerid,
ib.childuid,
childname,
childno,
ibsex,
/*ibrelat1,*/
case when len(ibrelat1) >0 then substring(ibrelat1,1,1) else ibrelat1 end as ibrelat1,
case when len(ibrelat1) >2 then  substring(ibrelat1,3,1) else null end as ibrelat2,
case when len(ibrelat1) >4 then  substring(ibrelat1,5,1) else null end as ibrelat3,
ibstatus,
convert(smalldatetime,ibdob,121) as ibdob,
ibbtimehr,
ibbtimemn,
ibbtimeap,
convert(smalldatetime,ibdod,121) as ibdod,
ibdtimehr,
ibdtimemn,
ibdtimeap,
ibpart,
ibparts,
ibstuck,
ibneck,
ibbrth,
ibcry1,
ibcry1s,
ibcry2,
ibcry2s,
ibcry3,
ibcry3s,
ibbrthc,
iblimb,
ibblue,
ibblueh,
ibbluef,
ibbluel,
ibblueb,
ibbfed,
ibbfedw,
ibbfhr,
ibbfclst,
/*ibbfoth1,*/
case when len(ibbfoth1) >1 then substring(ibbfoth1,1,2) else ibbfoth1 end as ibbfoth1,
case when len(ibbfoth1) >3 then  substring(ibbfoth1,4,2) else null end as ibbfoth2,
case when len(ibbfoth1) >6 then  substring(ibbfoth1,7,2) else null end as ibbfoth3,
ibbfoth1s,
ibatimehr,
ibatimemn,
ibatimeap,
ibweight,
ibmuac1,
ibmuac2,
ibmuac3,
ibcc1,
ibcc2,
ibcc3,
ibhc1,
ibhc2,
ibhc3,
ibheight1,
ibheight2,
ibheight3,
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
ib._submission_time,
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
from [mindr-live].dbo.all_ibaf ib
join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,ib.ibdate,121)
left join 
(select b.childuid,b.ibdate,max(b._submission_time) _submission_time
from (select ib1.childuid,ib1.ibdate,_submission_time from [mindr-live].dbo.all_ibaf ib1
left join (select ib2.childuid, max(ibdate) ibdate 
from [mindr-live].dbo.all_ibaf ib2
where duplicate is null
group by ib2.childuid) a on a.childuid = ib1.childuid and ib1.ibdate =a.ibdate where a.ibdate is not null
and ib1.duplicate is null 

) b group by b.childuid,b.ibdate) c on c.childuid = ib.childuid  and c.ibdate = ib.ibdate and c._submission_time = ib._submission_time 
where ib.duplicate is null and c.childuid is not null                  
