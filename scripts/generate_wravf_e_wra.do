 cd "./"
#delimit ;
clear;
/*wravf_e_wra*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\wravf_e.log", replace;
odbc load,exec("
SELECT
*
FROM [mindr-live].dbo.wravf_e_mv
") dsn("rammps");

fixdate wvedate;

#delimit cr

save "..\datasets\stata\wravf_e_wra.dta", replace
saveold "..\datasets\stata\wravf_e_wra.dta",replace version(12) 

log close
