use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='m36mopb_mv')
begin 
drop view m36mopb_mv
end 
go 

-- count is 198 
create view m36mopb_mv as 
select 
i3bfed,
scheduleid,
m3bbrstused1,
m36.uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
idenconf,
convert(smalldatetime,m36.m3bdate,121) as m3bdate,
workerid,
m3bstatus,
convert(smalldatetime,m3bdod,121) as m3bdod,
m3bsysto1,
m3bdiast1,
m3bbptime1,
workerid_bp,
m3bweight,
m3bmuac1,
m3bmuac2,
m3bmuac3,
m3bsysto2,
m3bdiast2,
m3bbptime2,
workerid_an,
m3blastfedd,
m3blastfedt,
m3blastfedbu,
m3bbrstused,
m3bbrstcln,
m3bcols,
m3bcole,
m3bbmilkv,
m3bbextrmtd,
m3bbrstemty,
m3bbmspecid,
workerid_bm,
version,
today,
start,
[end],
_date_modified,
_duration,
_id,
_media_all_received,
_media_count,
_notes,
m36._submission_time,
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
updateed_by,
m3bbptime2n,
stb,
suptb,
vtb



from [mindr-live].dbo.all_m3_6bf m36
join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,m36.m3bdate,121)
left join 
(select b.uid,b.m3bdate,max(b._submission_time) _submission_time
from (select m36_1.uid,m36_1.m3bdate,_submission_time from [mindr-live].dbo.all_m3_6bf m36_1
left join (select m36_2.uid, max(m3bdate) m3bdate 
from [mindr-live].dbo.all_m3_6bf m36_2
where duplicate is null
group by m36_2.uid) a on a.uid = m36_1.uid and m36_1.m3bdate =a.m3bdate where a.m3bdate is not null
and m36_1.duplicate is null 

) b group by b.uid,b.m3bdate) c on c.uid = m36.uid  and c.m3bdate = m36.m3bdate and c._submission_time = m36._submission_time 
where m36.duplicate is null and c.uid is not null                  
