use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='m69mopb_mv')
begin 
drop view m69mopb_mv
end 
go 

-- count is 198 
create view m69mopb_mv as 
select 
i6bfed,
schedule_id as scheduleid,
m6bbrstused1,
infsts,
m6bbsaliva1,
i6bbsaliva1,
m69.uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
idenconf,
convert(smalldatetime,m69.m6bdate,121) as m6bdate,
workerid,
m6bstatus,
convert(smalldatetime,m6bdod,121) as m6bdod,
m6bsysto1,
m6bdiast1,
m6bbptime1,
workerid_bp,
m6bweight,
m6bmuac1,
m6bmuac2,
m6bmuac3,
m6bsysto2,
m6bdiast2,
m6bbptime2,
m6bbptime2n,
workerid_an,
m6blastfedd,
m6blastfedt,
m6blastfedbu,
m6bbrstused,
m6bbrstcln,
m6bcols,
m6bcole,
m6bbmilkv,
m6bbextrmtd,
m6bbrstemty,
m6bbmspecid,
workerid_bm,
m6bbconsumpt30min,
m6bbsaliva,
m6bbsponge2m,
m6bbsalivat,
m6bbspecimenid,
workerid_ms,
i6bbconsumpt30min,
i6bbsaliva,
i6bbsponge2m,
i6bbsalivat,
i6bbspecimenid,
workerid_is,
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
m69._submission_time,
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
m6blastfedtc,
schedule_id,
st,
stb,
sti,
supt,
suptb,
supti,
update_time,
updateed_by,
vt,
vtb,
vti




from [mindr-live].dbo.all_m6_9bf m69
join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,m69.m6bdate,121)
left join 
(select b.uid,b.m6bdate,max(b._submission_time) _submission_time
from (select m69_1.uid,m69_1.m6bdate,_submission_time from [mindr-live].dbo.all_m6_9bf m69_1
left join (select m69_2.uid, max(m6bdate) m6bdate 
from [mindr-live].dbo.all_m6_9bf m69_2
where duplicate is null
group by m69_2.uid) a on a.uid = m69_1.uid and m69_1.m6bdate =a.m6bdate where a.m6bdate is not null
and m69_1.duplicate is null 
) b group by b.uid,b.m6bdate) c on c.uid = m69.uid  and c.m6bdate = m69.m6bdate and c._submission_time = m69._submission_time 
where m69.duplicate is null and c.uid is not null                  
