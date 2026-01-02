 cd "./"
#delimit ;
clear;
/*px_data*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\px_data.log", replace;
odbc load,exec("
select
[uid],
convert(smalldatetime,[date],121) as px_date,
jivitaweek,
specimentid,
glucose,
blood_urea_nitrogen,
calcium,
creatinine,
sodium,
potassium,
chloride,
total_carbon_dioxide,
bmp_hemolysis,
bmp_icterus,
bmp_lipemia_,
chol,
hdl,
trig,
alt,
ast,
/*[ast/alt],*/
glu,
nhdlc,
tc_h,
ldl,
vldl,
lp_hemolysis,
lp_icterus,
lp_lipemia_,
visit_type,
trial
from [mindr-live].dbo.px_data
") dsn("rammps");

fixdate px_date;

#delimit cr

save "..\datasets\stata\px_data.dta", replace
saveold "..\datasets\stata\px_data.dta",replace version(12)  

log close
