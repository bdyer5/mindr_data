use [mindr-live]
go


-- CREATE KIDRTAK table
if exists(select * from sysobjects where name='kidtrak')
drop table kidtrak
go 

print ''
print '1. Insert all child records into kidtrak'
print ''
select distinct c1.uid as childuid,
c1.w_uid as momuid,
null as arm,
null as pe_consent,
null as bnf_date,
--c1.gender as sexcd,
null as sexcd,
null as sexsrc, 
null as bgga,
null as preterm,
NUll as sectorid,
NULL as tlpincd,
NULL as hhid,
-- child_name, 
-- w.woman_name as mothername,
-- w.husband_name as fathername,
-- substring(dob,9,2) as CDOBDay,
-- substring(dob,6,2) as CDOBMonth,
-- substring(dob,1,4) as CDOBYear,
null as CDOBDay,
null as CDOBMonth,
null as CDOBYear,
null as dobsource, --'j6Child'
null as BGwob, --Best Guess Week of Birth
null as BGdob,  --Best Guess Date of Birth
null as tob,  --Time of Birth
null as tobsrc,  --Time of Birth source 
null as anthro_date,  --Anthro datetime
null as anthro_location,  --Anthro location (source)
null as bgdobru, --Best Guess Date of Birth Rule: 'Rule 01: Take exact date of birth child table
null as bgdobsrc,
--NULL as MJ5Status,--Mother�s J5 Status 0=Urt+ before ### 1= Urt+ between ### and ###
NULL as AgehrsAnth, --Age in hours at time of anthropometry
NULL as agefd_anthro,
NULL as AgeAnthru, --01 is the only option (anthageru)
null as anthro72,
Null as VStatus, --vital status 0=alive 1=Death
null as	VSSrc, --source of information mCare2 forms name
NULL as bgwod,--Best Guess Week of Death
NULL as deathdd,--Best Guess Date of Death
NULL as deathmm, --Best Guess Date of Death
NULL as deathyy, --Best Guess Date of Death
NULL as bgdod, --Best Guess Date of Death
NULL as tod, --Time of death
NULL as todsrc, --Time of death source
NULL as	bgdodru, --Rule used to calculate BGDOD
NULL as	DeadAgeD, --Days Age at Death � Days
NULL as	[sibling],
null as twin,
--NULL as	[j5alloc] ,
--NULL as	SubSampl ,--is the kid in the substudy SubSampl
NULL as	ibafwk, --Week of  BAF Interview
NULL as	ibafrd,--Date of  BAF Interview
null as ibaf_status,--Status of BAF Interview
NULL as	fbafwk, --Week of Facility BAF Interview
NULL as	fbafrd,--Date of Facility BAF Interview
null as fbaf_status,--Status of Facility BAF Interview
NULL as	i1mopwk,--Week of  I1MOP Interview
NULL as	i1moprd, --Roman Date of  I1MOP interview
null as i1mop_status,
NULL as	i3mopwk,--Week of  I1MOP Interview
NULL as	i3moprd, --Roman Date of  I3_6MOP interview
null as i3mop_status,
NULL as	i3mopsrd, --Roman Date of  I3_6MOP stool collection
null as i3mops_status,
NULL as	i6mopwk,--Week of  I6_9MOP Interview
NULL as	i6moprd, --Roman Date of  I6_9MOP interview
null as i6mop_status,
NULL as Agedayi1mop, --Age in dayd at time of i1mop
NULL as Agedayi1mopru, --01 is the only option (Agedayi1mopru)
--NULL as	[ivsrwk] ,--Week of� IVSR�
--NULL as	ssconsentcd , --Substudy WIC
NULL as	censrvital , --Vital status at censor 1=Alive,2=Alive but not met,8=Dead
NULL as	censrwk , --Week of censorship
NULL as	censrru , --Censorship rule
NULL as	censrdate, --Date of censorship Date
NULL as	censraged --Age in day at time of  censorship
into kidtrak
from  [mindr-live].dbo.child c1
join pregtrak w on w.uid=c1.w_uid
where c1.w_uid in (select uid from [mindr-live].dbo.pregtrak where pef_consent='1')
and child_status is null 
--and c1.w_uid not in (select uid from wtrak where pdroutc ='4' )
go

-- Temporarily drop these potentially duplicate uids in the child table
-- These are childuids that were additional even though in bnf and mbaf were indicated as singletons and not multiple births


alter table kidtrak
alter column sexsrc varchar(30) null -- Source of where the sex is coming from
go 

alter table kidtrak
alter column arm char(1) null -- Source of where the sex is coming from
go 

alter table kidtrak
alter column bgdobsrc varchar(30) null -- Source of where the date of birth is coming from
go 

alter table kidtrak
alter column bgdob smalldatetime null -- Source of where the date of birth is coming from
go 


alter table kidtrak
alter column bnf_date smalldatetime NULL
go 

alter table kidtrak
alter column bgdobru int NULL
go 

-- There was no sexcd in i1mop like there is in target so I took out the 1mop 
update kidtrak
set sexcd =  coalesce(
i.ibsex,i2.ibsex,f.fbsex,f2.fbsex),
sexsrc= case 
when i.ibstatus !=2 and i.ibsex is not null then 'ibaf' 
when i2.ibstatus =2 and i2.ibsex is not null then 'ibaf - not met' 
when f.fbstatus !=2 and f.fbsex is not null then 'fbaf'
when f2.fbstatus =2 and f2.fbsex is not null then 'fbaf - not met'
 else null end 
from kidtrak k
left join (select * from ibaf_mv where ibstatus !=2) i on i.childuid = k.childuid
left join (select * from ibaf_mv where ibstatus =2) i2 on i2.childuid = k.childuid
left join (select * from fbaf_mv  where fbstatus !=2) f on f.childuid = k.childuid 
left join (select * from fbaf_mv  where fbstatus =2) f2 on f2.childuid = k.childuid 
go 



update kidtrak
set pe_consent = w.pef_consent,
arm = w.arm_pw 
--select 
--k.childuid,k.momuid ,w.arm_pw 
from kidtrak k
left join [mindr-live].dbo.pregtrak w on w.uid = k.momuid
go 



update kidtrak
set bnf_date = b.bnfdate
from kidtrak k
left join bnf_mv b on b.uid = k.momuid
where b.bnfdate is not null 
go 


-- SectorID
print '2. Update SectorID '
alter table kidtrak
alter column sectorid char (3) null
go
-- alter table kidtrak
-- add psdr_sector char (3) null
-- go
-- alter table kidtrak
-- add psdr_sector_raw char (3) null
-- go
-- alter table kidtrak
-- add psdr_sector_extraraw char (3) null
-- go
update kidtrak
--set sectorid=w.psdr_sector_extraraw,psdr_sector=w.psdr_sector,psdr_sector_raw=w.psdr_sector_raw,psdr_sector_extraraw=w.psdr_sector_extraraw
set sectorid=p.sector
--,psdr_sector=w.psdr_sector,
--psdr_sector_raw=w.psdr_sector_raw,
--psdr_sector_extraraw=w.psdr_sector_extraraw
from [mindr-live].dbo.pregtrak p
join kidtrak k on k.momuid=p.UID
go

-- HHID
print '2.1 Update HHID '
alter table kidtrak
alter column hhid char (4) null
go
update kidtrak
set hhid=p.hhid
from kidtrak k
left join [mindr-live].dbo.pregtrak p on k.momuid=p.UID
go

-- TLPINCD
print '3. Update TLPINCD '
alter table kidtrak
alter column tlpincd char (2) null
go
update kidtrak
set tlpincd=p.TLPIN
from kidtrak k
left join [mindr-live].dbo.pregtrak p on k.momuid=p.UID
go

-- null as CDOBDay,
-- null as CDOBMonth,
-- null as CDOBYear,
-- null as dobsource, --'j6Child'
-- null as BGwob, --Best Guess Week of Birth
-- null as BGdob,  --Best Guess Date of Birth
-- null as bgdobru, --Best Guess Date of Birth Rule: 'Rule 01: Take exact date of birth child table


print '4. Get date of birth from ibaf, fbaf,bnf, then child '
update kidtrak
set bgdob=null 
from kidtrak k 
go 

-- Edited on 20250417 after realizing bgdob and bgdoutc from wtrak were not matching 
update kidtrak
set cdobday = substring(convert(varchar,coalesce(convert(smalldatetime,i.ibdob,121),convert(smalldatetime,f.fbdob,121),convert(smalldatetime,substring(b.bnfdtoo,1,10),121),convert(smalldatetime,c.dob,121)) ,121),9,2) ,
cdobmonth = substring(convert(varchar,coalesce(convert(smalldatetime,i.ibdob,121),convert(smalldatetime,f.fbdob,121),convert(smalldatetime,substring(b.bnfdtoo,1,10),121),convert(smalldatetime,c.dob,121)) ,121),6,2),
cdobyear = substring(convert(varchar,coalesce(convert(smalldatetime,i.ibdob,121),convert(smalldatetime,f.fbdob,121),convert(smalldatetime,substring(b.bnfdtoo,1,10),121),convert(smalldatetime,c.dob,121)) ,121),1,4),
bgdob = coalesce(convert(smalldatetime,i.ibdob,121)
,convert(smalldatetime,f.fbdob,121)
,convert(smalldatetime,substring(b.bnfdtoo,1,10),121)
,convert(smalldatetime,c.dob,121)
,convert(smalldatetime,substring(convert(varchar,coalesce(convert(smalldatetime,i.ibdob,121),convert(smalldatetime,f.fbdob,121),
convert(smalldatetime,substring(b.bnfdtoo,1,10),121),
convert(smalldatetime,c.dob,121)) ,121),1,4)+'-'+
substring(convert(varchar,coalesce(convert(smalldatetime,i.ibdob,121),convert(smalldatetime,f.fbdob,121),convert(smalldatetime,substring(b.bnfdtoo,1,10),121),convert(smalldatetime,c.dob,121)) ,121),6,2)+'-'+
substring(convert(varchar,coalesce(convert(smalldatetime,i.ibdob,121),convert(smalldatetime,f.fbdob,121),convert(smalldatetime,substring(b.bnfdtoo,1,10),121),convert(smalldatetime,c.dob,121)) ,121),9,2)
)),
bgdobsrc = case when i.ibdob is not null then 'ibaf'   
when f.fbdob is not null then 'fbaf' 
when b.bnfdtoo is not null then 'bnf'
when c.dob is not null then 'child'
 else null end ,

bgdobru = case when i.ibdob is not null then 1
when f.fbdob is not null then 2 
when b.bnfdtoo is not null then 3
when c.dob is not null then 4 else null end

from kidtrak k 
left join ibaf_mv i on k.childuid=i.CHILDUID
left join fbaf_mv f on k.childuid=f.CHILDUID
left join child c on k.childuid=c.UID
left join bnf_mv b on b.uid = k.momuid 
go 




--Create ktsibling

print ''
print '6. Create ktsibling view to compose sibling data'
if exists (select * from sysobjects where name = 'ktsiblings')
drop view ktsiblings
go
create view ktsiblings as
   select distinct momuid as momuid, lbn, sbn,
	case when lbn=1 and sbn=0 then 0
	     when lbn=1 and sbn=1 then 2
	     when lbn=2 and sbn=0 then 1
	     when lbn=2 and sbn=1 then 4
	     when lbn=3 and sbn=0 then 3
	     when lbn=1 and sbn=2 then 5 end  as siblingCD
  from (
      select lbn.momuid, coalesce (cast (mbsbn as int), 0)sbn, lbn
	  from  (select uid from [mindr-live].dbo.pregtrak where pef_consent='1') cons
      left join (select distinct momuid, count (*) lbn from [mindr-live].dbo.kidtrak 
	  group by momuid) lbn on cons.uid = lbn.momuid
	  left join (select uid, coalesce(max(mbsbn),0) mbsbn from [mindr-live].dbo.mbaf_mv  f
	  where mbsbn is not NULL and mbsbn <> '$' and mbsbn != 'n/a'
	  group by uid) sinf on lbn.momuid = sinf.uid
	  where momuid is not null 
) o    --NOTE: 0 for singletons, 1 for live twins, 2 for one live/one SB, 3 for 3 LB, 4 for 2 LB/1SB, and 5 for 1LB/2SB
go

--Update J5ktsibling
print ''
print '6.1. Update kidtrak table with sibling data'
update kidtrak
set sibling=kts.siblingcd
from kidtrak join ktsiblings kts on kidtrak.momuid=kts.momuid
go
-- --Update mother is in the substudy or not
-- print '5. Update whether mother is in the substudy or not'
-- update kidtrak
-- --set kidtrak.subsampl=s.ss_consent,kidtrak.ssconsentcd=s.sscon_status
-- set kidtrak.subsampl=s.sef_consent_fm,kidtrak.ssconsentcd=s.sef_consent
-- from kidtrak k join wtrak s on k.momuid=s.UID
-- --where ss_consent='1'
-- go
-- select subsampl,ssconsentcd,* from kidtrak where subsampl =1

----Update mother is in the substudy or not
--print '5. Update whether mother is in the substudy or not'
--update kidtrak
----set kidtrak.subsampl=s.ss_consent,kidtrak.ssconsentcd=s.sscon_status
--set kidtrak.subsampl=s.ssle_consent_fm,kidtrak.ssconsentcd=s.ssle_consent
--from kidtrak k join wtrak s on k.momuid=s.UID
----where ss_consent='1'
--go

--Best guess week of birth date
--declare @cutoff int
--select @cutoff =1004 --:FOR DSMB
-- print ''
-- print '6. Start getting best guess week of birth....'
-- print ''
-- update kidtrak
-- set bgwob=j.jivitaweek
-- from kidtrak k join shapla.dbo.jivitaweek j on datepart(dd,romandate)=Cast(cdobday as int) and datepart(mm,romandate)=cast(cdobmonth as int) and datepart(yy, romandate)=cdobyear
-- where isdate (cdobmonth + '/' + cdobday + '/' + cdobyear )=1 and dobsource='1' --'J6CHILD'
-- --and j.jivitaweek<= @cutoff
-- go
--Best guess week of birth date for diffrent date format 2 digits



print ''
print '7. Start getting best guess week of birth....'
print ''
update kidtrak
set bgwob=j.jivitaweek
from kidtrak k join shapla.dbo.jivitaweek j on romandate= bgdob --Cast(cdobday as int) and datepart(mm,romandate)=cast(cdobmonth as int) and datepart(yy, romandate)=cdobyear
--where  isdate (cdobmonth + '/' + cdobday + '/' + cdobyear )=1 and dobsource='1' --'J6CHILD'
go

-- BAF week & date
alter table kidtrak
alter column ibafwk char(4) null
go
alter table kidtrak
alter column ibaf_status  char(1) null
go

alter table kidtrak
alter column ibafrd  smalldatetime
go


print '8. Get BAF week and date'
update kidtrak
set ibafwk = ib.ibwkint
, ibafrd = ib.ibdate
,ibaf_status=ib.ibstatus
--,ibaf_status8=case when ib.bastatus8='n/a' then null when ib.bastatus8='' then null else ib.bastatus8 end
--select ib.bawkint,ib.badate,ib.bastatus,ib.bastatus8
from kidtrak kt
join  ibaf_mv  ib on  ib.childuid = kt.childuid
go
 ------------------------------------------------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------------------------
 
-- BAF week & date
alter table kidtrak
alter column fbafwk char(4) null
go
alter table kidtrak
alter column fbaf_status  char(1) null
go

alter table kidtrak
alter column fbafrd  smalldatetime
go


print '9. Get FBAF week and date'
update kidtrak
set fbafwk = bma.fbwkint
, fbafrd = bma.fbdate
,fbaf_status=bma.fbstatus
--,ibaf_status8=case when bma.bastatus8='n/a' then null when bma.bastatus8='' then null else bma.bastatus8 end
--select bma.bawkint,bma.badate,bma.bastatus,bma.bastatus8
from kidtrak kt
join  fbaf_mv  bma on  bma.childuid = kt.childuid
go



-- I1MOP date
alter table kidtrak
alter column i1mop_status  char(1) null
go
alter table kidtrak
alter column i1moprd  smalldatetime
go

print '10. Get I1MOP week and date'
update kidtrak
set i1mopwk=i1wkint,i1moprd=i1date,i1mop_status=i1status
from kidtrak k join [mindr-live].dbo.i1mop_mv v on k.childuid=v.childuid
go


-- I3_6MOP date
alter table kidtrak
alter column i3mop_status  char(1) null
go
alter table kidtrak
alter column i3moprd  smalldatetime
go

print '10. Get I3MOP week date and status'
update kidtrak
set i3mopwk=jw.jivitaweek,i3moprd=i3date,i3mop_status=i3status
from kidtrak k join [mindr-live].dbo.i36mop_mv v on k.childuid = v.childuid
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,i3date,121)
go


-- I6_9MOP date
alter table kidtrak
alter column i6mop_status  char(1) null
go
alter table kidtrak
alter column i6moprd  smalldatetime
go

print '10. Get I3MOP week date and status'
update kidtrak
set i6mopwk=jw.jivitaweek,i6moprd=i6date,i6mop_status=i6status
from kidtrak k join [mindr-live].dbo.i69mop_mv v on k.childuid = v.childuid
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,i6date,121)
go

-- -- C3MoI date
-- alter table kidtrak
-- add c3moiwk char(4) null
-- go
-- alter table kidtrak
-- add c3moi_status  char(1) null
-- go
-- alter table kidtrak
-- add c3moird  smalldatetime
-- go


-- print '9. Get C3MOI week and date'
-- update kidtrak
-- set c3moiwk=C3WKINT,c3moird=C3DATE,c3moi_status=C3STATUS
-- from kidtrak k
-- join jivita6.dbo.I3MOP_merged v on k.childuid=v.childuid
-- join [mindr-live].dbo.child c on v.childuid=c.childuid
-- where c.momuid in (select j5conuid from [mindr-live].dbo.ALLNWIC where J5CONS='1'
-- and duplicate = '0')
-- go

-- -- I6MoI date
-- alter table kidtrak
-- add i6moiwk char(4) null
-- go
-- alter table kidtrak
-- add i6moi_status  char(1) null
-- go

-- alter table kidtrak
-- add i6moird  smalldatetime
-- go


-- print '10. Get I6MOI week and date'
-- update kidtrak
-- set i6moiwk=I6WKINT,i6moird=I6DATE,i6moi_status=I6STATUS
-- from kidtrak k
-- join jivita6.dbo.I6MOI_merged v on k.childuid=v.childuid
-- join [mindr-live].dbo.child c on v.childuid=c.childuid
-- where c.momuid in (select j5conuid from [mindr-live].dbo.ALLNWIC where J5CONS='1'
-- and duplicate = '0')
-- go


--BG Anthropometry
--KH: Need to have UserDefinedFunction [dbo].[dtime] installed on this DB (can be found in j3 DB)
print '11. Best guess age at anthropometry'

if exists(select * from sysobjects where name='preanthage')
drop table preanthage
go

-- select distinct * into preanthage
-- from(
-- select i.CHILDUID,
-- case when ibatimehr<>'$$' and ibatimemn<>'$$' and ibatimeap<>'$' or ibatimehr<>'' and ibatimemn<>'' and ibatimeap<>''
-- then dbo.dtime(badate,ibatimehr,ibatimemn,ibatimeap) end as anthDateTime, --KH:anthDateTime =BAF intv date + ANTHROPOMETRY time case# 1
-- case when ibbtimehr<>'$$' and ibbtimemn<>'$$' and ibbtimeap<>'$' or ibbtimehr<>'' and ibbtimemn<>'' and ibbtimeap<>''
-- then dbo.dtime(bgdob,ibbtimehr,ibbtimemn,ibbtimeap) end as birthdatetime,--KH:birthdatetime =date of Birth + Time of birth case# 2
-- '01' anthageru
-- from [mindr-live].dbo.ibaf_mv  i
-- join kidtrak k on k.childuid=i.CHILDUID
-- where isdate(ibdob)=1 --and bgdob=cast(ibdobmm+'-'+ibdobdd+'-'+ibdobyy as datetime)
-- ) o
-- go



-- select distinct * into preanthage
-- from(


-- select i.CHILDUID,
-- coalesce(
-- case when fbatimehr<>'$$' and fbatimemn<>'$$' and fbatimeap<>'$' or fbatimehr<>'' and fbatimemn<>'' and fbatimeap<>''
-- then dbo.dtime(fbdate,fbatimehr,fbatimemn,fbatimeap) end,
-- case when ibatimehr<>'$$' and ibatimemn<>'$$' and ibatimeap<>'$' or ibatimehr<>'' and ibatimemn<>'' and ibatimeap<>''
-- then dbo.dtime(ibdate,ibatimehr,ibatimemn,ibatimeap) end
-- )as anthDateTime, --anthDateTime =BAF intv date + ANTHROPOMETRY time case# 1
-- coalesce(case when ibbtimehr<>'$$' and ibbtimemn<>'$$' and ibbtimeap<>'$' or ibbtimehr<>'' and ibbtimemn<>'' and ibbtimeap<>''
-- then dbo.dtime(ibdob,ibbtimehr,ibbtimemn,ibbtimeap) end,
-- case when fbbtimehr<>'$$' and fbbtimemn<>'$$' and fbbtimeap<>'$' or fbbtimehr<>'' and fbbtimemn<>'' and fbbtimeap<>''
-- then dbo.dtime(fbdob,fbbtimehr,fbbtimemn,fbbtimeap) end)

-- as birthdatetime,--birthdatetime =date of Birth + Time of birth case# 2
-- '01' anthageru
-- from [mindr-live].dbo.ibaf_mv  i
-- join kidtrak k on k.childuid=i.CHILDUID
-- left join [mindr-live].dbo.all_fbaf  f on f.childuid = k.childuid 
-- where isdate(ibdob)=1 --and bgdob=cast(ibdobmm+'-'+ibdobdd+'-'+ibdobyy as datetime)

-- ) o
-- go

-- updated on 20240515
-- select distinct * into preanthage
-- from(
-- select k.CHILDUID,
-- coalesce(
-- case when fbatimehr<>'$$' and fbatimemn<>'$$' and fbatimeap<>'$' or fbatimehr<>'' and fbatimemn<>'' and fbatimeap<>''
-- then dbo.dtime(fbdate,fbatimehr,fbatimemn,fbatimeap) end,
-- case when ibatimehr<>'$$' and ibatimemn<>'$$' and ibatimeap<>'$' or ibatimehr<>'' and ibatimemn<>'' and ibatimeap<>''
-- then dbo.dtime(ibdate,ibatimehr,ibatimemn,ibatimeap) end
-- )as anthDateTime, --anthDateTime =BAF intv date + ANTHROPOMETRY time case# 1
-- coalesce(
-- case when fbbtimehr<>'$$' and fbbtimemn<>'$$' and fbbtimeap<>'$' or fbbtimehr<>'' and fbbtimemn<>'' and fbbtimeap<>''
-- then dbo.dtime(fbdob,fbbtimehr,fbbtimemn,fbbtimeap) end,
-- case when ibbtimehr<>'$$' and ibbtimemn<>'$$' and ibbtimeap<>'$' or ibbtimehr<>'' and ibbtimemn<>'' and ibbtimeap<>''
-- then dbo.dtime(ibdob,ibbtimehr,ibbtimemn,ibbtimeap) end)

-- as birthdatetime,--birthdatetime =date of Birth + Time of birth case# 2
-- '01' anthageru
-- from kidtrak k 
-- left join [mindr-live].dbo.ibaf_mv  i on k.childuid=i.CHILDUID
-- left join [mindr-live].dbo.fbaf_mv  f on f.childuid = k.childuid 
-- --where isdate(ibdob)=1 --and bgdob=cast(ibdobmm+'-'+ibdobdd+'-'+ibdobyy as datetime)
-- where ((i.ibweight is not null or f.fbweight is not null) and 
-- (i.ibmuac1 is not null or f.fbmuac1 is not null) and 
-- (i.ibmuac2 is not null or f.fbmuac2 is not null) and 
-- (i.ibmuac3 is not null or f.fbmuac3 is not null) and 
-- (i.ibcc1 is not null or f.fbcc1 is not null) and 
-- (i.ibcc2 is not null or f.fbcc2 is not null) and 
-- (i.ibcc3 is not null or f.fbcc3 is not null) and 
-- (i.ibhc1 is not null or f.fbhc1 is not null) and 
-- (i.ibhc2 is not null or f.fbhc2 is not null) and 
-- (i.ibhc3 is not null or f.fbhc3 is not null) and 
-- (i.ibheight1 is not null or f.fbheight1 is not null) and 
-- (i.ibheight2 is not null or f.fbheight2 is not null) and 
-- (i.ibheight3 is not null or f.fbheight3 is not null) ) 



-- ) o
-- go


select distinct * into preanthage
from(

select k.CHILDUID,
coalesce(
case when fbatimehr<>'$$' and fbatimemn<>'$$' and fbatimeap<>'$' or fbatimehr<>'' and fbatimemn<>'' and fbatimeap<>''
then dbo.dtime(fbdate,fbatimehr,fbatimemn,fbatimeap) end,
case when ibatimehr<>'$$' and ibatimemn<>'$$' and ibatimeap<>'$' or ibatimehr<>'' and ibatimemn<>'' and ibatimeap<>''
then dbo.dtime(ibdate,ibatimehr,ibatimemn,ibatimeap) end
)as anthDateTime, --anthDateTime =BAF intv date + ANTHROPOMETRY time case# 1
coalesce(
case when fbbtimehr<>'$$' and fbbtimemn<>'$$' and fbbtimeap<>'$' or fbbtimehr<>'' and fbbtimemn<>'' and fbbtimeap<>''
then dbo.dtime(fbdob,fbbtimehr,fbbtimemn,fbbtimeap) end,
case when ibbtimehr<>'$$' and ibbtimemn<>'$$' and ibbtimeap<>'$' or ibbtimehr<>'' and ibbtimemn<>'' and ibbtimeap<>''
then dbo.dtime(ibdob,ibbtimehr,ibbtimemn,ibbtimeap) end)

as birthdatetime,--birthdatetime =date of Birth + Time of birth case# 2
'01' anthageru,
case when fbatimehr<>'$$' and fbatimemn<>'$$' and fbatimeap<>'$' or fbatimehr<>'' and fbatimemn<>'' and fbatimeap<>''
then 2 when ibatimehr<>'$$' and ibatimemn<>'$$' and ibatimeap<>'$' or ibatimehr<>'' and ibatimemn<>'' and ibatimeap<>''
then 1 end as anthro_location 
from kidtrak k 
left join [mindr-live].dbo.ibaf_mv  i on k.childuid=i.CHILDUID
left join [mindr-live].dbo.fbaf_mv  f on f.childuid = k.childuid 
--where isdate(ibdob)=1 --and bgdob=cast(ibdobmm+'-'+ibdobdd+'-'+ibdobyy as datetime)
-- where (((i.ibweight is not null and i.ibweight !='0.000' ) or ( f.fbweight is not null and f.fbweight !='0.000')) and 
-- ((i.ibmuac1 is not null and i.ibmuac1 !='00.0' ) or ( f.fbmuac1 is not null and f.fbmuac1 !='00.0')) and 
-- ((i.ibmuac2 is not null and i.ibmuac2 !='00.0' ) or ( f.fbmuac2 is not null and f.fbmuac2 !='00.0')) and 
-- ((i.ibmuac3 is not null and i.ibmuac3 !='00.0' ) or ( f.fbmuac3 is not null and f.fbmuac3 !='00.0')) and 
-- ((i.ibcc1 is not null and i.ibcc1 !='00.0' ) or ( f.fbcc1 is not null and f.fbcc1 !='00.0')) and 
-- ((i.ibcc2 is not null and i.ibcc2 !='00.0' ) or ( f.fbcc2 is not null and f.fbcc2 !='00.0')) and 
-- ((i.ibcc3 is not null and i.ibcc3 !='00.0' ) or ( f.fbcc3 is not null and f.fbcc3 !='00.0')) and 
-- ((i.ibhc1 is not null and i.ibhc1 !='00.0' ) or ( f.fbhc1 is not null and f.fbhc1 !='00.0')) and 
-- ((i.ibhc2 is not null and i.ibhc2 !='00.0' ) or ( f.fbhc2 is not null and f.fbhc2 !='00.0')) and 
-- ((i.ibhc3 is not null and i.ibhc3 !='00.0' ) or ( f.fbhc3 is not null and f.fbhc3 !='00.0')) and 
-- ((i.ibheight1 is not null and i.ibheight1 !='00.0' ) or ( f.fbheight1 is not null and f.fbheight1 !='00.0')) and 
-- ((i.ibheight2 is not null and i.ibheight2 !='00.0' ) or ( f.fbheight2 is not null and f.fbheight2 !='00.0')) and 
-- ((i.ibheight3 is not null and i.ibheight3 !='00.0' ) or ( f.fbheight3 is not null and f.fbheight3 !='00.0'))) 
where ((i.ibweight is not null and i.ibweight !='0.000' and i.ibweight !='9.999' ) or ( f.fbweight is not null and f.fbweight !='0.000' and f.fbweight !='9.999'))

) o
go


alter table kidtrak 
alter column anthro_date datetime
go 

alter table kidtrak 
alter column anthro_location int
go 


update kidtrak 
set anthro_date = p.anthDateTime,
anthro_location = p.anthro_location
from kidtrak k
left join preanthage p on p.childuid =k.childuid 
go 


alter table kidtrak 
alter column tob datetime
go 

alter table kidtrak 
alter column tod datetime
go 

alter table kidtrak 
alter column tobsrc varchar(10)
go 

alter table kidtrak 
alter column todsrc varchar(10)
go 

update kidtrak 
set tob = p.birthdatetime,
tobsrc = 'preanth'
--select p.birthdatetime as tob 
from kidtrak k
left join preanthage p on p.childuid =k.childuid 


update kidtrak 
set tob = 
coalesce(
case when fbbtimehr<>'$$' and fbbtimemn<>'$$' and fbbtimeap<>'$' or fbbtimehr<>'' and fbbtimemn<>'' and fbbtimeap<>''
then dbo.dtime(fbdob,fbbtimehr,fbbtimemn,fbbtimeap) end,
case when ibbtimehr<>'$$' and ibbtimemn<>'$$' and ibbtimeap<>'$' or ibbtimehr<>'' and ibbtimemn<>'' and ibbtimeap<>''
then dbo.dtime(ibdob,ibbtimehr,ibbtimemn,ibbtimeap) end),
tobsrc = case when fbbtimehr<>'$$' and fbbtimemn<>'$$' and fbbtimeap<>'$' or fbbtimehr<>'' and fbbtimemn<>'' and fbbtimeap<>''
then 'fbaf' when ibbtimehr<>'$$' and ibbtimemn<>'$$' and ibbtimeap<>'$' or ibbtimehr<>'' and ibbtimemn<>'' and ibbtimeap<>''
then 'ibaf' end 
from kidtrak k 
left join [mindr-live].dbo.ibaf_mv  i on k.childuid=i.CHILDUID
left join [mindr-live].dbo.fbaf_mv  f on f.childuid = k.childuid 
where tob is null 

update kidtrak 
set tob = convert(datetime,substring(b.bnfdtoo,1,10)+' '+substring(b.bnfdtoo,12,8)),
tobsrc = 'bnf'
from kidtrak k 
left join bnf_mv b on b.uid = k.momuid 
where tob is null 




update kidtrak 
set tod = 
coalesce(
case when fbdtimehr<>'$$' and fbdtimemn<>'$$' and fbdtimeap<>'$' or fbdtimehr<>'' and fbdtimemn<>'' and fbdtimeap<>''
then dbo.dtime(fbdod,fbdtimehr,fbdtimemn,fbdtimeap) end,
case when ibdtimehr<>'$$' and ibdtimemn<>'$$' and ibdtimeap<>'$' or ibdtimehr<>'' and ibdtimemn<>'' and ibdtimeap<>''
then dbo.dtime(ibdod,ibdtimehr,ibdtimemn,ibdtimeap) end) ,
todsrc = 
case when fbdtimehr<>'$$' and fbdtimemn<>'$$' and fbdtimeap<>'$' or fbdtimehr<>'' and fbdtimemn<>'' and fbdtimeap<>''
then 'fbaf' when ibdtimehr<>'$$' and ibdtimemn<>'$$' and ibdtimeap<>'$' or ibdtimehr<>'' and ibdtimemn<>'' and ibdtimeap<>''
then 'ibaf' end 
from kidtrak k 
left join [mindr-live].dbo.ibaf_mv  i on k.childuid=i.CHILDUID
left join [mindr-live].dbo.fbaf_mv  f on f.childuid = k.childuid 
where tod is null 




--BG Anthropometry non-nullable for preanthage
print '11.1 Change the UID column to non-nullable for preanthage'
print ''
alter table preanthage
alter column childuid char(6) not null
go

-- print '11.2 Get the records where the BGDOB<>BAF DOB. use BGDOB from kidtrak for the date of birth and the time from BAF'
-- insert into preanthage
-- select i.childuid,
-- dbo.dtime(badate,ibatimehr,ibatimemn,ibatimeap) as anthDateTime,
-- dbo.dtime(bgdob,ibbtimehr,ibbtimemn, ibbtimeap) as birthdatetime,
-- '02' anthageru
-- from ibaf_mv  i
-- join kidtrak k on k.childuid=i.childuid and bgdob<>cast(ibdobmm+'-'+ibdobdd+'-'+ibdobyy as datetime)
-- where isdate(ibdobmm+'-'+ibdobdd+'-'+ibdobyy)=1 -- and bawkint<=@cutoff
-- go


alter table kidtrak
alter column AgehrsAnth varchar(5) null
go

alter table kidtrak
alter column agefd_anthro decimal(10,2) null
go



--Update Age in hours at time of anthropometry
print '12. Update Age in hours at time of anthropometry'
-- update kidtrak
-- set  AgehrsAnth=datediff(hh,p.birthdatetime,p.anthdatetime),AgeAnthru=p.anthageru
-- from kidtrak k join preanthage p on p.CHILDUID=k.childuid
-- go

update kidtrak
set  AgehrsAnth=format(ROUND(cast(datediff(MINUTE,p.birthdatetime,p.anthdatetime) as decimal(6,1))/60 ,1),'N1'),AgeAnthru=p.anthageru
from kidtrak k join preanthage p on p.CHILDUID=k.childuid
go


update kidtrak
set  agefd_anthro= cast(cast(AgehrsAnth as decimal(10,2))/24.0 as decimal(10,2))
from kidtrak k join preanthage p on p.CHILDUID=k.childuid
go




--KT PreCensr Table
print ''
print '13. About to create KTPreCensrTable'
print ''
if exists(select * from sysobjects where name='ktprecensrtable')
drop table ktprecensrtable
go
if exists(select * from sysobjects where name='ktcensrtable')
drop table ktcensrtable
go

print '14. prepare to update censorship rule for maxweek'

-- note still need to add 6-9 month visit to this kidtrak 
select * into ktprecensrtable
from(

select v.childuid, '8' censrvital,'ibaf' how,'206' censrru, ibwkint CensrWk, ibdate as CensrDate -- ibstatus8
from ibaf_mv  v join kidtrak c on v.childuid=c.childuid
where v.ibstatus='8' -- and ibstatus8='1' --and Cast(ibwkint as int)<=@cutoff
union all
select v.childuid, '1' censrvital,'ibaf' how,'206' censrru, ibwkint CensrWk, ibdate as CensrDate
from ibaf_mv  v join kidtrak c on v.childuid=c.childuid
where v.ibstatus='1' --and ibstatus8!='1'-- and Cast(ibwkint as int)<=@cutoff
union all
select v.childuid, '8' censrvital,'fbaf' how,'207' censrru, fbwkint CensrWk, fbdate as CensrDate -- ibstatus8
from fbaf_mv  v join kidtrak c on v.childuid=c.childuid
where v.fbstatus='8' -- and ibstatus8='1' --and Cast(ibwkint as int)<=@cutoff
union all
select v.childuid, '1' censrvital,'fbaf' how,'207' censrru, fbwkint CensrWk, fbdate as CensrDate
from fbaf_mv  v join kidtrak c on v.childuid=c.childuid
where v.fbstatus='1' --and ibstatus8!='1'-- and Cast(ibwkint as int)<=@cutoff
union all
select v.childuid, '1' censrvital,'ibaf' how,'206' censrru, ibwkint CensrWk, ibdate as CensrDate
from ibaf_mv  v
join [mindr-live].dbo.pregtrak p on p.uid =v.uid 
where v.uid in (select uid from [mindr-live].dbo.pregtrak where pef_consent='1')
and outc not in ('02','03','06','09')
union all
select v.childuid, '1' censrvital,'I1MOP' how,'209' censrru, i1wkint CensrWk,v.i1date as CensrDate
from i1mop_mv v join kidtrak c on v.childuid=c.childuid
where v.i1status='1' --where i1mopstatus='1' --and cast(i1wkint as int)<=@cutoff
union all
select v.childuid, '8' censrvital,'I1MOP' how,'209' censrru, i1wkint CensrWk,v.i1date as CensrDate
from i1mop_mv v join kidtrak c on v.childuid=c.childuid
where v.i1status='8' --where i1mopstatus='1' --and cast(i1wkint as int)<=@cutoff
union all
select v.childuid, '1' censrvital,'I3_6MOP' how,'210' censrru, jw.jivitaweek CensrWk,v.i3date as CensrDate
from i36mop_mv v join kidtrak c on v.childuid=c.childuid
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,v.i3date,121)
where v.i3status='1' --where i1mopstatus='1' --and cast(i3wkint as int)<=@cutoff
union all
select v.childuid, '8' censrvital,'I3_6MOP' how,'210' censrru, jw.jivitaweek CensrWk,v.i3date as CensrDate
from i36mop_mv v join kidtrak c on v.childuid=c.childuid
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,v.i3date,121)
where v.i3status='8' --where i1mopstatus='1' --and cast(i3wkint as int)<=@cutoff
union all
select v.childuid, '1' censrvital,'I6_9MOP' how,'211' censrru, jw.jivitaweek CensrWk,v.i6date as CensrDate
from i69mop_mv v join kidtrak c on v.childuid=c.childuid
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,v.i6date,121)
where v.i6status='1' --where i1mopstatus='1' --and cast(i3wkint as int)<=@cutoff
union all
select v.childuid, '8' censrvital,'I6_9MOP' how,'211' censrru, jw.jivitaweek CensrWk,v.i6date as CensrDate
from i69mop_mv v join kidtrak c on v.childuid=c.childuid
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,v.i6date,121)
where v.i6status='8' --where i1mopstatus='1' --and cast(i3wkint as int)<=@cutoff
union all
select k.childuid, '1' censrvital,'BGDOB','001',bgwob,bgdob
from kidtrak k join  [mindr-live].dbo.ktsiblings c on k.momuid=c.momuid and c.siblingCD='1'
--and cast(bgwob as int)<=@cutoff

)p
go


--.TODO: Does this update below work? Is max censrvital the correct one for maxweek? need to check.
print '14. prepare to update censorship rule for maxweek'
select childuid,max(censrvital) censrvital,cast ('XXXX' as char (4)) CensrRu,max(censrwk) censrwk,max(censrdate) censrdate
into ktcensrtable
from ktprecensrtable
group by childuid
go
print ''
print '14.1 Update censorship rule'
alter table ktcensrtable
alter column censrru char (10)
go
update ktcensrtable set censrru = k.censrru
from ktprecensrtable k
where ktcensrtable.childuid = k.childuid and ktcensrtable.censrdate = k.censrdate and ktcensrtable.censrvital = k.censrvital
go

--Update kidtrak with censor info
print '15. Update kidtrak with censor information'
alter table kidtrak
alter column censrdate smalldatetime null
go
alter table kidtrak
alter column censrru char (10)
go
update kidtrak
set censrvital=ktc.censrvital,censrru=ktc.censrru,censrwk=ktc.censrwk, censrdate = ktc.censrdate
,censraged=datediff(dd,bgdob,(cast(ktc.censrdate as smalldatetime)))
from kidtrak join ktcensrtable ktc on kidtrak.childuid=ktc.childuid
go
--select censrru,censrvital,censrdate,* from kidtrak where censrdate is null

-- BG i1mop Date
print '16. Best guess age at i1mop'
if exists(select * from sysobjects where name='prei1mopage')
drop table prei1mopage
go

select * into prei1mopage
from(
select i.CHILDUID,
I1Date as Datei1mop, --KH:i1Date =i1mop intv date
bgdob as birthdate,
'01' i1ageru
from [mindr-live].dbo.i1mop_mv i
join kidtrak k on k.childuid=i.CHILDUID
where isdate(I1Date)=1 and bgdob=cast( bgdob as datetime)

) o
go
print '16.1 Update Age in days at time of i1mop'
update kidtrak
set Agedayi1mop=datediff(dd,p.birthdate,p.Datei1mop),Agedayi1mopru=p.i1ageru
from kidtrak k join prei1mopage p on p.CHILDUID=k.childuid
go

-- -- BG C3moi Date
-- print '17. Best guess age at C3moi'
-- if exists(select * from sysobjects where name='prec3moiage')
-- drop table prec3moiage
-- go

-- select * into prec3moiage
-- from(
-- select i.CHILDUID,
-- C3Date as Datec3moi, --KH:i1Date =c3moi intv date
-- bgdob as birthdate,
-- '01' c3ageru
-- from jivita6.dbo.I3MOP_merged i
-- join kidtrak k on k.childuid=i.CHILDUID
-- where isdate(C3Date)=1 and bgdob=cast( bgdob as datetime)

-- ) o
-- go
-- alter table kidtrak
-- add Agedayc3moi char (10) null
-- go
-- alter table kidtrak
-- add  Agedayc3moiru char (10)
-- go
-- print '17.1 Update Age in days at time of C3moi'
-- update kidtrak
-- set Agedayc3moi=datediff(dd,p.birthdate,p.Datec3moi),Agedayc3moiru=p.c3ageru
-- from kidtrak k join prec3moiage p on p.CHILDUID=k.childuid
-- go

-- -- BG i6moi Date
-- print '18. Best guess age at i6moi'
-- if exists(select * from sysobjects where name='prei6moiage')
-- drop table prei6moiage
-- go

-- select * into prei6moiage
-- from(
-- select i.CHILDUID,
-- I6Date as Datei6moi, --KH:i1Date =I6moi intv date
-- bgdob as birthdate,
-- '01' i6ageru
-- from jivita6.dbo.I6MOI_merged i
-- join kidtrak k on k.childuid=i.CHILDUID
-- where isdate(I6Date)=1 and bgdob=cast( bgdob as datetime)

-- ) o
-- go
-- alter table kidtrak
-- add Agedayi6moi char (10) null
-- go
-- alter table kidtrak
-- add  Agedayi6moiru char (10)
-- go
-- print '18.1. Update Age in days at time of I6moi'
-- update kidtrak
-- set Agedayi6moi=datediff(dd,p.birthdate,p.Datei6moi),Agedayi6moiru=p.i6ageru
-- from kidtrak k join prei6moiage p on p.CHILDUID=k.childuid
-- go


print '19.1. Update Child death information form IVBA and VStatusTable'
alter table kidtrak
alter column VSSrc char (1)
go
alter table kidtrak
alter column bgdod smalldatetime null
go
alter table kidtrak
alter column bgwod char (4)
go
alter table kidtrak
alter column bgdodru char (1)
go


print 'death information form ibaf'
--DOD rule 1 form IVBA
update kidtrak
set VStatus =8 , VSSrc='1' , bgdodru=1, bgwod =v.ibwkint, BGdod=v.ibdod
, deathdd=datepart(day,v.ibdod)
,deathmm=datepart(MONTH,v.ibdod)
,deathyy=datepart(YEAR,v.ibdod)
from  [mindr-live].dbo.ibaf_mv v join kidtrak k on  v.childuid=k.childuid 
where  v.ibstatus = 8 and v.ibdod is not null 

GO

print 'death information from i1mop'
update kidtrak
set VStatus =8 , VSSrc='2' , bgdodru=1, bgwod =v.i1wkint, BGdod=v.i1dod
, deathdd=datepart(day,v.i1dod)
,deathmm=datepart(MONTH,v.i1dod)
,deathyy=datepart(YEAR,v.i1dod)
from  [mindr-live].dbo.i1mop_mv v
left join kidtrak k on v.childuid=k.childuid 
where v.i1status = 8
and v.i1dod is not null and BGdod is null
go 

print 'death information from i1mop'
update kidtrak
set VStatus =8 , VSSrc='3' , bgdodru=1, bgwod =jw.jivitaweek, BGdod=v.i3dod
, deathdd=datepart(day,v.i3dod)
,deathmm=datepart(MONTH,v.i3dod)
,deathyy=datepart(YEAR,v.i3dod)
from  [mindr-live].dbo.i36mop_mv v
left join kidtrak k on v.childuid=k.childuid 
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,v.i3date,121)
where v.i3status = 8
and v.i3dod is not null and BGdod is null
go 


print 'death information from i1mop'
update kidtrak
set VStatus =8 , VSSrc='3' , bgdodru=1, bgwod =jw.jivitaweek, BGdod=v.i6dod
, deathdd=datepart(day,v.i6dod)
,deathmm=datepart(MONTH,v.i6dod)
,deathyy=datepart(YEAR,v.i6dod)
from  [mindr-live].dbo.i69mop_mv v
left join kidtrak k on v.childuid=k.childuid 
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,v.i6date,121)
where v.i6status = 8
and v.i6dod is not null and BGdod is null
go 


-- print 'death information form vstatusview2'
-- --DOD rule 2 form mCare2 Death table
-- update kidtrak
-- set VStatus =v.VStatus , VSSrc=v.VSSrc,bgdodru=v.VSSrc, bgwod =v.bgwkd  , BGdod=v.bgdod, deathdd=datepart(day,v.bgdod),deathmm=datepart(MONTH,v.bgdod),deathyy=datepart(YEAR,v.bgdod)
-- from  vstatusview2 v join kidtrak k on v.CHILDUID=k.childuid
-- where v.bgwkd is not NULL AND k.VSSrc IS NULL
-- GO

-- DeadAgeD Date
--print '19.2 Best guess age at death'
go
alter table kidtrak
alter column DeadAgeD int null
go

print '20 Update Age in days at time of death '
update kidtrak
set DeadAgeD=datediff(dd,bgdob,bgdod)
from kidtrak
where bgdod  is not null

print ' update Censraged with deadaged where child died'
update kidtrak 
set censraged = deadaged 
from kidtrak
where censrvital =8 



alter table kidtrak
alter column bgga decimal (10,1)
go 

print '21 Update bgga from wtrak '
update kidtrak
set bgga=w.bgga 
from kidtrak k
left join pregtrak w on w.uid = k.momuid 


print '22 Update bgga from wtrak '
update kidtrak
set preterm= case when bgga <37 then 1 
when bgga >=37 then 2
end 
from kidtrak

print '23 Update bgga from wtrak '
update kidtrak
set twin= case when sibling =1 and outc ='07' then 2 
when sibling =2 and outc ='08' then 2 
when sibling=0 then 1 end 
from kidtrak k
left join pregtrak w on k.momuid  = w.uid  

print '24 Anthrom LT = 72 Hrs'
update kidtrak
set anthro72= case when agehrsanth <=cast(72  as decimal) then 1
when agehrsanth >cast(72  as decimal) then 2 end
from kidtrak 


print 'Adding Anthropoetry data from my ianthro into kidtrak '
-- wt_birth
-- len_birth
-- muac_birth
-- hc_birth
-- cc_birth
-- aged_ibaf
-- aged_fbaf
-- aged_birth
-- i1date
-- i1status
-- wt1
-- len1
-- muac1
-- hc1
-- cc1
-- aged1
-- agem1

-- alter table kidtrak
-- add dob_dt smalldatetime
-- go

alter table kidtrak
add wt_birth varchar(10)
go

alter table kidtrak
add len_birth varchar(10)
go

alter table kidtrak
add muac_birth varchar(10)
go

alter table kidtrak
add hc_birth varchar(10)
go

alter table kidtrak
add cc_birth varchar(10)
go

-- alter table kidtrak
-- add aged_ibaf varchar(10)
-- go

-- alter table kidtrak
-- add aged_fbaf varchar(10)
-- go

-- alter table kidtrak
-- add aged_birth varchar(10)
-- go

-- alter table kidtrak
-- add i1date smalldatetime
-- go

alter table kidtrak
add i1status varchar(10)
go

alter table kidtrak
add wt1 varchar(10)
go

alter table kidtrak
add len1 varchar(10)
go

alter table kidtrak
add muac1 varchar(10)
go

alter table kidtrak
add hc1 varchar(10)
go

alter table kidtrak
add cc1 varchar(10)
go

-- alter table kidtrak
-- add aged1 varchar(10)
-- go

-- alter table kidtrak
-- add agem1 varchar(10)
-- go

-- alter table kidtrak
-- add len_birth_imp varchar(10)
-- go 

-- alter table kidtrak
-- add cc_birth_imp varchar(10)
-- go 

-- alter table kidtrak
-- add hc_birth_imp varchar(10)
-- go 

-- alter table kidtrak
-- add muac_birth_imp varchar(10)
-- go 

-- alter table kidtrak
-- add wt_birth_imp_cat integer null 
-- go 

-- alter table kidtrak
-- add wt_birth_imp decimal(10,2) null 
-- go 

-- alter table kidtrak 
-- add sga_centile varchar(30)
-- go

-- alter table kidtrak 
-- add sga_10  varchar(30)
-- go

-- alter table kidtrak 
-- add sga_3  varchar(30)
-- go

-- alter table kidtrak 
-- add wazig_birth  varchar(30)
-- go

-- alter table kidtrak 
-- add lazig_birth  varchar(30)
-- go

-- alter table kidtrak 
-- add wlzig_birth  varchar(30)
-- go

-- alter table kidtrak 
-- add waz1  varchar(30)
-- go

-- alter table kidtrak 
-- add laz1  varchar(30)
-- go

-- alter table kidtrak 
-- add wlz1  varchar(30)
-- go

-- alter table kidtrak 
-- add hcz1  varchar(30)
-- go

-- alter table kidtrak 
-- add hczig_birth  varchar(30)
-- go

-- alter table kidtrak 
-- add wapig_birth  varchar(30)
-- go

-- alter table kidtrak 
-- add lapig_birth  varchar(30)
-- go

-- alter table kidtrak 
-- add hcpig_birth  varchar(30)
-- go




alter table kidtrak
add i3status varchar(10)
go

alter table kidtrak
add wt3 varchar(10)
go

alter table kidtrak
add len3 varchar(10)
go

alter table kidtrak
add muac3 varchar(10)
go

alter table kidtrak
add hc3 varchar(10)
go

alter table kidtrak
add cc3 varchar(10)
go



alter table kidtrak
add i6status varchar(10)
go

alter table kidtrak
add wt6 varchar(10)
go

alter table kidtrak
add len6 varchar(10)
go

alter table kidtrak
add muac6 varchar(10)
go

alter table kidtrak
add hc6 varchar(10)
go

alter table kidtrak
add cc6 varchar(10)
go



update kidtrak 
set 
--dob_dt = i.dob_dt,
wt_birth = case when i.wt_birth is null then null else  i.wt_birth end,
len_birth = case when i.len_birth is null then null else  i.len_birth end,
muac_birth = case when i.muac_birth is null then null else  i.muac_birth end,
hc_birth = case when i.hc_birth is null then null else  i.hc_birth end,
cc_birth = case when i.cc_birth is null then null else  i.cc_birth end,
-- aged_ibaf = case when i.aged_ibaf ='' then null else  i.aged_ibaf end,
-- aged_fbaf = case when i.aged_fbaf ='' then null else  i.aged_fbaf end,
-- aged_birth = case when i.aged_birth ='' then null else  i.aged_birth end,
-- i1date = case when i.i1date ='' then null else  i.i1date end,
i1status = case when i.i1status ='' then null else  i.i1status end,
wt1 = case when i.wt1 is null then null else  i.wt1 end,
len1 = case when i.len1 is null then null else  i.len1 end,
muac1 = case when i.muac1 is null then null else  i.muac1 end,
hc1 = case when i.hc1 is null then null else  i.hc1 end,
cc1 = case when i.cc1 is null then null else  i.cc1 end,
i3status = case when i.i3status ='' then null else  i.i3status end,
wt3 = case when i.wt3 is null then null else  i.wt3 end,
len3 = case when i.len3 is null then null else  i.len3 end,
muac3 = case when i.muac3 is null then null else  i.muac3 end,
hc3 = case when i.hc3 is null then null else  i.hc3 end,
cc3 = case when i.cc3 is null then null else  i.cc3 end,
i6status = case when i.i6status ='' then null else  i.i6status end,
wt6 = case when i.wt6 is null then null else  i.wt6 end,
len6 = case when i.len6 is null then null else  i.len6 end,
muac6 = case when i.muac6 is null then null else  i.muac6 end,
hc6 = case when i.hc6 is null then null else  i.hc6 end,
cc6 = case when i.cc6 is null then null else  i.cc6 end--,
-- aged1 = case when i.aged1 ='' then null else  i.aged1 end,
-- agem1 = case when i.agem1 ='' then null else  i.agem1 end
from kidtrak k
left join ianthro_prep i on i.childuid = k.childuid 


-- lee wants me to update the aged vars 

-- update kidtrak 
-- set aged_ibaf = null, 
-- aged_fbaf = null, 
-- aged_birth = null, 
-- i1date = null

go 

alter table kidtrak
add i1date_2 date
go

alter table kidtrak
add aged_ibaf_2 varchar(10)
go

alter table kidtrak
add aged_fbaf_2 varchar(10)
go

alter table kidtrak
add aged_birth_2 decimal(10,1)
go


alter table kidtrak
add aged1_2 varchar(10)
go

alter table kidtrak
add agem1_2 decimal(10,1)
go



alter table kidtrak
add i3date_2 date
go

alter table kidtrak
add aged3_2 varchar(10)
go

alter table kidtrak
add agem3_2 decimal(10,1)
go



alter table kidtrak
add i6date_2 date
go

alter table kidtrak
add aged6_2 varchar(10)
go

alter table kidtrak
add agem6_2 decimal(10,1)
go



update kidtrak 
set i1date_2 = convert(date,i.i1date,121)
from kidtrak k 
left join i1mop_mv i on i.childuid = k.childuid 
where i.childuid is not null 
go 

update kidtrak 
set aged_ibaf_2 = datediff(day,k.bgdob,convert(date,ibdate,121))
from kidtrak k 
left join ibaf_mv i on i.childuid = k.childuid 
where i.childuid is not null 
go 

update kidtrak 
set aged_fbaf_2 = datediff(day,k.bgdob,convert(date,fbdate))
from kidtrak k 
left join fbaf_mv f on f.childuid = k.childuid 
where f.childuid is not null 
go 

update kidtrak 
set aged_birth_2 = agehrsanth / cast(24.0 as decimal(10,1))
from kidtrak k 
go 

update kidtrak 
set aged1_2 = datediff(day,k.bgdob,convert(date,i1.i1date))
from kidtrak k 
left join i1mop_mv i1 on i1.childuid = k.childuid 
where i1.childuid is not null 
go 

update kidtrak 
set agem1_2 = aged1_2 / cast(30.0 as decimal(10,1))
from kidtrak k 
go 


update kidtrak 
set i3date_2 = convert(date,i.i3date,121)
from kidtrak k 
left join i36mop_mv i on i.childuid = k.childuid 
where i.childuid is not null 
go 


update kidtrak 
set aged3_2 = datediff(day,k.bgdob,convert(date,i3.i3date))
from kidtrak k 
left join i36mop_mv i3 on i3.childuid = k.childuid 
where i3.childuid is not null 
go 

update kidtrak 
set agem3_2 = aged3_2 / cast(30.0 as decimal(10,1))
from kidtrak k 
go 



update kidtrak 
set i6date_2 = convert(date,i.i6date,121)
from kidtrak k 
left join i69mop_mv i on i.childuid = k.childuid 
where i.childuid is not null 
go 


update kidtrak 
set aged6_2 = datediff(day,k.bgdob,convert(date,i6.i6date))
from kidtrak k 
left join i69mop_mv i6 on i6.childuid = k.childuid 
where i6.childuid is not null 
go 

update kidtrak 
set agem6_2 = aged6_2 / cast(30.0 as decimal(10,1))
from kidtrak k 
go 





-- update kidtrak 
-- set 
-- len_birth_imp = case when i.len_birth_imp_mean = '' then null else i.len_birth_imp_mean end ,
-- cc_birth_imp = case when i.cc_birth_imp_mean = '' then null else i.cc_birth_imp_mean end ,
-- hc_birth_imp = case when i.hc_birth_imp_mean = '' then null else i.hc_birth_imp_mean end ,
-- muac_birth_imp = case when i.muac_birth_imp_mean = '' then null else i.muac_birth_imp_mean end
-- from kidtrak k 
-- left join mean_impute_total_20250513 i on i.childuid = k.childuid 


-- print' Adding the imputed birthweight calculations from Sujan'
-- update kidtrak 
-- set wt_birth_imp_cat = 
-- case when anth_cat = '1. within 72 hours' then 1 
-- when anth_cat = '2. 72 hours- <10 days' then 2 
-- else 3 end ,
-- wt_birth_imp = bw_composite
-- from kidtrak k 
-- left join all_birth_weights_20250521 a on a.ch_id = k.childuid 
-- go 



-- print 'Adding the percentiles and z-scores from yunhee'

-- update kidtrak 
-- set 
-- sga_centile = case when pt.sga_centile = '' then null else pt.sga_centile end,
-- sga_10 = case when pt.sga_10 = '' then null else pt.sga_10 end,
-- sga_3 = case when pt.sga_3 = '' then null else pt.sga_3 end,
-- wazig_birth = case when pt.wazig_birth = '' then null else pt.wazig_birth end,
-- lazig_birth = case when pt.lazig_birth = '' then null else pt.lazig_birth end,
-- wlzig_birth = case when pt.wlzig_birth = '' then null else pt.wlzig_birth end,
-- -- waz1 = case when pt.waz1 = '' then null else pt.waz1 end,
-- -- laz1 = case when pt.laz1 = '' then null else pt.laz1 end,
-- -- wlz1 = case when pt.wlz1 = '' then null else pt.wlz1 end,
-- -- hcz1 = case when pt.hcz1 = '' then null else pt.hcz1 end,
-- hczig_birth = case when pt.hczig_birth = '' then null else pt.hczig_birth end,
-- wapig_birth = case when pt.wapig_birth = '' then null else pt.wapig_birth end,
-- lapig_birth = case when pt.lapig_birth = '' then null else pt.lapig_birth end,
-- hcpig_birth = case when pt.hcpig_birth = '' then null else pt.hcpig_birth end
-- from kidtrak k 
-- left join birth_1mo_size_d_index_20250522 pt on pt.childuid = k.childuid 


-- -- update updated 1 month z scores
-- update kidtrak
-- set 
-- waz1 = case when pt.waz1 = '' then null else pt.waz1 end,
-- laz1 = case when pt.laz1 = '' then null else pt.laz1 end,
-- wlz1 = case when pt.wlz1 = '' then null else pt.wlz1 end,
-- hcz1 = case when pt.hcz1 = '' then null else pt.hcz1 end
-- from kidtrak k 
-- left join [z-score at 1mo_20250602] pt on pt.childuid = k.childuid 



-- aged_ibaf,
-- aged_fbaf,
-- aged_birth,
-- i1date,
-- aged1,
-- agem1,





-- -- 21 Adding a code for missing BAF due to COVID time
-- alter table kidtrak
-- add bafmiscovid  int
-- go
-- print '21 Get BAF missing code due to COVID'
-- update kidtrak
-- set bafmiscovid = 1
-- --select kt.childuid,kt.momuid,wt.uid,pv.uid,bd.momuid
-- from kidtrak kt
-- join wtrak wt on kt.momuid=wt.uid
-- left join mcare2.dbo.ALLPVF pv on pv.uid = wt.uid
-- left join ibaf_mv  bd on bd.momuid = wt.uid
-- where OUTC_2 in('05','07','08','10','11','12','14')
-- and FDBNFSTS='3'
-- and FDBNFDATE >=cast('2020-03-23' as date)
-- and bd.momuid is null
-- go


-- end--
print 'Finished making KIDTRAK'
go


if exists(SELECT * FROM sysobjects o WHERE name = 'kidtrak_t2' )
Begin 
    drop table kidtrak_t2
End 

-- select c.name+',' from syscolumns c 
-- join sysobjects o on o.id =c.id 
-- where o.name = 'kidtrak' 
-- order by c.colid

select 
childuid,
k.momuid as uid,
w.tlpin as tlpin, 
w.sector as sector,
w.hhid,
k.arm,
k.pe_consent,
--k.hhid,
sexcd as sex,
k.bgga as bggawk,
/*k.bnf_date,*/
/*sexsrc,*/
k.BGdob as dob,
tob,
sibling,
twin as sibling_twin,
agehrsanth,
agefd_anthro,
anthro_date,
anthro_location,
anthro72,
bgdod as dod,
tod,
todsrc,
deadaged,
bgdodru as dodru,
--dob_dt,
wt_birth,
len_birth,
muac_birth,
hc_birth,
cc_birth,
aged_ibaf_2 as aged_ibaf,
aged_fbaf_2 as aged_fbaf,
aged_birth_2 as aged_birth,
i1date_2 as i1date,
i1status,
wt1,
len1,
muac1,
hc1,
cc1,
aged1_2 as aged1,
agem1_2 as agem1,
i3date_2 as i3date,
i3status,
wt3,
len3,
muac3,
hc3,
cc3,
aged3_2 as aged3,
agem3_2 as agem3,
i6date_2 as i6date,
i6status,
wt6,
len6,
muac6,
hc6,
cc6,
aged6_2 as aged6,
agem6_2 as agem6,
censrvital,
/*censrwk,*/
/*censrru,*/
censrdate,
censraged,
/*preterm,*/
/*CDOBDay,*/
/*CDOBMonth,*/
/*CDOBYear,*/
/*bgdobsrc as dobsource,*/
/*BGwob,*/
/*bgdobru,*/
/*bgdobsrc,*/
/*AgehrsAnth,*/
/*AgeAnthru,*/

/*len_birth_imp,*/
/*cc_birth_imp,*/
/*hc_birth_imp,*/
/*muac_birth_imp,*/
/*wt_birth_imp_cat,*/
/*wt_birth_imp,*/
/*sga_centile,*/
/*sga_10,*/
/*sga_3,*/
/*wazig_birth,*/
/*lazig_birth,*/
/*wlzig_birth,*/
/*waz1,*/
/*laz1,*/
/*wlz1,*/
/*hcz1,*/
/*hczig_birth,*/
/*wapig_birth, -- removed based on Discussion on 6/4 regarding centiles*/
/*lapig_birth,*/
/*hcpig_birth,*/
vstatus,
null as vstatus_date
/*VSSrc,*/
/*bgwod,*/
/*deathdd,*/
/*deathmm,*/
/*deathyy,*/
/*bgdodru,*/
/*DeadAgeD,*/
/*sibling,*/
/*twin,*/
/*ibafwk,*/
/*ibafrd,*/
/*ibaf_status,*/
/*fbafwk,*/
/*fbafrd,*/
/*fbaf_status,*/
/*i1mopwk,*/
/*i1moprd,*/
/*i1mop_status,*/
/*Agedayi1mop,*/
/*Agedayi1mopru,*/
into kidtrak_t2
from [mindr-live].dbo.kidtrak k
left join [mindr-live].dbo.pregtrak w on w.uid =k.momuid



print 'making a copy of the do file in the DB'
go


-- if exists(SELECT * FROM sysobjects o WHERE name = 'kidtrak_do' )
-- Begin 
--     drop table kidtrak_do
-- End 

-- select 
-- childuid,
-- uid,
-- tlpin,
-- sector,
-- hhid,
-- pe_consent,
-- arm,
-- sex,
-- bggady,
-- bggawk,
-- dob,
-- tob,
-- sibling,
-- sibling_twin,
-- agehrsanth,
-- agefd_anthro,
-- anthro_date,
-- anthro_location,
-- anthro72,
-- dod,
-- tod,
-- todsrc,
-- deadaged,
-- dodru,
-- censrvital,
-- censrdate,
-- censraged,
-- aged_ibaf,
-- aged_fbaf,
-- aged_birth,
-- wt_birth,
-- len_birth,
-- muac_birth,
-- hc_birth,
-- cc_birth,
-- wazig_birth,
-- lazig_birth,
-- hczig_birth,
-- wlzig_birth,
-- lapig_birth,
-- hcpig_birth,
-- sga_3,
-- sga_10,
-- sga_centile,
-- i1date,
-- i1status,
-- aged1,
-- agem1,
-- wt1,
-- len1,
-- muac1,
-- hc1,
-- cc1,
-- waz1,
-- laz1,
-- wlz1,
-- hcz1,
-- len_birth_imp,
-- cc_birth_imp,
-- hc_birth_imp,
-- muac_birth_imp,
-- wt_birth_imp_cat,
-- wt_birth_imp
-- into kidtrak_do
-- from [mindr-live].dbo.kidtrak_t2

