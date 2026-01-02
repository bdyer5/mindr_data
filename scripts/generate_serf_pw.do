 cd "./"
#delimit ;
clear;
/*wef*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\serf_pw.log", replace;
odbc load,exec("

select 

uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
idenconf,
jw.jivitaweek as srwkint,
convert(smalldatetime, srdate,121) as srdate,
workerid,
srstatus,
srdod,
/*Section 1*/
srrp_wmf,
srrp_bp,
srrp_hemo,
aslt1,
aslt2,
srrp_px,
srrpdec,
/*Section C*/
srtmpstp,
version,
today,
start,
[end]
from [mindr-live].dbo.all_serf_pw sp
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,sp.srdate,121) 
where duplicate is null 
") dsn("rammps");

fixdate srdate;

#delimit cr



//Calculate the number of splits needed
local max_length_an = 242
local num_splits_an = ceil(strlen(srrp_wmf) / `max_length_an')+1

//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen srrp_wmf`i' = substr(srrp_wmf, (`i' - 1) * `max_length_an' + 1, `max_length_an')
}


drop srrp_wmf

//recast str244 aeflist, force


//Calculate the number of splits needed
local max_length_an = 242
local num_splits_an = ceil(strlen(srrp_bp) / `max_length_an')+1

//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen srrp_bp`i' = substr(srrp_bp, (`i' - 1) * `max_length_an' + 1, `max_length_an')
}


drop srrp_bp



//Calculate the number of splits needed
local max_length_an = 242
local num_splits_an = ceil(strlen(srrp_hemo) / `max_length_an')+1

//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen srrp_hemo`i' = substr(srrp_hemo, (`i' - 1) * `max_length_an' + 1, `max_length_an')
}


drop srrp_hemo



//Calculate the number of splits needed
local max_length_an = 242
local num_splits_an = ceil(strlen(srrp_px) / `max_length_an')+1

//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen srrp_px`i' = substr(srrp_px, (`i' - 1) * `max_length_an' + 1, `max_length_an')
}


drop srrp_px




save "..\datasets\stata\serf_pw.dta", replace
saveold "..\datasets\stata\serf_pw.dta", replace version(12)
log close
