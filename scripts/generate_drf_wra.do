 cd "./"
#delimit ;
clear;
/*drf*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\drf.log", replace;
odbc load,exec("
select 
d.uid,
case when p.allocated_arm = 'A' then 'Y'
when p.allocated_arm = 'B' then 'W'
when p.allocated_arm = 'C' then 'Z'
when p.allocated_arm = 'D' then 'X' end as 
arm,
d.tlpin,
d.sector,
d.hhid,
convert(smalldatetime,drdate,121) as wmdate,
workerid,
drstatus,

drvstype,
drsick,
drappt,
drfast,
drfest,
convert(smalldatetime,drydate,121) as drydate,
dryday,
drtabtyp,
drfoodgrp,
dritemcode,
drunkfoods,
drfoodt,
drfoodti,
drfoodw,
drfoodwr,
drmixveg,
drfoodscan,
drfoodcons,
drfoodconss,
drtabn
from [mindr_live_drf].dbo.wra_drf d
left join [mindr_live_drf].dbo.woman_wra p on p.uid = d.uid
") dsn("rammps");

fixdate wmdate drydate;

#delimit cr



foreach v of varlist dr* {
     if !inlist("`v'", "drdate","drydate","drtabn","drvstype","dryday","drunkfoods","drmixveg","drfoodconss") {
	    replace `v' = "" if (`v' == "n/a" )
        destring `v', force replace
     }
}


* Trim spaces
replace drunkfoods = strtrim(itrim(drunkfoods))

* 2. Create a helper variable with string lengths
gen _len = length(drunkfoods)

* 3. Get the maximum length
summarize _len
local maxlen = r(max)

* 4. Resize the variable
recast str`maxlen' drunkfoods

* 5. Clean up helper
drop _len





replace drvstype = strtrim(drvstype)
replace drvstype = lower(drvstype)
gen drvstype_num = .
replace drvstype_num = 1 if inlist(drvstype, "baseline_visit")
replace drvstype_num = 2 if inlist(drvstype, "replicate_visit")
replace drvstype_num = 3 if inlist(drvstype, "endline_visit")
drop drvstype
order drvstype_num, after(drstatus)
rename drvstype_num drvstype


replace dryday = strtrim(dryday)
replace dryday = lower(dryday)
gen dryday_num = .
replace dryday_num = 1 if inlist(dryday,"sunday")
replace dryday_num = 2 if inlist(dryday,"monday")
replace dryday_num = 3 if inlist(dryday,"tuesday")
replace dryday_num = 4 if inlist(dryday,"wednesday")
replace dryday_num = 5 if inlist(dryday,"thursday")
replace dryday_num = 6 if inlist(dryday,"friday")
replace dryday_num = 7 if inlist(dryday,"saturday")
drop dryday
order dryday_num, after(drydate)
rename dryday_num dryday

* 0. Normalize: trim, collapse internal spaces, and lowercase
replace drmixveg = strtrim(itrim(lower(drmixveg)))

* 1. Treat empty / n/a as missing string
replace drmixveg = "" if inlist(drmixveg, "", "n/a", "na", "n.a.")

* 2. Ensure target vars exist and are cleared (use wider width first, recast later)
forvalues i = 1/6 {
    capture confirm var drmixveg_`i'
    if _rc gen str10 drmixveg_`i' = ""
    else    replace   drmixveg_`i' = ""
}

* 3. Split non-missing rows into up to 6 tokens (space-delimited)
split drmixveg if drmixveg != "", parse(" ") gen(_tmp_) limit(6)

* 4. Move tokens into final vars, keep only two-digit numeric codes; else set missing
forvalues i = 1/6 {
    replace drmixveg_`i' = _tmp_`i'
    replace drmixveg_`i' = "" if !regexm(drmixveg_`i', "^[0-9][0-9]$")
}

* 5. Recast to exact width 2 (now that values are validated)
forvalues i = 1/6 {
    recast str2 drmixveg_`i'
}

* 6. Clean up
drop _tmp_*

order  drmixveg_1 drmixveg_2 drmixveg_3 drmixveg_4 drmixveg_5 drmixveg_6, after(drmixveg)

drop drmixveg

save "..\datasets\stata\drf_wra.dta", replace
saveold "..\datasets\stata\drf_wra.dta",replace version(12)

log close
