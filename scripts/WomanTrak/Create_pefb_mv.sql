use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='pefb_mv')
begin 
drop view pefb_mv 
end 
go 

create view pefb_mv 
as 

select 
pe.[uid],
[version],
[today],
[start],
[end],
scheduleid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
jw.jivitaweek as pebwkint ,
convert(smalldatetime,pe.pebdate,121) as pebdate,
womname,
husbname,
idenconf,
workerid,
pebstatus,
convert(smalldatetime,pe.pebdoc,121) as pebdoc,
convert(smalldatetime,pe.pebdod,121) as pebdod,
pebtemp,
pebtempn1,
pebsysto1,
pebdiast1,
pebbptime1,
workerid_bp,
pebweight,
pebheight1,
pebheight2,
pebheight3,
pebmuac1,
pebmuac2,
pebmuac3,
pebsysto2,
pebdiast2,
pebbptime2,
workerid_an,
pebmealdate,
pebmealtime,
pebmealtimec,
pebfood,
pebblood1,
pebblood2,
pebspecid1,
st,
vt,
supt,
pebspecid2,
st1,
vt1,
supt1,
pebbldtime,
pebhemo,
pebfetab,
pebbltype,
pebrhtype,
workerid_bl
from [mindr-live].dbo.all_pefb pe inner join
shapla.dbo.jivitaweek as jw on jw.romandate = convert(smalldatetime, pe.pebdate, 121)
left join 
----
(select b.uid,b.pebdate,max(b._submission_time) _submission_time
from (select pe1.uid,pe1.pebdate,_submission_time from [mindr-live].dbo.all_pefb pe1
left join (select wv2.uid, max(pebdate) pebdate 
from [mindr-live].dbo.all_pefb wv2
where duplicate is null
group by wv2.uid) a on a.uid = pe1.uid and pe1.pebdate =a.pebdate where a.pebdate is not null
and pe1.duplicate is null 

) b group by b.uid,b.pebdate) c on c.uid = pe.uid  and c.pebdate = pe.pebdate and c._submission_time = pe._submission_time 
where pe.duplicate is null and c.uid is not null                  
