use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='nwef_mv_prep')
begin 
drop view nwef_mv_prep 
end 
go 

create view nwef_mv_prep 
as 

select 
/*from ona form should be correct order ish*/
/*from nwef table */
/*nuid as uid,*/
/*euid,*/
coalesce(nuid,euid) as uid,
pwuid,
tlpin,
sector,
hhid,
womname,
husbname,
jw.jivitaweek as nwewkint,
convert(smalldatetime,nwedate,121) as nwedate,
workerid,
nwestatus,
wef_consent as nwef_consent,
wef_fconsent as nwef_fconsent,
wef_dconsent as nwef_dconsent,
nwejivita,
nwejivitamc,
nwejivitacap,
nwejivitakcap,
nwejivitamob,
nwehhmerr,
wsts1,
nwewsts,
wsts,
subyy,
submm,
subdd,
nwedobdd,
nwedobmm,
nwedobyy,
case when isdate(nwedobdate) = 1  then convert(smalldatetime,nwedobdate,121) else null end  as nwedobdate,
nwedobmmc,
nwedobddc,
agecal1,
agemm,
agedd,
agecal,
wemarrlhus as nwemarrlhus,
/*nwemarrydatedd,<-- missing */
/*nwemarrydatemm,<-- missing */
/*nwemarrydateyy,<-- missing */
/*nwemarrydateddbc,<-- missing */
/*nwehusage,<-- missing */
wecurpreg as nwecurpreg,
welmpddc as nwelmpddc,
welmpmm as nwelmpmm,
welmpyy as nwelmpyy,
welmpdd as nwelmpdd,
welmp as nwelmp,
lmp_display,
lmp_displayt,
lmp_displayt1,
weurt as nweurt,
weinft as nweinft,
wecurbfd as nwecurbfd,
wewant6m as nwewant6m,
wefpm as nwefpm,
wefpt as nwefpt,
wef_pw_consent as nwef_pw_consent,
welrins as nwelrins,
nweownmob,
nwemobno,
nwecont,
nwecontno,
nwecontown,
surt,
surtc,
version,
today,
start,
[end],
scheduleid,
pwcon,
/*dmc <-- missing */
/*pwuid,*/
duplicate,
_date_modified,
_duration,
_media_all_received,
_media_count,
_id,
_uuid,
_version,
_submission_time,
_submitted_by,
_total_media,
_xform_id,
instanceid,
id,
insert_time,
update_time,
'nwef' as wef_src
from [mindr-live].dbo.all_nwef
join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,nwedate,121)
where duplicate is null

union 

select 
/*from ona form should be correct order ish*/
/*from nwef table */
/*nuid as uid,*/
/*euid,*/
coalesce(nuid,euid) as uid,
pwuid,
tlpin,
sector,
hhid,
womname,
husbname,
jw.jivitaweek as nwewkint,
convert(smalldatetime,nwedate,121) as nwedate,
workerid,
nwestatus,
wef_consent as nwef_consent,
wef_fconsent as nwef_fconsent,
wef_dconsent as nwef_dconsent,
nwejivita,
nwejivitamc,
nwejivitacap,
nwejivitakcap,
nwejivitamob,
nwehhmerr,
wsts1,
nwewsts,
wsts,
subyy,
submm,
subdd,
nwedobdd,
nwedobmm,
nwedobyy,
case when isdate(nwedobdate) = 1  then convert(smalldatetime,nwedobdate,121) else null end  as nwedobdate,
nwedobmmc,
nwedobddc,
agecal1,
agemm,
agedd,
agecal,
wemarrlhus as nwemarrlhus,
/*nwemarrydatedd,<-- missing */
/*nwemarrydatemm,<-- missing */
/*nwemarrydateyy,<-- missing */
/*nwemarrydateddbc,<-- missing */
/*nwehusage,<-- missing */
wecurpreg as nwecurpreg,
welmpddc as nwelmpddc,
welmpmm as nwelmpmm,
welmpyy as nwelmpyy,
welmpdd as nwelmpdd,
welmp as nwelmp,
lmp_display,
null as lmp_displayt,
null as lmp_displayt1,
weurt as nweurt,
weinft as nweinft,
wecurbfd as nwecurbfd,
wewant6m as nwewant6m,
wefpm as nwefpm,
wefpt as nwefpt,
wef_pw_consent as nwef_pw_consent,
welrins as nwelrins,
nweownmob,
nwemobno,
nwecont,
nwecontno,
nwecontown,
surt,
surtc,
version,
today,
start,
[end],
scheduleid,
pwcon,
/*dmc <-- missing */
/*pwuid,*/
duplicate,
_date_modified,
_duration,
_media_all_received,
_media_count,
_id,
_uuid,
_version,
_submission_time,
_submitted_by,
_total_media,
_xform_id,
instanceid,
id,
insert_time,
update_time, 
'nwef-mopup' as wef_src
from [mindr-live].dbo.all_nwef_mopup
join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,nwedate,121)
where duplicate is null