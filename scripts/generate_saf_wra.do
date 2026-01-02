 cd "./"
#delimit ;
clear;
/*wef*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\saf_wra.log", replace;
odbc load,exec("
select 
uid,
tlpin,
sector,
hhid,
sadate,
workerid,
sastatus,
sadoc,
sadaydrink,
sadawtwat,
sadawtwatc,
sadawata,
sadafdrink,
sadafdrinkwt,
sadawtjpp,
sadajppb,
sadamett,
sadawhr,
sadafmv,
sadasmv,
sadpydrink,
sadpwtwat,
sadpwata,
sadpfdrink,
sadpyjpp,
sadpmett,
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
sawkint,
sadod,
sadawatatc,
duplicate
FROM [mindr-live].dbo.saf_wra_mv 
") dsn("rammps");

fixdate sadate;

#delimit cr


save "..\datasets\stata\saf_wra.dta", replace
saveold "..\datasets\stata\saf_wra.dta", replace version(12)
log close
