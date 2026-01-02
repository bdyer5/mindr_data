 cd "./"
#delimit ;
clear;
/*lab_proc*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\lab_proc_wra.log", replace;
odbc load,exec("
SELECT
lp.id,
lp.insert_time,
lp.inserted_by,
lp.update_time,
lp.updateed_by,
lp.buffy_coat,
lp.hemt_stataa,
lp.hemt_statab,
lp.ltid,
lp.rbc_status,
lp.sample_type,
lp.aliquot_id,
lp.specimenid,
lp.spec_volume,
lp.study_type,
lp.urin_color,
lp.visit_type
FROM [mindr-live].dbo.lab_process lp
left join [mindr-live].dbo.lab_recv lr on lr.specimenid = lp.specimenid
inner join [mindr-live].dbo.wtrak_wra wta on wta.uid = lr.uid  
") dsn("rammps");



#delimit cr

save "..\datasets\stata\lab_proc_wra.dta", replace
saveold "..\datasets\stata\lab_proc_wra.dta",replace version(12)

log close
