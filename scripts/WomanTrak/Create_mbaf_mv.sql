use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='mbaf_mv')
begin 
drop view mbaf_mv
end 
go 

Create view mbaf_mv as 
SELECT
mb.uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
jw.jivitaweek as mbwkint,
convert(smalldatetime,mb.mbdate,121) as mbdate,
workerid,
mbrelat,
mbrelats,
mbstatus,
mbvital,
/*begind*/
mbweight,
mbsysto1,
mbdiast1,
mbbptime1,
/*begin1*/
mblbn,
mbsbn,
/*secbn2*/
/*sbn1*/
mb1sex,
mb1pof,
mb1stk,
mb1wrap,
mb1fresh,
mb1def,
/*sbn2*/
mb2sex,
mb2pof,
mb2stk,
mb2wrap,
mb2fresh,
mb2def,
/*sbn3*/
mb3sex,
mb3pof,
mb3stk,
mb3wrap,
mb3fresh,
mb3def,
/*begin13*/
mbtype,
mbtypes,
mbcsecres,
mbcsecrec,
mbwhr,
mbwhrs,
mbwho,
mbwhos,
mblaborp,
mbwhtl1,
mbwhtl2,
mbwhtl3,
mbbabyown,
/*byn*/
mabomass,
mbbohand,
mbbovmt,
mbbosal,
mbbosalij,
mbboij,
mbbodoc,
mbboforc,
mbbovac,
mbboepis,
mbbocsec,
mbplown,
/*byn1*/
mbplmass,
mbplhand,
mbplvmt,
mbpldoc,
mbplhosp,
mbploth,
mbenpl,
mbbleed,
/*secf*/
mbsysto2,
mbdiast2,
mbbptime2,
version,
today,
start,
[end],
scheduleid,
idenconf,
insert_time,
update_time,
inserted_by,
updateed_by,
mb._submission_time,
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
from [mindr-live].dbo.all_mbaf mb
join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,mb.mbdate,121)
left join 
(select b.uid,b.mbdate,max(b._submission_time) _submission_time
from (select mb1.uid,mb1.mbdate,_submission_time from [mindr-live].dbo.all_mbaf mb1
left join (select mb2.uid, max(mbdate) mbdate 
from [mindr-live].dbo.all_mbaf mb2
where duplicate is null
group by mb2.uid) a on a.uid = mb1.uid and mb1.mbdate =a.mbdate where a.mbdate is not null
and mb1.duplicate is null 

) b group by b.uid,b.mbdate) c on c.uid = mb.uid  and c.mbdate = mb.mbdate and c._submission_time = mb._submission_time 
where mb.duplicate is null and c.uid is not null                  
