 cd "./"
#delimit ;
clear;
/*lab_store_wra*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\lab_store_wra.log", replace;
odbc load,exec("
SELECT
ls.id,
ls.insert_time,
ls.inserted_by,
ls.update_time,
ls.updateed_by,
aliquot_id,
box_id,
cell_number,
ls.ltid,
ls.sample_type,
ls.specimenid,
ls.study_type,
ls.visit_type
FROM [mindr-live].dbo.lab_store ls 
left join [mindr-live].dbo.lab_recv lr on lr.specimenid = ls.specimenid
inner join [mindr-live].dbo.wtrak_wra wta on wta.uid = lr.uid 
") dsn("rammps");



#delimit cr

save "..\datasets\stata\lab_store_wra.dta", replace
saveold "..\datasets\stata\lab_store_wra.dta",replace version(12)

log close
