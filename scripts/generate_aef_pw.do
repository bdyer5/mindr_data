 cd "./"
#delimit ;
clear;
/*aef_pw*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\aef_pw.log", replace;
odbc load,exec("
SELECT
uid,
tlpin,
sector,
hhid,
womname,
husbname,
aefdate,
workerid,
aeperson,
childuid,
childname,
aestatus,
aeevent,
aediag,
aeondate,
aedescpt,
aefevntsum,
aelocate,
aeunexp,
aerel,
aeurel,
aedisc,
aehoscause,
aeact,
aeacts,
aelist,
version,
today,
start,
[end],
hhchange,
newhhid,
idenconf,
insert_time,
update_time,
_submission_time,
_date_modified,
scheduleid,
instanceid,
_id,
_uuid
/*duplicate*/
FROM     [mindr-live].dbo.aef_pw_mv
") dsn("rammps");

fixdate aefdate aeondate;

#delimit cr

//Calculate the number of splits needed
local max_length_an = 242
egen max_str_len = max(strlen(aedescpt))
local num_splits_an = ceil(max_str_len[1]/ `max_length_an')

drop max_str_len

//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen aedescpt`i' = substr(aedescpt, (`i' - 1) * `max_length_an' + 1, `max_length_an')
    order aedescpt`i', before(aedescpt)
}


drop aedescpt

//Calculate the number of splits needed
local max_length_an = 242
egen max_str_len = max(strlen(aefevntsum))
local num_splits_an = ceil(max_str_len[1]/ `max_length_an')

drop max_str_len


//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen aefevntsum`i' = substr(aefevntsum, (`i' - 1) * `max_length_an' + 1, `max_length_an')
    order aefevntsum`i', before(aefevntsum)
}

drop aefevntsum


save "..\datasets\stata\aef_pw.dta", replace
saveold "..\datasets\stata\aef_pw.dta",replace version(12) 

log close
