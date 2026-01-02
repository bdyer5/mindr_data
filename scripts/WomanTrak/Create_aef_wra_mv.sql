use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='aef_wra_mv')
begin 
drop view aef_wra_mv
end 
go 

create view aef_wra_mv as 
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
aefdate,
workerid,
aeperson,
childuid,
childname,
aestatus,
/*secb*/
aeevent,
aediag,
aeondate,
aedescpt,
aefevntsum,
aelocate,
aeunexp,
aerel,
aeurel,
aedisc,
aehoscause,
aeact,
aeacts,
aelist,
version,
today,
start,
[end],
insert_time,
update_time,
ae._submission_time,
_date_modified,
scheduleid,
ae.personaffect,
instance_id as instanceid,
_id,
_uuid,
duplicate

from [mindr-live].dbo.all_aef_wra ae
join shapla.dbo.jivitaweek jw on jw.RomanDate = ae.aefdate
left join 
(select b.uid,b.aefdate,max(b._submission_time) _submission_time
from (select ae1.uid,ae1.aefdate,_submission_time from [mindr-live].dbo.all_aef_wra ae1
left join (select ae2.uid, max(aefdate) aefdate 
from [mindr-live].dbo.all_aef_wra ae2
group by ae2.uid) a on a.uid = ae1.uid and ae1.aefdate =a.aefdate where a.aefdate is not null
) b group by b.uid,b.aefdate) c on c.uid =ae.uid and c.aefdate = ae.aefdate and c._submission_time = ae._submission_time
where c.aefdate is not null and c._submission_time is not null and duplicate is null
go 
