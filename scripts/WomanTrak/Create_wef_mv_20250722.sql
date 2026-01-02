use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='wef_mv_prep')
begin 
drop view wef_mv_prep 
end 
go 

create view wef_mv_prep
as 
select
uid,
tlpin,
sector,
hhid,
womname,
husbname,
jw.jivitaweek as wewkint,
convert(smalldatetime,wedate,121) as wedate,
workerid,
westatus,
wef_consent,
wef_fconsent,
wef_dconsent,
weagen,
wemarrlhus,
wecurpreg,
welmpddc,
welmpmm,
welmpyy,
welmpdd,
welmp,
case when cast(welmpyy as varchar(4)) not like '20%' or welmpdd ='66'  then null 
else convert(smalldatetime , cast(welmpyy as varchar(4)) 
+'-'+ case when welmpmm = '99' then '06'
when welmpmm='02' and welmpdd in ('29','30') and welmpyy='2023' then '03' else welmpmm end 
+'-'+ case when welmpdd = '99' then '15'
when welmpmm='02' and welmpdd in ('29') and welmpyy='2023' then '01'
when welmpmm='02' and welmpdd in ('30') and welmpyy='2023' then '02' else welmpdd end)
end  as welmpdate,
null as welmp3m,
lmp_display,
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
/*--not in table pw,*/
/*--not in table wra,*/
surt,
surtc,
version,
today,
start,
[end],
subdd,
submm,
subyy,
/*pwcon,*/
scheduleid,
hhchange,
newhhid,
idenconf,
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
id,   
duplicate,
'wef' as wef_src 
from [mindr-live].dbo.all_wef wm
join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,wm.wedate,121)
where duplicate is null
union 

select 
uid,
tlpin,
sector,
hhid,
womname,
husbname,
jw.jivitaweek as wewkint,
convert(smalldatetime,wedate,121) as wedate,
workerid,
westatus,
wef_consent,
wef_fconsent,
wef_dconsent,
weagen,
wemarrlhus,
wecurpreg,
welmpddc,
welmpmm,
welmpyy,
welmpdd,
welmp,
case when cast(welmpyy as varchar(4)) not like '20%' or welmpdd ='66'  then null 
else convert(smalldatetime , cast(welmpyy as varchar(4)) 
+'-'+ case when welmpmm = '99' then '06'
when welmpmm='02' and welmpdd in ('29','30') and welmpyy='2023' then '03' else welmpmm end 
+'-'+ case when welmpdd = '99' then '15'
when welmpmm='02' and welmpdd in ('29') and welmpyy='2023' then '01'
when welmpmm='02' and welmpdd in ('30') and welmpyy='2023' then '02' else welmpdd end)
end  as welmpdate,
welmp3m,
lmp_display,
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
/*--not in table pw,*/
/*--not in table wra,*/
surt,
surtc,
version,
today,
start,
[end],
subdd,
submm,
subyy,
/*pwcon,*/
scheduleid,
hhchange,
newhhid,
idenconf,
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
id,
duplicate,
'wef_mopup' as wef_src 
from [mindr-live].dbo.all_wef_mopup wm
join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,wm.wedate,121)
where duplicate is null


