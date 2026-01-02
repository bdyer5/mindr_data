 cd "./"
#delimit ;
clear;
/*pefb*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\pefb.log", replace;
odbc load,exec("
SELECT 
[UID],
[VERSION],
[today],
[start],
[end],
scheduleId,
tlpin,
Sector,
HHID,
HHCHANGE,
NEWHHID,
jw.JiVitaWeek AS pebwkint ,
convert(smalldatetime,pebdate,121) as pebdate,
/*
womname,
husbname,
*/
IDENCONF,
workerid,
pebstatus,
pebdoc,
pebdod,
pebtemp,
pebtempn1,
pebsysto1,
pebdiast1,
pebbptime1,
workerid_bp,
pebweight,
pebheight1,
pebheight2,
pebheight3,
pebmuac1,
pebmuac2,
pebmuac3,
pebsysto2,
pebdiast2,
pebbptime2,
/*
pebbptime2n,
*/
workerid_an,
pebmealdate,
pebmealtime,
pebmealtimec,
pebfood,
pebblood1,
pebblood2,
pebspecid1,
st,
vt,
supt,
pebspecid2,
st1,
vt1,
supt1,
pebbldtime,
pebhemo,
pebfetab,
pebbltype,
pebrhtype,
workerid_bl
FROM [mindr-live].dbo.all_pefb INNER JOIN
                  shapla.dbo.JiVitAWeek AS jw ON jw.RomanDate = CONVERT(smalldatetime, all_pefb.pebdate, 121)
WHERE  (all_pefb.duplicate IS NULL)
") dsn("rammps");

fixdate pebdate;

#delimit cr

save "..\datasets\stata\pefb.dta", replace
saveold "..\datasets\stata\pefb.dta",replace version(12) /* restored 2024.06.10   removed 2024.05.14  */

log close
