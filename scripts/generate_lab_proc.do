 cd "./"
#delimit ;
clear;
/*lab_proc*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\lab_proc.log", replace;
odbc load,exec("
SELECT
id,
insert_time,
inserted_by,
update_time,
updateed_by,
buffy_coat,
hemt_stataa,
hemt_statab,
ltid,
rbc_status,
sample_type,
aliquot_id,
specimenid,
spec_volume,
study_type,
urin_color,
visit_type
FROM [mindr-live].dbo.lab_process
") dsn("rammps");



#delimit cr

save "..\datasets\stata\lab_proc.dta", replace
saveold "..\datasets\stata\lab_proc.dta",replace version(12)

log close
