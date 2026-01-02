 cd "./"
#delimit ;
clear;
/*pefb_pw*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\pefb_pw.log", replace;
odbc load,exec("
select 
uid,
tlpin,
sector,
hhid,
/*hhchange,*/
/*newhhid,*/
pebwkint,
pebdate,
/*
womname,
husbname,
*/
idenconf,
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
workerid_bl,
version,
today,
start,
[end],
scheduleid
FROM [mindr-live].dbo.pefb_mv") dsn("rammps");

fixdate pebdate pebdoc pebdod;


destring pebweight, force replace;
destring pebmuac1, force replace;
destring pebmuac2, force replace;
destring pebmuac3, force replace;
destring pebheight1, force replace;
destring pebheight2, force replace;
destring pebheight3, force replace;

save "..\datasets\stata\pefb_pw.dta", replace ;


#delimit cr

foreach v of varlist pebmuac* {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}

save "..\datasets\stata\pefb_pw.dta", replace

gen byte n_missing = (missing(pebmuac1))+(missing(pebmuac2))+(missing(pebmuac3))
gen medpebmuac = pebmuac1+pebmuac2+pebmuac3-min(pebmuac1, pebmuac2, pebmuac3)-max(pebmuac1, pebmuac2, pebmuac3) if n_missing==0
replace medpebmuac = (min(pebmuac1, pebmuac2, pebmuac3)+max(pebmuac1, pebmuac2, pebmuac3))/2 if n_missing==1
replace medpebmuac = max(pebmuac1, pebmuac2, pebmuac3) if n_missing==2
drop n_missing

save "..\datasets\stata\pefb_pw.dta", replace

foreach v of varlist pebheight* {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}

gen byte n_missing = (missing(pebheight1))+(missing(pebheight2))+(missing(pebheight3))
gen medpebheight = pebheight1+pebheight2+pebheight3-min(pebheight1, pebheight2, pebheight3)-max(pebheight1, pebheight2, pebheight3) if n_missing==0
replace medpebheight = (min(pebheight1, pebheight2, pebheight3)+max(pebheight1, pebheight2, pebheight3))/2 if n_missing==1
replace medpebheight = max(pebheight1, pebheight2, pebheight3) if n_missing==2
drop n_missing


foreach v of varlist pebweight {
	replace `v' = . if (`v' == 00.0 | `v' == 99.9)
}



save "..\datasets\stata\pefb_pw.dta", replace
saveold "..\datasets\stata\pefb_pw.dta",replace version(12) /* restored 2024.06.10   removed 2024.05.14  */

log close
