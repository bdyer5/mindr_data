 cd "./"
#delimit ;
clear;
/*px_wra*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\px_wra.log", replace;
odbc load,exec("

select
px.[uid],
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
from [mindr-live].dbo.px_data px 
inner join [mindr-live].dbo.wtrak_wra wtw on wtw.uid = px.uid 
") dsn("rammps");

fixdate px_date;

#delimit cr

save "..\datasets\stata\px_wra.dta", replace
saveold "..\datasets\stata\px_wra.dta",replace version(12)  

log close
