 cd "./"
#delimit ;
clear;
/*wef*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\wmf_pw.log", replace;
odbc load,exec("
select 
uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
/*womname,*/
/*husbname,*/
idenconf,
wmdate,
workerid,
wmstatus,
wmdoc,
wmdod,
wmnsvmt7,
wmdiar7,
wmtoes7,
wmrash7,
wmhair7,
wmweak7,
wmhach7,
wmvision7,
wmbleed7,
wmdys7,
wmbruis7,
wmodor7,
/*serfgen,*/
version,
today,
start,
[end],
formorder,
scheduleid

from [mindr-live].dbo.wmfpw_mv


") dsn("rammps");

fixdate wmdate;

#delimit cr


save "..\datasets\stata\wmf_pw.dta", replace
saveold "..\datasets\stata\wmf_pw.dta", replace version(12)
log close
