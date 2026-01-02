 cd "./"
#delimit ;
clear;
/*wef*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\wmf_wra.log", replace;
odbc load,exec("
select 
uid,
tlpin,
sector,
hhid,
/*hhchange,*/
/*newhhid,*/
/*womname,*/
/*husbname,*/
/*idenconf,*/
convert(smalldatetime,wmdate,121) as wmdate,
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
today,
start,
[end],
formorder,
scheduleid

from [mindr-live].dbo.wmfwra_mv


") dsn("rammps");

fixdate wmdate ;

#delimit cr


save "..\datasets\stata\wmf_wra.dta", replace
saveold "..\datasets\stata\wmf_wra.dta", replace version(12)
log close
