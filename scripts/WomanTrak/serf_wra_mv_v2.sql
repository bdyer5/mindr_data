use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='serf_wra_mv_prep_v2')
begin 
drop view serf_wra_mv_prep_v2
end 
go 

create view serf_wra_mv_prep_v2 
as
select 
sr.uid,
tlpin,
sector,
hhid,
womname,
husbname,
sr.srdate,
workerid,
srstatus,
srdod,
srrp_wmf,
srrp_px,
srrp_hemo,
srrp_bp,
srsuprel,
srrpdec,
version,
today,
start,
[end],
wmvmt7_1,
wmdiar7_1,
wmtoes7_1,
wmrash7_1,
wmhair7_1,
wmweak7_1,
wmhach7_1,
wmvision7_1,
wmbleed7_1,
wmdys7_1,
wmbruis7_1,
wmodor7_1,
bpformname1,
diastolic1,
systolic1,
glucose1,
alt1,
ast1,
calcium1,
sodium1,
potassium1,
creatinine1,
blood_urea_nitrogen1,
total_carbon_dioxide1,
wmvmt7_2,
wmdiar7_2,
wmtoes7_2,
wmrash7_2,
wmhair7_2,
wmweak7_2,
wmhach7_2,
wmvision7_2,
wmbleed7_2,
wmdys7_2,
wmbruis7_2,
wmodor7_2,
bpformname2,
diastolic2,
systolic2,
glucose2,
alt2,
ast2,
calcium2,
sodium2,
potassium2,
creatinine2,
blood_urea_nitrogen2,
total_carbon_dioxide2,
wmf1date,
wmf2date,
bpdate1,
bpdate2,
pxdate1,
pxdate2,
hemo1,
hemo2,
hemodate1,
hemodate2,
diastolic12,
systolic12,
diastolic22,
systolic22,
scheduleid,
formorder,
hhchange,
newhhid,
idenconf,
_date_modified,
_duration,
_id,
_media_all_received,
_media_count,
_notes,
sr._submission_time,
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
updateed_by
from all_serf_v2_wra sr 

left join 
----
(select b.uid,b.srdate,max(b._submission_time) _submission_time
from (select sr1.uid,sr1.srdate,_submission_time from [mindr-live].dbo.all_serf_v2_wra sr1
left join (select sr2.uid, sr2.srdate 
from [mindr-live].dbo.all_serf_v2_wra sr2
where duplicate is null
group by sr2.uid,sr2.srdate ) a on a.uid = sr1.uid and sr1.srdate =a.srdate where a.srdate is not null
and sr1.duplicate is null 

) b group by b.uid,b.srdate) c on c.uid = sr.uid  and c.srdate = sr.srdate and c._submission_time = sr._submission_time 
where sr.duplicate is null and c.uid is not null                  

-- note that this will probably be update for the one that is the correct record for 364980 and 703314
