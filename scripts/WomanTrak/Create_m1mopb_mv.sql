use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='m1mopb_mv')
begin 
drop view m1mopb_mv
end 
go 

Create view m1mopb_mv as 
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
convert(smalldatetime,mp.m1bdate,121) as m1bdate,
workerid,
m1bstatus,
convert(smalldatetime,mp.m1bdod,121) as m1bdod,
/*begin1*/
m1btemp,
m1btempn1,
m1bsysto1,
m1bdiast1,
m1bbptime1,
workerid_bp,
/*begin2*/
m1bweight,
m1bmuac1,
m1bmuac2,
m1bmuac3,
/*cb*/
m1bsysto2,
m1bdiast2,
m1bbptime2,
m1bbptime2n,
workerid_an,
/*begin4*/
m1blastfedt,
m1blastfedbu,
m1bbrstused,
/*begin5*/
m1bbrstcln,
m1bcols,
m1bcole,
m1bbmilkv,
m1bbrstemty,
m1bbmspecid,
stb,
vtb,
suptb,
/*nyb*/
workerid_bm,
/*begin3*/
convert(smalldatetime,m1bmealdate,121) as m1bmealdate,
m1bmealtime,
m1bmealtimec,
m1bfood,
m1bblood1,
/*dd*/
m1bblood2,
m1bspecid1,
st,
vt,
supt,
/*ny*/
m1bspecid2,
st1,
vt1,
supt1,
/*ny1*/
m1bbldtime,
m1bhemo,
m1bfetab,
workerid_bl,
childvts,
version,
today,
start,
[end],
--mp.formorder,
mp.schedule_id as scheduleid,
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
from [mindr-live].dbo.all_m1mopb mp
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,mp.m1bdate,121) 
left join 
(select b.uid,b.m1bdate,max(b._submission_time) _submission_time
from (select mp1.uid,mp1.m1bdate,_submission_time from [mindr-live].dbo.all_m1mopb mp1
left join (select mp2.uid, max(m1bdate) m1bdate 
from [mindr-live].dbo.all_m1mopb mp2
where duplicate is null
group by mp2.uid) a on a.uid = mp1.uid and mp1.m1bdate =a.m1bdate where a.m1bdate is not null
and mp1.duplicate is null 

) b group by b.uid,b.m1bdate) c on c.uid = mp.uid  and c.m1bdate = mp.m1bdate and c._submission_time = mp._submission_time 
where mp.duplicate is null and c.uid is not null                  

