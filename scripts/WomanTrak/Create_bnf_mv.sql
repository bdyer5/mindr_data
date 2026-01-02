use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='bnf_mv')
begin 
drop view bnf_mv
end 
go 

Create view bnf_mv as 
SELECT
bn.uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
jw.jivitaweek as bnwkint,
convert(smalldatetime,bn.bnfdate,121) as bnfdate,
workerid,
/*secb*/
bnftype,
bnfnb,
bnfchldvitsts1,
bnfchldvitsts2,
bnfchldvitsts3,
bnfdtoo,
bnfcloc,
bnfreladdr,
bnfrelhmea,
bnfnfac,
bnfnfaca,
bnfwomcall,
bnfwommob,
bnfwommob_2
version,
today,
start,
[end],
scheduleid,
submm,
subyy,
todaymmyy,
idenconf,
insert_time,
update_time,
inserted_by,
updateed_by,
bn._submission_time,
_submitted_by,
_date_modified,
_xform_id,
instanceid,
_duration,
_media_all_received,
_media_count,
_id,
_uuid,
_version,
duplicate
from [mindr-live].dbo.all_bnf bn
join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,bn.bnfdate,121)
left join 
(select b.uid,b.bnfdate,max(b._submission_time) _submission_time
from (select bn1.uid,bn1.bnfdate,_submission_time from [mindr-live].dbo.all_bnf bn1
left join (select bn2.uid, max(bnfdate) bnfdate 
from [mindr-live].dbo.all_bnf bn2
where duplicate is null
group by bn2.uid) a on a.uid = bn1.uid and bn1.bnfdate =a.bnfdate where a.bnfdate is not null
and bn1.duplicate is null 

) b group by b.uid,b.bnfdate) c on c.uid = bn.uid  and c.bnfdate = bn.bnfdate and c._submission_time = bn._submission_time 
where bn.duplicate is null and c.uid is not null                  
