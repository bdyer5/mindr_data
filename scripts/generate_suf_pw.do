 cd "./"
#delimit ;
clear;
/*wef*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\suf_pw.log", replace;
odbc load,exec("
select
uid,
tlpin,
sector,
hhid,
/*womname,*/
/*husbname,*/
sudate,
workerid,
sustatus,
suvisit,
sudod,
suucol,
sufrsturin,
suebcu,
sutimebcu,
suudt,
suucoltm,
sumidu,
suubkcb,
suupudt,
susampt,
suuspcid,
suussts,
workerid_urn,
suscol,
suins,
sucons,
suddef,
sutdef,
suddefc,
susbkcb,
sutdecc,
susspcid,
susssts,
workerid_stl,
version,
today,
start,
[end],
scheduleid,
formorder,
suucolres,
suscolres,
vt,
supt,
vts,
supts,
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
hhchange,
newhhid,
idenconf,
update_time,
updateed_by
FROM [mindr-live].dbo.suf_pw_mv
") dsn("rammps");

fixdate sudate suudt suupudt suddef susbkcb;

#delimit cr


save "..\datasets\stata\suf_pw.dta", replace
saveold "..\datasets\stata\suf_pw.dta", replace version(12)
log close
