
use [mindr-live] 
go 



print 'drop view psf_prep_mv if exists '


print 'drop view psf_prep_mv if exists '


if exists(select o.name from sysobjects o where o.name='psf_mv_prep')
begin 
drop view psf_mv_prep
end 
go 

print 'drop view psf_mv if exists'

if exists(select o.name from sysobjects o where o.name='psf_mv')
begin 
drop view psf_mv
end 
go 



print 'creating psf_mv_prep'
go 

create view  psf_mv_prep
as 

select
p.uid,
p.tlpin,
p.sector,
p.hhid,
jw.jivitaweek as psfwkint,
convert(smalldatetime,p.psfdate,121) as psfdate,
/*hhchange,*/
/*newhhid,*/
womname,
husbname,
workerid,
psstatus,
pslmpddc,
pslmpmm,
pslmpyy,
pslmpdd,
pslmp,
lmp_display,
lmp_displayt,
lmp_displayt1,
psurt,
version,
today,
start,
[end],
scheduleid,
/*idenconf,*/
p.insert_time,
p.update_time,
_submission_time,
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
duplicate,
'PSF' as source
from [mindr-live].dbo.all_psf p 
join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,psfdate,121)
left join [mindr-live].dbo.schedule_pw s on s.id = p.scheduleid
where duplicate is null

go


print 'create view psf_mv ...'
go 
create view psf_mv as 
select 
uid,
tlpin,
sector,
hhid,
nwewkint as psfwkint,
nwedate as psfdate,
womname,
husbname,
/*nwecurpreg,*/
/*hhchange,*/
/*newhhid,*/
workerid,
nwestatus as psstatus,
nwelmpddc as pslmpddc,
nwelmpmm as pslmpmm,
nwelmpyy as pslmpyy,
nwelmpdd as pslmpdd,
nwelmp  as pslmp,
lmp_display,
lmp_displayt,
lmp_displayt1,
nweurt  as psurt,
[version],
today,
[start],
[end],
scheduleid,
/*idenconf,*/
insert_time,
update_time,
_submission_time,
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
duplicate,
'NWEF' as source
from nwef_mv_prep
where nwestatus ='1'
and nwecurpreg is not null 
and uid is not null 

union 


select 
uid,
tlpin,
sector,
hhid,
wewkint as psfwkint,
wedate as psfdate,
/*nwecurpreg,*/
/*hhchange,*/
womname,
husbname,
workerid,
westatus as psstatus,
welmpddc as pslmpddc,
welmpmm as pslmpmm,
welmpyy as pslmpyy,
welmpdd as pslmpdd,
welmp  as pslmp,
lmp_display,
null as lmp_displayt,
null as lmp_displayt1,
weurt  as psurt,
[version],
today,
[start],
[end],
scheduleid,
/*idenconf,*/
insert_time,
update_time,
_submission_time,
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
duplicate,
'WEF' as source
from wef_mv_prep
where westatus ='1'
and uid is not null
and wecurpreg is not null  

union 

select 
p.uid,
p.tlpin,
p.sector,
p.hhid,
psfwkint,
psfdate,
/*hhchange,*/
/*newhhid,*/
womname,
husbname,
workerid,
psstatus,
pslmpddc,
pslmpmm,
pslmpyy,
pslmpdd,
pslmp,
lmp_display,
lmp_displayt,
lmp_displayt1,
psurt,
version,
today,
start,
[end],
scheduleid,
/*idenconf,*/
p.insert_time,
p.update_time,
_submission_time,
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
duplicate,
'PSF' as source
from [mindr-live].dbo.psf_mv_prep p 

go 

