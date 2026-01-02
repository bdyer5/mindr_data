 cd "./"
#delimit ;
clear;
/*wef*/
set more off;
set memory 700m;

capture log close;
log using "..\datasets\logs\sif.log", replace;
odbc load,exec("
select
s.uid,
s.tlpin,
s.sector,
s.hhid,
/*womname,*/
/*husbname,*/
idenconf,
sidate,
workerid,
sistatus,
sistmnt,
sisalttype,
sisaltstore,
sisaltstores,
silid,
siresult,
version,
today,
start,
[end],
update_time,
updateed_by,
insert_time,
inserted_by,
instance_id,
scheduleid,
id,
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
hhchange,
newhhid,
duplicate
FROM [mindr-live].dbo.sif_mv s 
left join [mindr-live].dbo.wtrak_wra w on w.uid = s.uid 
where w.uid is not null 

") dsn("rammps");

fixdate sidate;

#delimit cr


foreach v of varlist si* {
     if !inlist("`v'", "sidate","sisaltstores") {
	    replace `v' = "" if (`v' == "n/a" )
        destring `v', force replace
     }
}



save "..\datasets\stata\sif_wra.dta", replace
saveold "..\datasets\stata\sif_wra.dta", replace version(12)
log close
