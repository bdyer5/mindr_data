 cd "./"
#delimit ;
clear;
/*fbaf*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\fbaf.log", replace;
odbc load,exec("
SELECT
[UID],
[VERSION],
[today],
[start],
scheduleId,
tlpin,
Sector,
HHID,
HHCHANGE,
NEWHHID,
jw.JiVitaWeek AS pewkint ,
convert(smalldatetime,fbdate,121) as fbdate,
/*
womname,
husbname,
*/
IDENCONF,
workerid,
childuid,
childname,
childno,
fbsex,
fbrelat1,
fbstatus,
fbdob,
fbbtimehr,
fbbtimemn,
fbbtimeap,
fbdod,
fbdtimehr,
fbdtimemn,
fbdtimeap,
fbatimehr,
fbatimemn,
fbatimeap,
fbweight,
fbmuac1,
fbmuac2,
fbmuac3,
fbcc1,
fbcc2,
fbcc3,
fbhc1,
fbhc2,
fbhc3,
fbheight1,
fbheight2,
fbheight3
FROM     [mindr-live].dbo.all_fbaf INNER JOIN
                  shapla.dbo.JiVitAWeek AS jw ON jw.RomanDate = CONVERT(smalldatetime, all_fbaf.fbdate, 121)
WHERE  (all_fbaf.duplicate IS NULL)
") dsn("rammps");

fixdate fbdate;

#delimit cr

save "..\datasets\stata\fbaf.dta", replace
saveold "..\datasets\stata\fbaf.dta",replace version(12)  

log close
