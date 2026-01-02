 cd "./"
#delimit ;
clear;
/*bnf*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\bnf.log", replace;
odbc load,exec("
SELECT
[UID],
[VERSION],
[today],
[start],
[end],
scheduleID ,
SUBmm,
SUByy,
todaymmyy,
tlpin,
Sector,
HHID,
HHCHANGE,
NEWHHID,
jw.JiVitaWeek AS pewkint ,
convert(smalldatetime,bnfdate,121) as bnfdate,
/*
womname,
husbname,
*/
IDENCONF,
workerid,
BNFTYPE,
BNFNB,
BNFCHLDVITSTS1,
BNFCHLDVITSTS2,
BNFCHLDVITSTS3,
BNFDTOO,
BNFCLOC,
BNFRELADDR,
BNFRELHMEA,
BNFNFAC,
BNFNFACA,
BNFWOMCALL,
BNFWOMMOB,
BNFWOMMOB_2

FROM     [mindr-live].dbo.all_bnf INNER JOIN
                  shapla.dbo.JiVitAWeek AS jw ON jw.RomanDate = CONVERT(smalldatetime, all_bnf.bnfdate, 121)
WHERE  (all_bnf.duplicate IS NULL)
") dsn("rammps");

fixdate bnfdate;

#delimit cr

save "..\datasets\stata\bnf.dta", replace
saveold "..\datasets\stata\bnf.dta",replace version(12)

log close
