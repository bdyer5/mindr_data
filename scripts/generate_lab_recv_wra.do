 cd "./"
#delimit ;
clear;
/*lab_recv_wra*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\lab_recv_wra.log", replace;
odbc load,exec("
SELECT
id,
insert_time,
inserted_by,
update_time,
updateed_by,
cremt_1st,
cremt_2nd,
hem_stata,
ltid,
sample_type,
specimenid,
specimen_stata,
specimen_volume,
study_type,
lr.uid,
visit_type
FROM [mindr-live].dbo.lab_recv lr 
inner join [mindr-live].dbo.wtrak_wra wta on wta.uid = lr.uid 
") dsn("rammps");


#delimit cr

save "..\datasets\stata\lab_recv_wra.dta", replace
saveold "..\datasets\stata\lab_recv_wra.dta",replace version(12)

log close
