use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='wef_nwef_mv_prep')
begin 
drop view wef_nwef_mv_prep
end 
go 

create view wef_nwef_mv_prep
as 

select 
uid,
pwuid,
tlpin,
sector,
hhid,
nwewkint as wewkint,
nwedate as wedate,
workerid,
nwestatus as westatus,
nwef_consent as wef_consent,
nwef_fconsent as wef_fconsent,
nwef_dconsent as wef_dconsent,
nwejivita,
nwejivitamc,
nwejivitacap,
nwejivitakcap,
nwejivitamob,
nwehhmerr,
wsts1,
nwewsts,
wsts,
nwedobdd,
nwedobmm,
nwedobyy,
convert(smalldatetime , cast(nwedobyy as varchar(4)) +'-'+ case when nwedobmm = '99' then RIGHT('00' + CAST(nwedobmmc AS VARCHAR(2)), 2) else nwedobmm end +'-'+ 
case when nwedobdd = '99' then
RIGHT('00' + CAST(nwedobddc AS VARCHAR(2)), 2) 
when nwedobdd='30' and nwedobmm='02' and nwedobyy ='2001' then '28'  else nwedobdd end) as nwedobdate,
nwedobmmc,
nwedobddc,
agecal1,
agemm,
agedd,
agecal,
null as weagen,
nwemarrlhus as wemarrlhus,
nwemarrydatedd,/*<-- missing */
nwemarrydatemm,/*<-- missing */
nwemarrydateyy,/*<-- missing */
nwemarrydateddbc,/*<-- missing */
case when cast(nwemarrydateyy as varchar(4)) in ('1023','1019') then null 
else convert(smalldatetime , (cast(nwemarrydateyy as varchar(4)) 
+'-'+ case when nwemarrydatemm = '99' then '06' else nwemarrydatemm end 
+'-'+ case when nwemarrydatedd = '99' then '15' else nwemarrydatedd end)) end as nwemarrydate,
nwehusage,/*<-- missing */
nwecurpreg as wecurpreg,
nwelmpddc as welmpddc,
nwelmpmm as welmpmm,
nwelmpyy as welmpyy,
nwelmpdd as welmpdd,
nwelmp as welmp,
nwelmpdate as welmpdate, /*<- need to add this */
welmp3m,
lmp_display,
lmp_displayt,
lmp_displayt1,
nweurt as weurt,
nweinft as weinft,
nwecurbfd as wecurbfd,
nwewant6m as wewant6m,
nwefpm as wefpm,
nwefpt as wefpt,
nwef_pw_consent as wef_pw_consent,
nwelrins as welrins,
nweownmob as weownmob,
nwemobno as wemobno,
nwecont as wecont,
nwecontno as wecontno,
nwecontown as wecontown,
null as weothmarr,		  
null as wenomarr,
surt,
surtc,
version,
today,
start,
[end],
subdd,
submm,
subyy,  
scheduleid,
null as hhchange,
null as newhhid,
null as idenconf,
pwcon,
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
_total_media,
duplicate,
wef_src
 from nwef_mv_prep 

union 

select 
uid,
null as pwuid,
tlpin,
sector,
hhid,
wewkint,
wedate,
workerid,
westatus,
wef_consent,
wef_fconsent,
wef_dconsent,
null as nwejivita,
null as nwejivitamc,
null as nwejivitacap,
null as nwejivitakcap,
null as nwejivitamob,
null as nwehhmerr,
null as wsts1,
null as nwewsts,
null as wsts,
null as nwedobdd,
null as nwedobmm,
null as nwedobyy,
null as nwedobdate,
null as nwedobmmc,
null as nwedobddc,
null as agecal1,
null as agemm,
null as agedd,
null as agecal,
weagen,
wemarrlhus,
null as nwemarrydatedd,/*<-- missing */
null as nwemarrydatemm,/*<-- missing */
null as nwemarrydateyy,/*<-- missing */
null as nwemarrydateddbc,/*<-- missing */
null as nwemarrydate,
null as nwehusage,/*<-- missing */
wecurpreg,
welmpddc,
welmpmm,
welmpyy,
welmpdd,
welmp,
welmpdate,
welmp3m,
lmp_display,
null as lmp_displayt,
null as lmp_displayt1,
weurt,
weinft,
wecurbfd,
wewant6m,
wefpm,
wefpt,
wef_pw_consent,
welrins,
weownmob,
wemobno,
wecont,
wecontno,
wecontown,
weothmarr,
wenomarr,
surt,
surtc,
version,
today,
start,
[end],
subdd,
submm,
subyy,
scheduleid,
hhchange,
newhhid,
idenconf,
null as pwcon,
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
_total_media, 
duplicate,
wef_src
 from wef_mv_prep 









