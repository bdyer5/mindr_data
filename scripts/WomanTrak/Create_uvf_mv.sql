use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='uvf_mv')
begin 
drop view uvf_mv
end 
go 

Create view uvf_mv as 
SELECT
id,
uv.uid,
tlpin,
sector,
hhid,
womname,
husbname,
jw.jivitaweek as uvwkint,
convert(smalldatetime,uv.uvdate,121) as uvdate,
workerid,
uvstatus,
uvpregstatus,
uvfetus,
dob,
doc,
/*Sec B 1 - Embryo/fetus number 1*/
uvcrl11,
uvcrl21,
uvcrl31,
uvcrlcmt1,
uvbpd11,
uvbpd21,
uvbpd31,
uvbpdcmt1,
uvhc11,
uvhc21,
uvhc31,
uvhccmt1,
uvfl11,
uvfl21,
uvfl31,
uvflcmt1,
uvpregperiod1,
uvusref1,
/*Sec B 2 - Embryo/fetus number 2*/
uvcrl12,
uvcrl22,
uvcrl32,
uvcrlcmt2,
uvbpd12,
uvbpd22,
uvbpd32,
uvbpdcmt2,
uvhc12,
uvhc22,
uvhc32,
uvhccmt2,
uvfl12,
uvfl22,
uvfl32,
uvflcmt2,
uvpregperiod2,
uvusref2,
/*Sec B 3 - Embryo/fetus number 3*/
uvcrl13,
uvcrl23,
uvcrl33,
uvcrlcmt3,
uvbpd13,
uvbpd23,
uvbpd33,
uvbpdcmt3,
uvhc13,
uvhc23,
uvhc33,
uvhccmt3,
uvfl13,
uvfl23,
uvfl33,
uvflcmt3,
uvpregperiod3,
uvusref3	,
/*Sec B 4 - Embryo/fetus number 4*/
uvcrl14,
uvcrl24,
uvcrl34,
uvcrlcmt4,
uvbpd14,
uvbpd24,
uvbpd34,
uvbpdcmt4,
uvhc14,
uvhc24,
uvhc34,
uvhccmt4,
uvfl14,
uvfl24,
uvfl34,
uvflcmt4,
uvpregperiod4,
uvusref4,
/* meta data */
version,
today,
start,
[end],
schedule_id,
hhchange,
newhhid,
idenconf,
insert_time,
update_time,
inserted_by,
updateed_by,
uv._submission_time,
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
from [mindr-live].dbo.all_uvf uv
join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,uv.uvdate,121)
left join 
(select b.uid,b.uvdate,max(b._submission_time) _submission_time
from (select uv1.uid,uv1.uvdate,_submission_time from [mindr-live].dbo.all_uvf uv1
left join (select uv2.uid, max(uvdate) uvdate 
from [mindr-live].dbo.all_uvf uv2
where duplicate is null
group by uv2.uid) a on a.uid = uv1.uid and uv1.uvdate =a.uvdate where a.uvdate is not null
and uv1.duplicate is null 

) b group by b.uid,b.uvdate) c on c.uid = uv.uid  and c.uvdate = uv.uvdate and c._submission_time = uv._submission_time 
where uv.duplicate is null and c.uid is not null                  
