use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='mpfb_mv')
begin 
drop view mpfb_mv
end 
go 

Create view mpfb_mv as 
select 
mp.uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
idenconf,
jw.jivitaweek as mpbwkint,
convert(smalldatetime,mp.mpbdate,121)  as mpbdate,
workerid,
mpbstatus,
convert(smalldatetime,mpbdoc,121) as mpbdoc,
convert(smalldatetime,mpbdod,121) as mpbdod,
/*begin1*/
mpbtemp,
mpbtempn1,
mpbsysto1,
mpbdiast1,
mpbbptime1,
workerid_bp,
/*begin2*/
mpbweight,
mpbmuac1,
mpbmuac2,
mpbmuac3,
/*cb*/
mpbsysto2,
mpbdiast2,
mpbbptime2,
mpbbptime1n,
workerid_an,
/*begin3*/
mpbmealdate,
mpbmealtime,
mpbmealtimec,
mpbfood,
mpbblood1,
/*dd*/
mpbblood2,
mpbspecid1,
st,
vt,
supt,
/*ny*/
mpbspecid2,
st1,
vt1,
supt1,
/*ny1*/
mpbbldtime,
mpbhemo,
mpbfetab,
workerid_bl,
version,
today,
start,
[end],
/*formorder,*/
scheduleid,
insert_time,
update_time,
mp._submission_time,
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
from [mindr-live].dbo.all_mpfb mp
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,mp.mpbdate,121) 
left join 
(select b.uid,b.mpbdate,max(b._submission_time) _submission_time
from (select mp1.uid,mp1.mpbdate,_submission_time from [mindr-live].dbo.all_mpfb mp1
left join (select mp2.uid, max(mpbdate) mpbdate 
from [mindr-live].dbo.all_mpfb mp2
where duplicate is null
group by mp2.uid) a on a.uid = mp1.uid and mp1.mpbdate =a.mpbdate where a.mpbdate is not null
and mp1.duplicate is null 

) b group by b.uid,b.mpbdate) c on c.uid = mp.uid  and c.mpbdate = mp.mpbdate and c._submission_time = mp._submission_time 
where mp.duplicate is null and c.uid is not null                  
