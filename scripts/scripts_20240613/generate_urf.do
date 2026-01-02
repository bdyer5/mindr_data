 cd "./"
#delimit ;
clear;
/*urf*/
set more off;
/*set memory 700m;   */

capture log close;
log using "..\datasets\logs\urf.log", replace;
odbc load,exec("
SELECT
UID,
VERSION,
today,
start,
scheduleID,
tlpin,
Sector,
HHID,
HHCHANGE,
NEWHHID,
jw.JiVitaWeek AS urwkint ,
convert(smalldatetime,urdate,121) as urdate,
/*
womname,
husbname,
*/
IDENCONF,
workerid,
urstatus,
urdoc,
urdod,
urabnormc,
urabnormi,
urdiagnosis,
urresp,
urrefs
FROM     [mindr-live].dbo.all_urf INNER JOIN
                  shapla.dbo.JiVitAWeek AS jw ON jw.RomanDate = CONVERT(smalldatetime, all_urf.urdate, 121)
WHERE  (all_urf.duplicate IS NULL)

") dsn("rammps");

fixdate urdate;

#delimit cr

save "..\datasets\stata\urf.dta", replace
saveold "..\datasets\stata\urf.dta",replace version(12) /*restored 2024.06.10 */

log close
