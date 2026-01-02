 cd "./"
#delimit ;
clear;
/*ibaf*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\ibaf.log", replace;
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
jw.JiVitaWeek AS pewkint ,
convert(smalldatetime,ibdate,121) as ibdate,
/*
womname,
husbname,
*/
IDENCONF,
workerid,
childuid,
childname,
childno,
ibsex,
ibrelat1,
ibstatus,
ibdob,
ibbtimehr,
ibbtimemn,
ibbtimeap,
ibdod,
ibdtimehr,
ibdtimemn,
ibdtimeap,
ibpart,
ibparts,
ibstuck,
ibneck,
ibbrth,
ibcry1,
ibcry1s,
ibcry2,
ibcry2s,
ibcry3,
ibcry3s,
ibbrthc,
iblimb,
ibblue,
ibblueh,
ibbluef,
ibbluel,
ibblueb,
ibbfed,
ibbfedw,
ibbfhr,
ibbfclst,
ibbfoth1,
ibbfoth1s,
ibatimehr,
ibatimemn,
ibatimeap,
ibweight,
ibmuac1,
ibmuac2,
ibmuac3,
ibcc1,
ibcc2,
ibcc3,
ibhc1,
ibhc2,
ibhc3,
ibheight1,
ibheight2,
ibheight3
FROM     [mindr-live].dbo.all_ibaf INNER JOIN
                  shapla.dbo.JiVitAWeek AS jw ON jw.RomanDate = CONVERT(smalldatetime, all_ibaf.ibdate, 121)
WHERE  (all_ibaf.duplicate IS NULL)
") dsn("rammps");

fixdate ibdate;

#delimit cr

save "..\datasets\stata\ibaf.dta", replace
saveold "..\datasets\stata\ibaf.dta",replace version(12) 

log close
