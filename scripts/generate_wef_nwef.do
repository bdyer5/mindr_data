 cd "./"
#delimit ;
clear;
/*wef_nwef_all*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\wef_nwef_all.log", replace;
odbc load,exec("
SELECT
uid,
/*pwuid,*/
tlpin,
sector,
hhid,
/*wewkint,*/
wedate,
workerid,
westatus,
wef_consent,
wef_fconsent,
wef_dconsent,
nwejivita,
nwejivitamc,
nwejivitacap,
nwejivitakcap,
nwejivitamob,
nwehhmerr,
/*wsts1,*/
nwewsts,
/*wsts,*/
/*nwedobdd,*/
/*nwedobmm,*/
/*nwedobyy,*/
nwedobdate as nwedob,
/*nwedobmmc,*/
/*nwedobddc,*/
/*agecal1,*/
/*agemm,*/
/*agedd,*/
/*agecal,*/
/*weagen,*/
wemarrlhus,
nwemarrydate,
nwehusage,
wecurpreg,
/*welmpddc,*/
/*welmpmm,*/
/*welmpyy,*/
/*welmpdd,*/
/*welmp,*/
welmpdate as welmp,
welmp3m,
/*lmp_display,*/
/*lmp_displayt,*/
/*lmp_displayt1,*/
weurt,
weinft,
wecurbfd,
wewant6m,
wefpm,
wefpt,
wef_pw_consent,
welrins,
weownmob,
wemobno,
wecont,
wecontno,
wecontown,
weothmarr,
wenomarr,
/*surt,*/
/*surtc,*/
version,
today,
start,
[end],
/*subdd,*/
/*submm,*/
/*subyy,*/
scheduleid,
/*hhchange,*/
/*newhhid,*/
/*idenconf,*/
/*pwcon,*/
/*insert_time,*/
/*update_time,*/
/*_submission_time,*/
/*_submitted_by,*/
/*_date_modified,*/
/*_xform_id,*/
instanceid,
/*_duration,*/
/*_media_all_received,*/
/*_media_count,*/
_id,
/*_uuid,*/
/*_version,*/
/*_total_media,*/
/*duplicate,*/
wef_src
FROM [mindr-live].dbo.wef_nwef_mv_prep


") dsn("rammps");

fixdate wedate nwedob;

#delimit cr

save "..\datasets\stata\wef_nwef_all.dta", replace
saveold "..\datasets\stata\wef_nwef_all.dta",replace version(12)

log close
