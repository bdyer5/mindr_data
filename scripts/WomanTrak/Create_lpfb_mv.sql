use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='lpfb_mv')
begin 
drop view lpfb_mv
end 
go 

Create view lpfb_mv as 
select 
lpb.uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
idenconf,
convert(smalldatetime,lpb.lpbdate,121) as lpbdate,
workerid,
lpbstatus,
convert(smalldatetime,lpbdoc,121) as lpbdoc,
convert(smalldatetime,lpbdod,121) as lpbdod,
/*begin1*/
lpbtemp,
lpbtempn1,
lpbsysto1,
lpbdiast1,
lpbbptime1,
workerid_bp,
/*begin2*/
lpbweight,
lpbmuac1,
lpbmuac2,
lpbmuac3,
/*cb*/
lpbsysto2,
lpbdiast2,
lpbbptime2,
lpbbptime2n,
workerid_an,
/*begin3*/
lpbmealdate,
lpbmealtime,
lpbmealtimec,
lpbfood,
lpbblood1,
/*dd*/
lpbblood2,
lpbspecid1,
st,
vt,
supt,
/*ny*/
lpbspecid2,
st1,
vt1,
supt1,
/*ny1*/
lpbbldtime,
lpbhemo,
lpbfetab,
workerid_bl,
version,
today,
start,
[end],
/*formorder,*/
scheduleid,
insert_time,
update_time,
inserted_by,
updateed_by,
lpb._submission_time,
_submitted_by,
_date_modified,
_xform_id,
instance_id,
_duration,
_media_all_received,
_media_count,
_id,
_uuid,
_version,
duplicate
from all_lpfb  lpb
join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,lpb.lpbdate,121)
left join 
(select b.uid,b.lpbdate,max(b._submission_time) _submission_time
from (select lpb1.uid,lpb1.lpbdate,_submission_time from [mindr-live].dbo.all_lpfb lpb1
left join (select lpb2.uid, max(lpbdate) lpbdate 
from [mindr-live].dbo.all_lpfb lpb2
where duplicate is null
group by lpb2.uid) a on a.uid = lpb1.uid and lpb1.lpbdate =a.lpbdate where a.lpbdate is not null
and lpb1.duplicate is null 

) b group by b.uid,b.lpbdate) c on c.uid = lpb.uid  and c.lpbdate = lpb.lpbdate and c._submission_time = lpb._submission_time 
where lpb.duplicate is null and c.uid is not null                  

