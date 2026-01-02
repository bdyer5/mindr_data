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
hhchange,
newhhid,
idenconf,
jw.JiVitaWeek AS sawkint,
convert(smalldatetime,sadate,121) as sadate,
workerid,
sastatus,
sadoc,
sadod,
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
sadafmv,
sadasmv,
sadpydrink,
sadpwtwat,
sadpfdrink,
sadpyjpp,
sadpmett,
version,
today,
start,
[end],
sadf1,
sadfp1,
formorder,
duplicate
FROM        [mindr-live].dbo.all_saf_wra LEFT OUTER JOIN
                  shapla.dbo.JiVitAWeek AS jw ON jw.RomanDate = CONVERT(smalldatetime, sadate, 121)
WHERE     (duplicate IS NULL)
") dsn("rammps");

fixdate sadate;

#delimit cr


save "..\datasets\stata\saf_wra.dta", replace
saveold "..\datasets\stata\saf_wra.dta", replace version(12)
log close
