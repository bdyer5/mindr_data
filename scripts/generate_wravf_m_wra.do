 cd "./"
#delimit ;
clear;
/*wravf_m_wra*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\wravf_m_wra.log", replace;
odbc load,exec("
SELECT
*
FROM [mindr-live].dbo.wravf_m_mv
") dsn("rammps");

fixdate wvmdate;

#delimit cr

save "..\datasets\stata\wravf_m_wra.dta", replace
saveold "..\datasets\stata\wravf_m_wra.dta",replace version(12) 

log close
