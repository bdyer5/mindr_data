 cd "./"
#delimit ;
clear;
/*eser_wra*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\eser_wra.log", replace;
odbc load,exec("select 
d.uid,
case when p.allocated_arm = 'A' then 'Y'
when p.allocated_arm = 'B' then 'W'
when p.allocated_arm = 'C' then 'Z'
when p.allocated_arm = 'D' then 'X' end as 
arm,
d.tlpin,
d.sector,
d.hhid,
womname,
husbname,
eserdate,
workerid,
rpasnt,
rpdesc,
version,
today,
start,
[end],
hhchange,
newhhid,
idenconf,
pebheighta,
scheduleid,
hours_of_fasting,
alt,
ast,
creatinine,
blood_urea_nitrogen,
total_carbon_dioxide,
calcium,
sodium,
potassium,
chloride,
glucose,
glu,
chol,
hdl,
trig,
ldl,
vldl,
bmp_hemolysis,
bmp_lipemia,
bmp_icterus,
lp_hemolysis,
lp_lipemia,
lp_icterus,
bmi,
biomerker_name_bp,
biomerker_name_hb,
biomerker_name_alt,
biomerker_name_ast,
biomerker_name_calcium,
biomerker_name_sodium,
biomerker_name_potassium,
biomerker_name_creatinine,
biomerker_name_bun,
biomerker_name_total_co2,
specimentid,
_date_modified,
_duration,
_id,
_media_all_received,
_media_count,
/*_notes,*/
_submission_time,
_submitted_by,
/*_tags,*/
_total_media,
_uuid,
_version,
_xform_id,
biomerker_name_rbs,
duplicate,
id,
d.insert_time,
d.inserted_by,
d.instance_id,
d.update_time,
d.updateed_by,
webdiast1,
webdiast2,
webfood,
webfoodc,
webheight1,
webheight2,
webheight3,
webhemo,
websysto1,
websysto2,
webweight,
wvappt7,
wvbrth7,
wvcgh7,
wvconv7,
wvdiar7,
wvdys7,
wvhach7,
wvhfvr7,
wvlabd7,
wvlfvr7,
wvnaus7,
wvspot7,
wvswlf7,
wvswlh7,
wvurin7,
wvvagd7,
wvvbld7,
wvvmt7,
wvwdys7,
wvxn7
from [mindr-live].dbo.eser_wra_mv d
left join [mindr-live].dbo.woman_wra p on p.uid = d.uid
") dsn("rammps");

fixdate eserdate ;

#delimit cr

//Calculate the number of splits needed
local max_length_an = 242
local num_splits_an = ceil(strlen(rpasnt) / `max_length_an')+1

//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen rpasnt`i' = substr(rpasnt, (`i' - 1) * `max_length_an' + 1, `max_length_an')
    order rpasnt`i', before(rpasnt)
}


drop rpasnt





save "..\datasets\stata\eser_wra.dta", replace
saveold "..\datasets\stata\eser_wra.dta",replace version(12)  

log close
