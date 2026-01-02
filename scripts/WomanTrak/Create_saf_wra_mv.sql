use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='saf_wra_mv')
begin 
drop view saf_wra_mv 
end 
go 

create view saf_wra_mv 
as 

select
uid,
tlpin,
sector,
hhid,
jw.jivitaweek as sawkint,
convert(smalldatetime,sadate,121) as sadate,
workerid,
sastatus,
convert(smalldatetime,sadoc,121) as sadoc,
convert(smalldatetime,sadod,121) as sadod,
/*section begin1*/
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
/*section saapttomb*/
sadafmv,
sadasmv,
/*section secc*/
sadpydrink,
sadpwtwat,
sadpwata,
sadpfdrink,
sadpyjpp,
sadpmett,
/*section begin1r*/
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
/*section saapttombr*/
sadafmvr,
sadasmvr,
version,
today,
start,
[end],
sadf1,
sadfp1,
formorder,
_id,
_submission_time,
schedule_id,
duplicate
/*womname,*/
/*husbname,*/
/*idenconf*/

FROM [mindr-live].dbo.all_saf_wra LEFT OUTER JOIN
                  shapla.dbo.JiVitAWeek AS jw ON jw.RomanDate = CONVERT(smalldatetime, sadate, 121)
WHERE     (duplicate IS NULL)