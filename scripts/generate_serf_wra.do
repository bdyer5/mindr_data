 cd "./"
#delimit ;
clear;
/*wef*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\serf_wra.log", replace;
odbc load,exec("

select 
uid,
tlpin,
sector,
hhid,
womname,
husbname,
srdate,
workerid,
srstatus,
srdod,
srrp_wmf,
srrp_px,
srrp_hemo,
srrp_bp,
srsuprel,
srrpdcsn,
sr14fudate,
sr14fusts,
sr14fudod,
sr14fusymdesc,
srsuprel14,
sr14furpassmnt,
sr14supdes,
srhvdate,
srhvstatus,
srdod2,
srsymdes,
srassev,
srsuprelhv,
srrpass,
version,
today,
start,
[end],
wmvmt7_1,
wmdiar7_1,
wmtoes7_1,
wmrash7_1,
wmhair7_1,
wmweak7_1,
wmhach7_1,
wmvision7_1,
wmbleed7_1,
wmdys7_1,
wmbruis7_1,
wmodor7_1,
bpformname1,
diastolic1,
systolic1,
glucose1,
alt1,
ast1,
calcium1,
sodium1,
potassium1,
creatinine1,
blood_urea_nitrogen1,
total_carbon_dioxide1,
wmvmt7_2,
wmdiar7_2,
wmtoes7_2,
wmrash7_2,
wmhair7_2,
wmweak7_2,
wmhach7_2,
wmvision7_2,
wmbleed7_2,
wmdys7_2,
wmbruis7_2,
wmodor7_2,
bpformname2,
diastolic2,
systolic2,
glucose2,
alt2,
ast2,
calcium2,
sodium2,
potassium2,
creatinine2,
blood_urea_nitrogen2,
total_carbon_dioxide2,
wmf1date,
wmf2date,
bpdate1,
bpdate2,
pxdate1,
pxdate2,
hemo1,
hemo2,
hemodate1,
hemodate2,
wmvmt7_3,
wmdiar7_3,
wmtoes7_3,
wmrash7_3,
wmhair7_3,
wmweak7_3,
wmhach7_3,
wmvision7_3,
wmbleed7_3,
wmdys7_3,
wmbruis7_3,
wmodor7_3,
bpformname3,
diastolic3,
systolic3,
glucose3,
alt3,
ast3,
calcium3,
sodium3,
potassium3,
creatinine3,
blood_urea_nitrogen3,
total_carbon_dioxide3,
wmvmt7_4,
wmdiar7_4,
wmtoes7_4,
wmrash7_4,
wmhair7_4,
wmweak7_4,
wmhach7_4,
wmvision7_4,
wmbleed7_4,
wmdys7_4,
wmbruis7_4,
wmodor7_4,
bpformname4,
diastolic4,
systolic4,
glucose4,
alt4,
ast4,
calcium4,
sodium4,
potassium4,
creatinine4,
blood_urea_nitrogen4,
total_carbon_dioxide4,
wmf3date,
wmf4date,
bpdate3,
bpdate4,
pxdate3,
pxdate4,
hemo3,
hemo4,
hemodate3,
hemodate4,
srh7assmnt1,
diastolic12,
systolic12,
diastolic22,
systolic22,
diastolic32,
systolic32,
diastolic42,
systolic42,
scheduleid,
formorder,
hhchange,
newhhid,
idenconf,
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
duplicate,
id,
insert_time,
inserted_by,
instance_id,
update_time,
updateed_by,
serf_src
from [mindr-live].dbo.serf_wra_mv_combined sp

") dsn("rammps");

fixdate srdate;

#delimit cr



//Calculate the number of splits needed
local max_length_an = 242
local num_splits_an = ceil(strlen(srrp_wmf) / `max_length_an')+1

//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen srrp_wmf`i' = substr(srrp_wmf, (`i' - 1) * `max_length_an' + 1, `max_length_an')
}


drop srrp_wmf

//recast str244 aeflist, force


//Calculate the number of splits needed
local max_length_an = 242
local num_splits_an = ceil(strlen(srrp_bp) / `max_length_an')+1

//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen srrp_bp`i' = substr(srrp_bp, (`i' - 1) * `max_length_an' + 1, `max_length_an')
}


drop srrp_bp



//Calculate the number of splits needed
local max_length_an = 242
local num_splits_an = ceil(strlen(srrp_hemo) / `max_length_an')+1

//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen srrp_hemo`i' = substr(srrp_hemo, (`i' - 1) * `max_length_an' + 1, `max_length_an')
}


drop srrp_hemo




//Calculate the number of splits needed
local max_length_an = 242
egen max_str_len = max(strlen(srsymdes))
local num_splits_an = ceil(max_str_len[1]/ `max_length_an')

drop max_str_len


//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen srsymdes`i' = substr(srsymdes, (`i' - 1) * `max_length_an' + 1, `max_length_an')
    order srsymdes`i', before(srsymdes)
}

drop srsymdes


//Calculate the number of splits needed
local max_length_an = 242
egen max_str_len = max(strlen(sr14fusymdesc))
local num_splits_an = ceil(max_str_len[1]/ `max_length_an')

drop max_str_len


//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen sr14fusymdesc`i' = substr(sr14fusymdesc, (`i' - 1) * `max_length_an' + 1, `max_length_an')
    order sr14fusymdesc`i', before(sr14fusymdesc)
}

drop sr14fusymdesc



//Calculate the number of splits needed
local max_length_an = 242
local num_splits_an = ceil(strlen(srrp_px) / `max_length_an')+1

//Create new variables to hold the splits
forval i = 1/`num_splits_an' {
    gen srrp_px`i' = substr(srrp_px, (`i' - 1) * `max_length_an' + 1, `max_length_an')
}


drop srrp_px




save "..\datasets\stata\serf_wra.dta", replace
saveold "..\datasets\stata\serf_wra.dta", replace version(12)
log close
