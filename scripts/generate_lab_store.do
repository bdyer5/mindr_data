 cd "./"
#delimit ;
clear;
/*lab_store*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\lab_store.log", replace;
odbc load,exec("
SELECT
id,
insert_time,
inserted_by,
update_time,
updateed_by,
aliquot_id,
box_id,
cell_number,
ltid,
sample_type,
specimenid,
study_type,
visit_type
FROM [mindr-live].dbo.lab_store
") dsn("rammps");



#delimit cr

save "..\datasets\stata\lab_store.dta", replace
saveold "..\datasets\stata\lab_store.dta",replace version(12)

log close
