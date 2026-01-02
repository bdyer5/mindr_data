 cd "./"
#delimit ;
clear;
/*wravf_f_wra*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\wravf_f.log", replace;
odbc load,exec("
SELECT
*
FROM [mindr-live].dbo.wravf_f_mv
") dsn("rammps");

fixdate wvfdate;

#delimit cr

save "..\datasets\stata\wravf_f_wra.dta", replace
saveold "..\datasets\stata\wravf_f_wra.dta",replace version(12) 

log close
