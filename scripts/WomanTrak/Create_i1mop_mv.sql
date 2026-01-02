use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='i1mop_mv')
begin 
drop view i1mop_mv
end 
go 

create view i1mop_mv as 
select 
i1.uid,
i1.childuid,
tlpin,
sector,
hhid,
womname,
childname,
husbname,
jw.jivitaweek as i1wkint,
convert(smalldatetime,i1.i1date,121) as i1date,
workerid,
i1relat1,
i1status,
convert(smalldatetime,i1dod,121) as i1dod,
/*secb*/
i1pneum,
i1pneumt,
i1pneum7,
i1diar,
i1diart,
i1diar7,
i1dys,
i1dyst,
i1dys7,
i1hfvr,
i1hfvrt,
i1hfvr7,
/*secc*/
i1bfed,
i1bfedever,
i1sbfed,
i1sbfedd,
i1sbfedw,
i1bfhr,
i1bfclst,
i1bftime,
i1bfsuff,
/*secd*/
i1edrop,
i1edroph,
i1eamilk,
i1eamilkh,
i1eswater,
i1eswaterh,
i1ewater,
i1ewaterh,
i1eghee,
iegheeh,
i1ehoney,
i1ehoneyh,
i1epmilk,
i1epmilkh,
i1eformu,
i1eformuh,
i1eothf,
i1eothfs,
i1eothfh,
i1amilk,
i1amilkd,
i1amilkt,
i1pmilk,
i1pmilkd,
i1pmilkt,
i1omilk,
i1omilkd,
i1omilkt,
i1formu,
i1formud,
i1formut,
i1swater,
i1swaterd,
i1swatert,
i1water,
i1waterd,
i1watert,
i1honey,
i1honeyd,
i1honeyt,
i1othf,
i1othfs,
i1othfd,
i1othft,
/*sece*/
i1weight,
i1muac1,
i1muac2,
i1muac3,
i1cc1,
i1cc2,
i1cc3,
i1hc1,
i1hc2,
i1hc3,
i1height1,
i1height2,
i1height3,
version,
today,
start,
[end],
hhchange,
newhhid,
idenconf,
insert_time,
update_time,
inserted_by,
updateed_by,
i1._submission_time,
_submitted_by,
_date_modified,
_xform_id,
instance_id as instanceid,
_duration,
_media_all_received,
_media_count,
_id,
_uuid,
_version,
duplicate

from [mindr-live].dbo.all_i1mop i1
join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,i1.i1date,121)
left join 
(select b.childuid,b.i1date,max(b._submission_time) _submission_time
from (select i1_1.childuid,i1_1.i1date,_submission_time from [mindr-live].dbo.all_i1mop i1_1
left join (select i1_2.childuid, max(i1date) i1date 
from [mindr-live].dbo.all_i1mop i1_2
where duplicate is null
group by i1_2.childuid) a on a.childuid = i1_1.childuid and i1_1.i1date =a.i1date where a.i1date is not null
and i1_1.duplicate is null 

) b group by b.childuid,b.i1date) c on c.childuid = i1.childuid  and c.i1date = i1.i1date and c._submission_time = i1._submission_time 
where i1.duplicate is null and c.childuid is not null                  
