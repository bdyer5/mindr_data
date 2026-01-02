use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='safpw_mv')
begin 
drop view safpw_mv
end 
go 

create view safpw_mv as 
select
uid,
tlpin,
sector,
hhid,
womname,
husbname,
jw.jivitaweek as sawkint,
convert(smalldatetime,sadate,121) as sadate,
workerid,
sastatus,
convert(smalldatetime,sadoc,121) as sadoc,
convert(smalldatetime,sadod,121) as sadod,
/*begin1*/
sadaydrink,
sadawtwat,
sadawtwatc,
sadawata,
sadawatatc,
sadafdrink,
sadafdrinkwt,
sadawtjpp,
sadajppb,
sadamett,
sadawhr,
/*saapttomb*/
sadafmv,
sadasmv,
/*secc*/
sadpydrink,
sadpwtwat,
sadpwata, -- was temporary commented out */ 
sadpfdrink,
sadpyjpp,
sadpmett,
/*begin1r*/
sawateradd,
safrotoadd,
sadaydrinkr,
samarkw,
samarkwvl,
samarkf,
samarkfvl,
sadawtjppr,
sadajppbr,
sadamettr,
sadawhrr,
/*saapttombr*/
sadafmvr,
sadasmvr,
version,
today,
start,
[end],
sadf1,
sadfp1,
formorder,
arm,
ramadan,
samarkw1,
samarkf1,
schedule_id as scheduleid,
hhchange,
newhhid,
idenconf,
insert_time,
update_time,
_submission_time,
_submitted_by,
_date_modified,
_xform_id,
instance_id as instanceid,
_duration,
_media_all_received,
_media_count,
_id,
_uuid,
_version,
_total_media,
id,   
duplicate
from [mindr-live].dbo.all_saf_pw s
left join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,s.sadate,121)
where duplicate is null 