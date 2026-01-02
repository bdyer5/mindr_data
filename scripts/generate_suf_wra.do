 cd "./"
#delimit ;
clear;
/*wef*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\suf_wra.log", replace;
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
sudate,
suwkint,
workerid,
sustatus,
suvisit,
sudod,
suucol,
sufrsturin,
suebcu,
sutimebcu,
suudt,
suucoltm,
sumidu,
suubkcb,
suupudt,
susampt,
suuspcid,
/*st,*/
vt,
supt,
suussts,
workerid_urn,
suscol,
suins,
sucons,
suddef,
sutdef,
suddefc,
susbkcb,
sutdecc,
susspcid,
/*st1,*/
vts,
supts,
susssts,
workerid_stl,
version,
today,
start,
[end],
formorder,
scheduleid,
case when suucolres ='null' then null else suucolres end as suucolres ,
duplicate 
FROM [mindr-live].dbo.suf_wra_mv
") dsn("rammps");

fixdate sudate;

#delimit cr


save "..\datasets\stata\suf_wra.dta", replace
saveold "..\datasets\stata\suf_wra.dta", replace version(12)
log close
