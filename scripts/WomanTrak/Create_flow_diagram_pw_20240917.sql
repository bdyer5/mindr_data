use [mindr-live]
go

print 'count of women available for PW trial'
select count(*) from woman_pw 
--4001
-- all except 691 have been transferred to the psf cohort 

-- in creating a woman trak 
-- From Kerry 6/25/2024 11:26 am Subject:"RE: transmittal list" GA at screening and then GA at the enrollment week visits—and sometimes that was spread out over time. It might be good to have both of those, but GA at the time of the enrollment visits would be the priority.

print 'eligibility groups in PW for consent - https://mjivita.org:8443/mindr/#/flowchart'

select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feedting 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='0' -- not using family planning method 
-- n = 420 

select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feedting 
and wewant6m in ('1','9') -- planning a pregnancy 
and wefpm='0' -- not using family planning method 
-- n = 719


select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feedting 
and wewant6m in ('1','9') -- planning a pregnancy 
and wefpm='1' -- not using family planning method 
and wefpt in ('1','5','6','8')
-- n = 69


select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feedting 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='0' -- not using family planning method 
-- n = 165


select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feeding 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='1' -- using family planning method 
and wefpt in ('1','5','6','8')
-- n = 822


select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feeding 
and wewant6m='1' -- planning a pregnancy 
and wefpm='0' -- not using family planning method 
-- n = 36



select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feeding 
and wewant6m='1' -- planning a pregnancy 
and wefpm='1' -- using family planning method - temp
and wefpt in ('1','5','6','8')
-- n = 12



select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feeding 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='1' -- using family planning method 
and wefpt in ('1','5','6','8')
-- n = 1743


select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feeding 
and wewant6m='1' -- planning a pregnancy 
and wefpm='1' -- using family planning method - more permanent
and wefpt in ('2','3','4','7')
-- n = 30 



print' now of these - the ones that consented' 
select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feedting 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='0' -- not using family planning method 
and wef_pw_consent =1 -- is not null 
-- n=410 


select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feedting 
and wewant6m in ('1','9') -- planning a pregnancy 
and wefpm='0' -- not using family planning method 
and wef_pw_consent =1 -- is not null 
-- n = 718


select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feedting 
and wewant6m in ('1','9') -- planning a pregnancy 
and wefpm='1' -- not using family planning method 
and wefpt in ('1','5','6','8')
and wef_pw_consent =1 
-- n = 69


select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feedting 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='0' -- not using family planning method 
and wef_pw_consent =1 
-- n = 164


select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feeding 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='1' -- using family planning method 
and wefpt in ('1','5','6','8')
and wef_pw_consent =1 
-- n = 821



select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feeding 
and wewant6m='1' -- planning a pregnancy 
and wefpm='0' -- not using family planning method 
and wef_pw_consent =1 
-- n = 36

select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feeding 
and wewant6m='1' -- planning a pregnancy 
and wefpm='1' -- using family planning method - temp
and wefpt in ('1','5','6','8')
and wef_pw_consent =1 
-- n = 12

-- Nov 21st 2023 - Meeting 
-- DMC to move #2 category (n=1582) from the WRA eligibility list 
-- (not breastfeeding, not planning pregnancy, using temporary FP method)
-- to the PSF immediately. Not necessary to re-do the WEF with them. 

select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feeding 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='1' -- using family planning method 
and wefpt in ('1','5','6','8')
-- n = 1743


select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feeding 
and wewant6m='1' -- planning a pregnancy 
and wefpm='1' -- using family planning method - more permanent
and wefpt in ('2','3','4','7')
-- n = 30 

print 'flow diagram -- crosscheck enrollment - creating bd_wom_pw table ' 



if exists(select o.name from sysobjects o where o.name='bd_wom_pw')
begin 
drop table bd_wom_pw 
end 
go 


select distinct uid 
into bd_wom_pw
from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feedting 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='0' -- not using family planning method 
and wef_pw_consent =1 -- is not null 
-- n=410 
union 

select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feedting 
and wewant6m in ('1','9') -- planning a pregnancy 
and wefpm='0' -- not using family planning method 
and wef_pw_consent =1 -- is not null 
-- n = 718
union 

select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feedting 
and wewant6m in ('1','9') -- planning a pregnancy 
and wefpm='1' -- not using family planning method 
and wefpt in ('1','5','6','8')
and wef_pw_consent =1 
-- n = 69
union 

select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feedting 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='0' -- not using family planning method 
and wef_pw_consent =1 
-- n = 164
union 

select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feeding 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='1' -- using family planning method 
and wefpt in ('1','5','6','8')
and wef_pw_consent =1 
-- n = 821
union 


select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feeding 
and wewant6m in ('1','9')  -- planning a pregnancy 
and wefpm='0' -- not using family planning method 
and wef_pw_consent =1 
-- n = 36
union 
select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='1' -- currently breast feeding 
and wewant6m in ('1','9')  -- planning a pregnancy 
and wefpm='1' -- using family planning method - temp
and wefpt in ('1','5','6','8')
and wef_pw_consent =1 
-- n = 12
union
-- Nov 21st 2023 - Meeting 
-- DMC to move #2 category (n=1582) from the WRA eligibility list 
-- (not breastfeeding, not planning pregnancy, using temporary FP method)
-- to the PSF immediately. Not necessary to re-do the WEF with them. 

select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feeding 
and wewant6m='0' -- not planning a pregnancy 
and wefpm='1' -- using family planning method 
and wefpt in ('1','5','6','8')
-- n = 1743

union
select distinct uid from wef_nwef_mv_prep 
where westatus =1 --and wef_consent=1 
and 
wecurbfd='0' -- not currently breast feeding 
and wewant6m in ('1','9')  -- planning a pregnancy 
and wefpm='1' -- using family planning method - more permanent
and wefpt in ('2','3','4','7')
-- n = 30 



print ' start flow diagram ' 

if exists(select o.name from sysobjects o where o.name ='wtrak_pw_prep' )
Begin 
drop table wtrak_pw_prep
End 



select * 
into wtrak_pw_prep 
from woman_pw

update wtrak_pw_prep
set woman_status = 8
where uid in 
('486871','815920') 
-- These 2 women are duplicate women. They were identified after the freeze of the data but reza has the count of women at 3999 
-- and not 3991 as the flow diagram had indicated- reza said that this number was hard coded . 


select c.name from syscolumns c 
join  sysobjects o on o.id = c.id 
where o.name =  'wtrak_pw_prep'
order by c.colid 



alter table bd_wom_pw
add peconsent int null 

alter table bd_wom_pw
add pedate smalldatetime null 

if exists(select c.name from syscolumns c join sysobjects o on c.id =o.id where c.name ='peconsent' and o.name ='wtrak_pw_prep' )
Begin 
alter table wtrak_pw_prep
drop column peconsent
End 

if exists(select c.name from syscolumns c join sysobjects o on c.id =o.id where c.name ='pedate' and o.name ='wtrak_pw_prep' )
Begin 
alter table wtrak_pw_prep
drop column pedate
End 

alter table wtrak_pw_prep
add pefstatus int null 

alter table wtrak_pw_prep
add peconsent int null 

alter table wtrak_pw_prep
add pedate smalldatetime null 

alter table wtrak_pw_prep
add psfstatus int null 

alter table wtrak_pw_prep
add psf_date smalldatetime null 

alter table wtrak_pw_prep
add last_psf_status int null 

alter table wtrak_pw_prep
add last_psf_date smalldatetime null 
go 

alter table wtrak_pw_prep
add psfurt int null 

alter table wtrak_pw_prep
add psfurt_date smalldatetime null 
go 

alter table wtrak_pw_prep
add psflmp smalldatetime null 
go 

alter table wtrak_pw_prep
add ga_at_psfurt decimal(10,1) null 
go 

alter table wtrak_pw_prep
add pef_eligible int null
go 

alter table wtrak_pw_prep
add safstatus int null
go 

alter table wtrak_pw_prep
add safdate smalldatetime null
go 

alter table wtrak_pw_prep
add last_safstatus int null
go 

alter table wtrak_pw_prep
add last_safdate smalldatetime null
go 

alter table wtrak_pw_prep
add supp_status int null 
go 

alter table wtrak_pw_prep
add saf_flow_status int null 
go 

alter table wtrak_pw_prep
add bnfstatus int null
go 

alter table wtrak_pw_prep
add bnfdate smalldatetime null
go 

alter table wtrak_pw_prep
add chld1vitsts int null
go 

alter table wtrak_pw_prep
add chld2vitsts int null
go 

alter table wtrak_pw_prep
add chld3vitsts int null
go 

alter table wtrak_pw_prep
add mbafstatus int null
go 

alter table wtrak_pw_prep
add mbafdate smalldatetime null
go 

alter table wtrak_pw_prep
add lpfstatus int null
go 

alter table wtrak_pw_prep
add lpfdate smalldatetime null
go 


alter table wtrak_pw_prep
add bgoutc char(2)
go 

alter table wtrak_pw_prep
add bgoutcru integer
go 

alter table wtrak_pw_prep
add bgoutcsrc varchar(20)
go 

alter table wtrak_pw_prep
add bgwoutc integer
go 

alter table wtrak_pw_prep
add bgdoutc smalldatetime
go 

alter table wtrak_pw_prep
add bgdoutcru integer
go 


print ' Adding of variable names starts here '
print ' ... after the existing variables in the woman table '

alter table wtrak_pw_prep 
add dobyy char(4)
go 

alter table wtrak_pw_prep 
add dobdd char(2)
go 

alter table wtrak_pw_prep 
add dobmm char(2)
go 

alter table wtrak_pw_prep 
add bgdob smalldatetime
go 

alter table wtrak_pw_prep 
add fdose_date smalldatetime
go 

alter table wtrak_pw_prep 
add edose_date smalldatetime
go 


alter table wtrak_pw_prep 
add totdose_days decimal(10,2)
go 

alter table wtrak_pw_prep 
add totdose_mns decimal(10,2)
go 

alter table wtrak_pw_prep 
add totdose_bep decimal(10,2)
go 

alter table wtrak_pw_prep 
add pcomp_mns decimal(10,2)
go 

alter table wtrak_pw_prep 
add pcomp_bep decimal(10,2)
go 


alter table wtrak_pw_prep 
add uvf_ga_bd decimal(10,2)
go 

alter table wtrak_pw_prep 
add crl_median decimal(10,4)
go 




print 'update dob values from person table and nwef and clean up the month and days'
update wtrak_pw_prep 
set dobyy = case when isdate(nw.nwedobdate) =1  then substring(convert(nvarchar,nw.nwedobdate,121),1,4) when nw.nwedobyy !=9999 and nw.nwedobyy is not null then nw.nwedobyy when trim(p.dobyy)='' or trim(p.dobyy)='9999' then null else p.dobyy end, 
dobmm = case when nw.nwedobmm !=99 and nw.nwedobmm is not null then nw.nwedobmm when trim(p.dobmm)='' or trim(p.dobmm)='99' or trim(p.dobmm)='00' or trim(p.dobmm)='$$' then null else p.dobmm end ,
dobdd = case when trim(nw.nwedobdd) !='99' and nw.nwedobdd is not null then nw.nwedobdd when trim(p.dobdd)='' or trim(p.dobdd)='99' or trim(p.dobdd)='00' or trim(p.dobdd)='$$' then null else p.dobdd end 
from wtrak_pw_prep w
left join shapla.dbo.person p on p.uid = w.uid 
left join [mindr-live].dbo.nwef_mv_prep nw on nw.uid =w.uid



update wtrak_pw_prep 
set dobmm = case when dobmm is null then '06' else dobmm end 
,dobdd= case when dobdd is null then '15' else dobdd end 
from wtrak_pw_prep w

update wtrak_pw_prep 
set bgdob = convert(smalldatetime, dobyy+'-'+dobmm+'-'+dobdd)


update bd_wom_pw 
set peconsent = pe.pe_consent,
pedate = pe.pedate
from bd_wom_pw pw 
left join pef_mv pe on pw.uid = pe.uid 



update wtrak_pw_prep 
set peconsent = pe.pe_consent,
pefstatus = pe.pestatus,
pedate = pe.pedate
from wtrak_pw_prep pw 
left join pef_mv pe on pw.uid = pe.uid 


update wtrak_pw_prep 
set psfstatus = ps.psstatus,
psf_date = ps.psfdate
from wtrak_pw_prep pw 
left join psf_mv ps on pw.uid = ps.uid 



update wtrak_pw_prep 
set psfstatus = a.psstatus
from wtrak_pw_prep  w 
left join 
(select uid, min(psstatus) as psstatus from psf_mv
where psstatus not in (7,8) 
group by uid) a on a.uid =w.uid 


update wtrak_pw_prep 
--select 
set psfstatus = p.psstatus
from wtrak_pw_prep  w 
left join psf_mv p on p.uid = w.uid 
where p.psstatus ='7'


update wtrak_pw_prep 
--select 
set psfstatus = p.psstatus
from wtrak_pw_prep  w 
left join psf_mv p on p.uid = w.uid 
where p.psstatus ='8'



update wtrak_pw_prep
set last_psf_status = ps.psstatus, 
last_psf_date = ps.psfdate
from wtrak_pw_prep w 
left join (
select p.uid, psstatus,psfdate from psf_mv p 
join ( select uid , max(_submission_time) as _submission_time from psf_mv
where duplicate is null
group by uid ) a on a.uid = p.uid and p._submission_time = a._submission_time
) ps on ps.uid = w.uid 


update wtrak_pw_prep
set 
--select 
psfurt_date = psfdate,
psflmp = case when isdate(ps.pslmp) =1 then convert(smalldatetime, ps.pslmp,121) else null end,
psfurt= 1
from wtrak_pw_prep w join
--  Pregnant women and their lmp date 
(select p.uid uid 
,psfdate
,pslmp
,psurt 
,pp.[_id] 
,p.[source]
from psf_mv p 
inner join (select distinct(_id) from psf_mv where psurt ='1' ) pp on pp._id = p._id 
where p.uid is  not null ) ps on ps.uid = w.uid 


update wtrak_pw_prep
set safstatus = cast(saf.sastatus as int)
from wtrak_pw_prep wt
left join 
(select uid , min(sastatus)  sastatus from safpw_mv
group by uid) saf on saf.uid = wt.uid 

print ' getting min date where menstrula regulation occured'
update wtrak_pw_prep
set safdate = a.sadate
from wtrak_pw_prep wtp
left join (select wt.uid,  min(sadate) as sadate, 
min(sastatus) sastatus -- saf.sastatus
from safpw_mv s
right join wtrak_pw_prep wt on wt.uid = s.uid 
where s.sastatus = wt.safstatus 
and wt.safstatus is not null 
group by wt.uid ) a on a.uid = wtp.uid 





-- update wtrak_pw_prep
-- set safstatus2 = cast(saf.sastatus as int)
-- from wtrak_pw_prep wt
-- left join 
-- (select uid , min(sastatus)  sastatus from safpw_mv
-- group by uid) saf on saf.uid = wt.uid 

update wtrak_pw_prep
set last_safstatus = cast(saf.sastatus as int),
last_safdate = convert(smalldatetime,saf.sadate,121)
from wtrak_pw_prep wt
left join 
safpw_mv saf on saf.uid = wt.uid 
right join (select uid , max(_submission_time)  _submission_time from safpw_mv
group by uid) a on saf._submission_time = a._submission_time and a.uid=saf.uid

-- had a miscarriage 
update wtrak_pw_prep
set safstatus = saf.sastatus
from wtrak_pw_prep wt
left join 
 safpw_mv saf on saf.uid = wt.uid 
 where saf.sastatus = 4

-- date where misscarriage occurred
print ' getting min date where miscarriage occurred'
update wtrak_pw_prep
set safdate = a.sadate
from wtrak_pw_prep wtp
right join (select wt.uid,  min(sadate) as sadate, 
min(sastatus) sastatus -- saf.sastatus
from safpw_mv s
right join wtrak_pw_prep wt on wt.uid = s.uid 
where s.sastatus = wt.safstatus 
and wt.safstatus =4 
group by wt.uid ) a on a.uid = wtp.uid 


-- MR
update wtrak_pw_prep
set safstatus = saf.sastatus
from wtrak_pw_prep wt
left join 
 safpw_mv saf on saf.uid = wt.uid 
 where saf.sastatus = 5

print ' getting min date where menstrula regulation occured'
update wtrak_pw_prep
set safdate = a.sadate
from wtrak_pw_prep wtp
left join (select wt.uid,  min(sadate) as sadate, 
min(sastatus) sastatus -- saf.sastatus
from safpw_mv s
right join wtrak_pw_prep wt on wt.uid = s.uid 
where s.sastatus = wt.safstatus 
and wt.safstatus =5
group by wt.uid ) a on a.uid = wtp.uid 



-- had a live birth 
update wtrak_pw_prep
set safstatus = saf.sastatus
from wtrak_pw_prep wt
left join 
 safpw_mv saf on saf.uid = wt.uid 
 where saf.sastatus = 6

print ' getting min date where live birth occured'
update wtrak_pw_prep
set safdate = a.sadate
from wtrak_pw_prep wtp
right join (select wt.uid,  min(sadate) as sadate, 
min(sastatus) sastatus -- saf.sastatus
from safpw_mv s
right join wtrak_pw_prep wt on wt.uid = s.uid 
where s.sastatus = wt.safstatus 
and wt.safstatus =6
group by wt.uid ) a on a.uid = wtp.uid 


-- had a still birth
update wtrak_pw_prep
set safstatus = saf.sastatus
from wtrak_pw_prep wt
left join 
 safpw_mv saf on saf.uid = wt.uid 
 where saf.sastatus = 7


print ' getting min date where still birth occured'
update wtrak_pw_prep
set safdate = a.sadate
from wtrak_pw_prep wtp
right join (select wt.uid,  min(sadate) as sadate, 
min(sastatus) sastatus -- saf.sastatus
from safpw_mv s
right join wtrak_pw_prep wt on wt.uid = s.uid 
where s.sastatus = wt.safstatus 
and wt.safstatus =7
group by wt.uid ) a on a.uid = wtp.uid 


-- refused the saf - but this shouldnt be a stop right ?
-- what did we do her ein the field
update wtrak_pw_prep
set safstatus = saf.sastatus
from wtrak_pw_prep wt
left join 
 safpw_mv saf on saf.uid = wt.uid 
 where saf.sastatus = 66 and (wt.safstatus is null or wt.safstatus = '02')

-- permanent move
update wtrak_pw_prep
set safstatus = saf.sastatus
from wtrak_pw_prep wt
left join 
 safpw_mv saf on saf.uid = wt.uid 
 where saf.sastatus = 77

--died 
update wtrak_pw_prep
set safstatus = saf.sastatus
from wtrak_pw_prep wt
left join 
 safpw_mv saf on saf.uid = wt.uid 
 where saf.sastatus = 88



-- select wt.allocated_arm,saf.sastatus, count(*)
-- from wtrak_wra wt
-- left join safpw_mv saf  on saf.uid = wt.uid 
-- right join 
-- (select uid , min(_submission_time)  _submission_time from safpw_mv
-- group by uid) a on a.uid = saf.uid and a._submission_time = saf._submission_time 
-- where wt.allocated_arm is not null
-- and wt.saf_done_date is not null
-- group by wt.allocated_arm, saf.sastatus 
-- with rollup 




-- MiNDR Meeting note from November 21st, 2023 note : "Parul clarified that we can go with the <17 week criteria for enrollment (based on LMP) for the remainder of the study".
-- https://docs.google.com/document/d/1zlFizXZlf_bodkQZ3ZxmbAXfMxS4teaZgP3E4sGjy5E/edit#heading=h.s94s0ti0zc9l

update wtrak_pw_prep
set ga_at_psfurt = cast(datediff(day,psflmp,psfurt_date) as decimal (4))/7.0
,pef_eligible = case when cast(datediff(day,psflmp,psfurt_date) as decimal (4))/7.0 >=17 then 0 else 1 end
from wtrak_pw_prep 
where psfurt = 1 



update wtrak_pw_prep 
set supp_status = safstatus 
from wtrak_pw_prep 

-- filling in maybe some of the reasons why there wasn't 
-- any supplementation 
update wtrak_pw_prep 
set supp_status = 61
from wtrak_pw_prep pw
left join pw_log pl on pw.uid =pl.uid 
where DISCONTINUED ='1111111111' and DISCNTD_Source = 'USG>16GA'

update wtrak_pw_prep 
set supp_status = 62
from wtrak_pw_prep pw
left join pw_log pl on pw.uid =pl.uid 
where DISCONTINUED ='1111111111' and DISCNTD_Source = 'PX_Data_Baseline'


-- uvf status 
-- 3	Woman had MR
-- 4	Miscarriage
-- 6	Refused interview
-- 7	permanently moved 
-- 8	died 

-- woman had a MR 
update wtrak_pw_prep 
set supp_status = 63
from wtrak_pw_prep pw
where uvf_status ='3' and supp_status is null 

--woman had miscarriage 
update wtrak_pw_prep 
set supp_status = 64
from wtrak_pw_prep pw
where uvf_status ='4' and supp_status is null 


-- Note this is not a hard stop here  refusal of uvf 
update wtrak_pw_prep 
set supp_status = 65
from wtrak_pw_prep pw
where uvf_status ='6' and supp_status is null 

-- permanent move 
update wtrak_pw_prep 
set supp_status = 67
from wtrak_pw_prep pw
where uvf_status ='7' and supp_status is null 

-- died 
update wtrak_pw_prep 
set supp_status = 68
from wtrak_pw_prep pw
where uvf_status ='8' and supp_status is null 



print 'update only the status for what happens before MPF for the flow diagram'
print 'finding the min value for this range'
update wtrak_pw_prep 
set saf_flow_status = saf.min_sastatus
from wtrak_pw_prep pw
left join (select s.uid,min(sastatus) as min_sastatus from safpw_mv s left join wtrak_pw_prep p on p.uid =s.uid and s.sadate <p.mpf_done_date group by s.uid 
) saf on saf.uid  = pw.uid 


print 'finding the max value for this range for stop reasons '
update wtrak_pw_prep 
set saf_flow_status = saf.max_sastatus
from wtrak_pw_prep pw
right join (select s.uid,max(sastatus) max_sastatus from safpw_mv s left join wtrak_pw_prep p on p.uid =s.uid and s.sadate <p.mpf_done_date 
where pef_consent=1 and s.sastatus in ('04','05','06','07','77','88')
group by s.uid 
) saf on saf.uid  = pw.uid 


update wtrak_pw_prep 
set saf_flow_status = supp_status
from wtrak_pw_prep pw
where supp_status >59 
and supp_status not in ('66','77','88') -- already pulled these in where they saf was before MPF 


update wtrak_pw_prep 
set 
bnfdate = b.bnfdate,
chld1vitsts = b.bnfchldvitsts1,
chld2vitsts = b.bnfchldvitsts2,
chld3vitsts = b.bnfchldvitsts3
from wtrak_pw_prep pw
left join bnf_mv b on b.uid = pw.uid 



update wtrak_pw_prep 
set mbafstatus = mb.mbstatus,
mbafdate = mb.mbdate from 
wtrak_pw_prep pw
left join mbaf_mv mb on mb.uid = pw.uid 
and mb.mbstatus is not null 

update wtrak_pw_prep 
set
--select 
lpfstatus = lp.lpstatus,
lpfdate = lp.lpdate 
from wtrak_pw_prep pw
left join lpf_mv lp on lp.uid = pw.uid 
where pw.pef_consent=1
and lp.lpstatus is not null


-- Outc codes from J5 
-- 00=No outcome reported 
-- 01=Mom died, no other outcome reported (
-- 02=Miscarriage (if bgga < 24  and >0 or mthspr <6)
-- 03=Induced abortion(MSBF howend = 1)
-- 04=4 on PDR or PEF, no other info 
-- 14 = PDR live birth, no other info

-- Singleton:
-- 05=1 live born 
-- 06=1 still born (event occurred >= 24 weeks) 

-- Twins:
-- 07=2 live born 
-- 08=1 live born, 1 still born 
-- 09=2 still born 

-- Triplets:
-- 10=3 live born 
-- 11=2 live born, 1 still born 
-- 12=1 live born, 2 still born 
-- 13=3 still born
-- 14 = PDR live birth, no other info

-- SAF status 
-- 01	Met
-- 02	Not met
-- 03	Met over phone
-- 04	Miscarriage
-- 05	MR
-- 06	Livebirth
-- 07	Still birth 
-- 08	Not observed due to fasting
-- 66	Refused
-- 77	Permanently moved
-- 88	Died



update wtrak_pw_prep
set bgoutc = cast(bo.bgoutc as char) ,
bgoutcru = 1,
bgwoutc = bo.bgwoutc,
bgdoutc = bo.bgdoutc,
bgdoutcru = convert(integer,bo.bgdoutcru),
bgoutcsrc = bo.bgoutcsrc
from wtrak_pw_prep wt
join [mindr-live].dbo.bgdoutcview bo on bo.uid = wt.uid
where wt.pef_consent = '1'


print 'updating twin live births from ibaf'
update wtrak_pw_prep
set bgoutc = '07',
bgoutcsrc = 'ibaf - twin birth'
from wtrak_pw_prep wt
left join ibaf_mv iba on iba.uid =wt.uid 
join 
(select uid, count(*) cnt
from ibaf_mv 
where ibstatus=1 
group by uid
having count(*)>1 -- more than 1 child 
) ibb on iba.uid = ibb.uid 
where wt.bgoutc =5 
and wt.bgdoutc = iba.ibdob -- date of outcome and the outcome are the same 
and wt.bgoutcsrc = 'ibaf' -- and the source was the same 

print 'updating twin live births from fbaf'
update wtrak_pw_prep 
set bgoutc = '07', 
bgoutcsrc = 'fbaf - twin birth'
from wtrak_pw_prep wt
left join all_fbaf fba on fba.uid =wt.uid 
join 
(select uid, count(*) cnt
from all_fbaf 
where fbstatus=1 
group by uid
having count(*)>1 -- more than 1 child 
) fbb on fba.uid = fbb.uid 
where wt.bgoutc = 5 
and wt.bgdoutc = fba.fbdob
and bgoutcsrc = 'fbaf'


update wtrak_pw_prep 
set  bgoutc = '08' ,
bgoutcsrc='baf - bnf'
from wtrak_pw_prep wt 
left join bnf_mv  b on b.uid = wt.uid 
where wt.bgoutc =5
and b.bnfchldvitsts2 is not null 
and bnfchldvitsts1 = 1  and ( bnfchldvitsts2 = 2 -- had a still born child   
or bnfchldvitsts3 = 2)
and convert(date,bnfdtoo,121) = wt.bgdoutc 

print 'setting miscarriages from SAF to correct OUTC code'
update wtrak_pw_prep 
set  bgoutc = '02' 
from wtrak_pw_prep wt 
where wt.bgoutc =4
and wt.bgoutcsrc='saf'

print 'setting still births from SAF to correct OUTC code'
update wtrak_pw_prep 
set  bgoutc = '03' 
from wtrak_pw_prep wt 
where wt.bgoutc =5
and wt.bgoutcsrc='saf'

print 'setting live births from SAF to correct OUTC code'
update wtrak_pw_prep 
set  bgoutc = '05' 
from wtrak_pw_prep wt 
where wt.bgoutc =6
and wt.bgoutcsrc='saf'

print 'setting still births from SAF to correct OUTC code'
update wtrak_pw_prep 
set  bgoutc = '06'
from wtrak_pw_prep wt 
where wt.bgoutc =7
and wt.bgoutcsrc='saf'

print 'setting PM permanently moved to ''No outcome'' from SAF to correct OUTC code'
update wtrak_pw_prep 
set  bgoutc = '00' 
from wtrak_pw_prep wt 
where wt.bgoutc =77
and wt.bgoutcsrc='saf'

print 'setting died permanently ''mom died - no other outcome '' from SAF to correct OUTC code'
update wtrak_pw_prep 
set  bgoutc = '01'
from wtrak_pw_prep wt 
where wt.bgoutc =88
and wt.bgoutcsrc='saf'


print 'adding compliance fields from Sujan''s dta files '

-- update wtrak_pw_prep 
-- set fdose_date = c.fdose_date,
--       edose_date = c.edose_date,
--       totdose_days = c.totdose_days,
--       totdose_mns = c.totdose_mns,
--       totdose_bep = c.totdose_bep,
--       pcomp_mns = c.pcomp_mns,
--       pcomp_bep = c.pcomp_bep
-- from wtrak_pw_prep wt 
-- left join mindr_pw_compliance_20240828 c on c.uid = wt.uid 


--- add Brian's GA calc from USG 
update wtrak_pw_prep
set crl_median = ga.crl_median
, uvf_ga_bd = ga.uvf_ga_bd
from wtrak_pw_prep wt 
left join usggaview ga on ga.uid = wt.uid 
where ga.uid is not null 



-- 01	Met
-- 02	Not met
-- 03	Met over phone
-- 04	Miscarriage
-- 05	MR
-- 06	Livebirth
-- 07	Still birth 
-- 08	Not observed due to fasting
-- 66	Refused
-- 77	Permanently moved
-- 88	Died




-- select s.uid,min(sastatus) from safpw_mv s left join wtrak_pw_prep p on p.uid =s.uid and s.sadate <p.mpf_done_date group by s.uid 


-- select s.uid,max(sastatus) from safpw_mv s left join wtrak_pw_prep p on p.uid =s.uid and s.sadate <p.mpf_done_date 
-- where pef_consent=1 and s.sastatus in ('04','05','06','07','77','88')
-- group by s.uid 


print 'now put only the important variables in the wtrak_pw'

if exists(select o.name from sysobjects o where o.name ='wtrak_pw' )
Begin 
drop table wtrak_pw
End 





select 
uid,  /*keep*/
tlpin,
sector,
hhid,
woman_status,
age,  /*keep*/
age_grp,  /*keep*/
dobyy,
dobdd,
dobmm,
bgdob,
case when allocated_arm = 'A' then 'Y'
when allocated_arm = 'B' then 'W'
when allocated_arm = 'C' then 'Z'
when allocated_arm = 'D' then 'X' end as allocated_arm,  /*keep*/
bnf_done_date,
bnf_status,
dod,
pef_eligable,
pef_status,
pef_done_date,
pef_consent,   /*keep*/
pef_consent_date,  /*keep*/
pefb_done_date,   /*keep*/
pefb_status,   /*keep*/
pef_eligible,   /*keep -brian derived*/
pefstatus,  /*keep -brian derived*/
peconsent,  /*keep -brian derived*/
pedate, /*brian derived*/
psfstatus,  /*brian derived*/
psf_date,   /*brian derived*/
last_psf_status,    /*keep -brian derived*/
last_psf_date,  /*keep -brian derived*/
psfurt, /*keep -brian derived*/
psfurt_date,    /*keep -brian derived*/
psflmp,
psf_done_date,
psf_eligable,
psf_lmp_date,
psf_status,
psf_urt,
saf_done_date,
saf_past_order,
saf_status,
safstatus,
safdate,
last_safstatus,
last_safdate,
supp_status, /*keep*/
saf_flow_status, /*keep*/
uvf_done_date,
uvf_status,
uvf_ga,
uvf_lmp_date,
ses_done_date,
ses_status,
mpf_done_date,  /*keep*/
mpf_status,  /*keep*/
mpfb_done_date,  /*keep*/
mpfb_status,  /*keep*/
lpf_done_date,  /*keep*/
lpf_status,  /*keep*/
lpfb_done_date,  /*keep*/
lpfb_status,  /*keep*/
fbaf_done_date,
fbaf_status,
ibaf_done_date,
ibaf_status,
mbaf_done_date,
mbaf_status,
i1mop_done_date,
i1mop_status,
m1mop_done_date,
m1mop_status,
mopb_status,
mopb_done_date,
/*outcome_date,*/
/*outcome_status,*/
mpf_ga,
lmp_status,
ga_at_psfurt,
bnfstatus, /*keep*/
bnfdate, /*keep*/
chld1vitsts, /*keep*/
chld2vitsts, /*keep*/
chld3vitsts, /*keep*/
mbafstatus, /*keep*/
mbafdate, /*keep*/
lpfstatus, /*keep*/
lpfdate, /*keep*/
bgoutc, /*keep*/
bgoutcru, /*keep*/
bgoutcsrc, /*keep*/
bgwoutc, /*keep*/
bgdoutc, /*keep*/
bgdoutcru, /*keep*/
fdose_date,
edose_date,
totdose_days,
totdose_mns,
totdose_bep,
pcomp_mns,
pcomp_bep
into wtrak_pw 
from wtrak_pw_prep 
where 
woman_status !=8 -- women who are duplicates
or woman_status is null


go 



-------------------------------------------------------------------------------------------------------------------------------------------


print'Large N ' 
select * from wtrak_pw 
-- moved the exclusion of duplicate participants up to the wtrak_pw generation section

print'Started Pregnancy Surveilance' 
select * from wtrak_pw where 
last_psf_status is not null 


select count(*) from wtrak_pw 
where psfurt =1 
--n = 661

print 'Pregnancy Enrollment - consented to the pw trial'
select * from wtrak_pw 
where peconsent = 1
-- n = 354
-- matching with the woman_pw table 

print 'Pregnancy enrollment by arm '
select allocated_arm ,count(*) from wtrak_pw 
where psfurt =1 
and allocated_arm is not null 
group by allocated_arm
with rollup 

-- PEF status 
-- 1	Met
-- 2	Not met (up to 15 weeks post-LMP)
-- 3	Woman had MR
-- 4	Miscarriage
-- 6	Refused interview
-- 7	Permanently moved
-- 8	Died



select pefstatus,pef_eligible,pef_consent, count(*) from wtrak_pw 
where psfurt =1 
group by pefstatus ,pef_eligible ,pef_consent
with rollup 


print 'enrollment status '
print 'note -- BD added pending interview and pending consent to "Pending"  '
print 'AND -- BD added "Not met (up to 17 weeks post-LMP)" and "PEF - ineligible"  '
select --pefstatus , pef_eligible , 
case 
when pefstatus is null and pef_eligible = 0  then '	PEF - ineligible'
when pefstatus is null and pef_eligible = 1  then '	PEF - pending interview'
when pefstatus =1  and pef_eligible =1 and pef_consent=1  then 'PEF - met - consented '
when pefstatus =1  and pef_eligible =1 and pef_consent=6  then 'PEF - met - refused consented '
when pefstatus =1  and pef_eligible =1 and pef_consent=3  then 'PEF - met - pending consent '
when pefstatus =1  and pef_eligible =1  then 'pef - met '
when pefstatus =2  and pef_eligible =1  then '	Not met (up to 17 weeks post-LMP)'
when pefstatus =3  and pef_eligible =1  then 'Woman had Menstrual Regulation'
when pefstatus =4  and pef_eligible =1  then 'Woman had Miscarriage'
when pefstatus =6  and pef_eligible =1  then 'Woman refused PEF'
when pefstatus =7  and pef_eligible =1  then 'Woman permanently moved'
when pefstatus =8  and pef_eligible =1  then 'Woman Died' end as pef_status_desc
,count(*) 
from wtrak_pw 
where psfurt = 1 
group by 
case 
when pefstatus is null and pef_eligible = 0  then '	PEF - ineligible'
when pefstatus is null and pef_eligible = 1  then '	PEF - pending interview'
when pefstatus =1  and pef_eligible =1 and pef_consent=1  then 'PEF - met - consented '
when pefstatus =1  and pef_eligible =1 and pef_consent=6  then 'PEF - met - refused consented '
when pefstatus =1  and pef_eligible =1 and pef_consent=3  then 'PEF - met - pending consent '
when pefstatus =1  and pef_eligible =1  then 'pef - met '
when pefstatus =2  and pef_eligible =1  then '	Not met (up to 17 weeks post-LMP)'
when pefstatus =3  and pef_eligible =1  then 'Woman had Menstrual Regulation'
when pefstatus =4  and pef_eligible =1  then 'Woman had Miscarriage'
when pefstatus =6  and pef_eligible =1  then 'Woman refused PEF'
when pefstatus =7  and pef_eligible =1  then 'Woman permanently moved'
when pefstatus =8  and pef_eligible =1  then 'Woman Died' end
with rollup


select wt.allocated_arm,supp_status, count(*)
from wtrak_pw wt
where 
pef_consent =1 
group by wt.allocated_arm, supp_status 
with rollup 

-- 01	Met
-- 02	Not met
-- 03	Met over phone
-- 04	Miscarriage
-- 05	MR
-- 06	Livebirth
-- 07	Still birth 
-- 08	Not observed due to fasting
-- 66	Refused
-- 77	Permanently moved
-- 88	Died


-- uvf status 
-- 3	Woman had MR
-- 4	Miscarriage
-- 6	Refused interview
-- 7	permanently moved 
-- 8	died 



-- print 'supplementation status'
--  select wt.allocated_arm,supp_status,
--  case when supp_status =1 then 'SAF - Met'
--  when supp_status =2 then 'SAF - Not Met'
--  when supp_status =3 then 'SAF - Met over phone'
--  when supp_status =4 then 'SAF - Miscarriage'
--  when supp_status =5 then 'SAF - Menstrual Regulation '
--  when supp_status =6 then 'SAF - Live Birth'
--  when supp_status =7 then 'SAF - Still Birth'
--  when supp_status =8 then 'SAF - Not observed due to fasting'
--  when supp_status =61 then 'SAF - discontinued due to USG GA > 16  '
--  when supp_status =62 then 'SAF - discontinued due to PX measure'
--  when supp_status =63 then 'UVF - Menstrual Regulation'
--  when supp_status =64 then 'UVF - Miscarriage'
--  when supp_status =65 then 'UVF  - Refused interview'
--  when supp_status =66 then 'SAF - Refused'
--  when supp_status =67 then 'UVF - Permanent Move'
--  when supp_status =68 then 'UVF - Died'
--  when supp_status =77 then 'SAF - Permanently moved'
--  when supp_status =88 then 'SAF - Died' end 
--   as supp_status_desc
--  , count(*)

--  from wtrak_pw wt
--  where 
--  pef_consent =1 
--  group by wt.allocated_arm,supp_status
--  with rollup 




print 'supplementation status'
 select wt.allocated_arm,saf_flow_status,
 case when saf_flow_status =1 then 'SAF - Met'
 when saf_flow_status =2 then 'SAF - Not Met'
 when saf_flow_status =3 then 'SAF - Met over phone'
 when saf_flow_status =4 then 'SAF - Miscarriage'
 when saf_flow_status =5 then 'SAF - Menstrual Regulation '
 when saf_flow_status =6 then 'SAF - Live Birth'
 when saf_flow_status =7 then 'SAF - Still Birth'
 when saf_flow_status =8 then 'SAF - Not observed due to fasting'
 when saf_flow_status =61 then 'SAF - discontinued due to USG GA > 16  '
 when saf_flow_status =62 then 'SAF - discontinued due to PX measure'
 when saf_flow_status =63 then 'UVF - Menstrual Regulation'
 when saf_flow_status =64 then 'UVF - Miscarriage'
 when saf_flow_status =65 then 'UVF - Refused interview'
 when saf_flow_status =66 then 'SAF - Refused'
 when saf_flow_status =67 then 'UVF - Permanent Move'
 when saf_flow_status =68 then 'UVF - Died'
 when saf_flow_status =77 then 'SAF - Permanently moved'
 when saf_flow_status =88 then 'SAF - Died' end 
  as saf_flow_status_desc
 , count(*)

 from wtrak_pw wt
 where 
 pef_consent =1 
 group by wt.allocated_arm,saf_flow_status
 with rollup 

-- select *  from wtrak_pw wt
-- where 
-- pef_consent =1  and 
-- safstatus = 1 and 
-- supp_status =1
--  group by wt.allocated_arm,supp_status



 
-- select allocated_arm, m.mpstatus ,mb.mpbstatus ,count(*) from wtrak_pw w
-- left join mpf_mv m on m.uid = w.uid 
-- left join mpfb_mv mb on mb.uid = w.uid 
-- where pef_consent =1 
-- and safstatus = 1
-- and supp_status = 1
-- group by allocated_arm, m.mpstatus  ,mb.mpbstatus
-- with rollup 



-- select * from wtrak_pw 
-- where uid in ('531826')


-- saf status for flow 
-- if no lpf and latest_saf_status date > mpf_date then use safstatus 
-- if no mpf then use safstatus 
-- if mpf and mpf_date > then use safstatus 
-- if mpf then get min saf status before mpf_date 
-- update 



-- print 'mid pregnancy visit status'
-- select allocated_arm, m.mpstatus ,mb.mpbstatus ,count(*) from wtrak_pw w
-- left join mpf_mv m on m.uid = w.uid 
-- left join mpfb_mv mb on mb.uid = w.uid 
-- where pef_consent =1 
-- and saf_flow_status = 1
-- group by allocated_arm, m.mpstatus  ,mb.mpbstatus
-- with rollup 



-- print 'mid pregnancy visit status'
-- select allocated_arm, m.mpstatus ,mb.mpbstatus.w.bgoutc ,count(*) from wtrak_pw w
-- left join mpf_mv m on m.uid = w.uid 
-- left join mpfb_mv mb on mb.uid = w.uid 
-- where pef_consent =1 
-- and saf_flow_status = 1
-- group by allocated_arm, m.mpstatus  ,mb.mpbstatus,w.bgoutc
-- with rollup 


-- print 'mid pregnancy visit status'
-- select allocated_arm,saf_flow_status, m.mpstatus ,mb.mpbstatus,w.bgoutc ,count(*) from wtrak_pw w
-- left join mpf_mv m on m.uid = w.uid 
-- left join mpfb_mv mb on mb.uid = w.uid 
-- where pef_consent =1 
-- and saf_flow_status = 1
-- group by allocated_arm,saf_flow_status, m.mpstatus  ,mb.mpbstatus,w.bgoutc
-- with rollup 

print 'mid pregnancy visit status'
select allocated_arm,saf_flow_status, mpf_status ,mpfb_status,w.bgoutc ,count(*) from wtrak_pw w
where pef_consent =1 
and saf_flow_status = 1
group by allocated_arm,saf_flow_status,mpf_status,mpfb_status,w.bgoutc
with rollup 



print ' count of all mpf visits'
select count(*) from wtrak_pw 
where  pef_consent =1 and 
saf_flow_status = 1 and 
mpf_status ='01' and mpfb_status ='01'
-- n = 123 


-- print 'late pregnancy visit status'
-- select allocated_arm,lpf_status ,lpfb_status ,count(*) from wtrak_pw w
-- left join lpf_mv l on l.uid = w.uid 
-- left join lpfb_mv lb on lb.uid = w.uid 
-- where
-- pef_consent =1 and 
-- mpf_status ='01' and mpfb_status ='01'
-- group by allocated_arm,lpf_status,lpfb_status 
-- with rollup 




print 'late pregnancy visit status'
select allocated_arm,lpf_status ,lpfb_status ,bgoutc,count(*) from wtrak_pw w
left join lpf_mv l on l.uid = w.uid 
left join lpfb_mv lb on lb.uid = w.uid 
where
pef_consent =1 and 
mpf_status ='01' and mpfb_status ='01'
group by allocated_arm,lpf_status,lpfb_status ,bgoutc
with rollup 



-- print 'outcomes after LPF'
-- select allocated_arm,lpfstatus ,lpfb_status ,count(*) from wtrak_pw w
-- left join lpf_mv l on l.uid = w.uid 
-- left join lpfb_mv lb on lb.uid = w.uid 
-- where
-- pef_consent =1 and 
-- mpf_status ='01' 
-- and lpfstatus ='01' and lpfb_status = '01'
-- group by allocated_arm,lpfstatus,lpfb_status 
-- with rollup 


-- print 'count of total outcomes'
-- select allocated_arm,bgoutc,count(*) from wtrak_pw w
-- left join lpf_mv l on l.uid = w.uid 
-- left join lpfb_mv lb on lb.uid = w.uid 
-- where
-- pef_consent =1 and 
-- mpf_status ='01' 
-- and lpfstatus ='01' and lpfb_status = '01'
-- and bgoutc is not null 
-- group by allocated_arm,bgoutc
-- with rollup


-- print 'check the SAF status to see if there is'
-- -- 01	Met
-- -- 02	Not met
-- -- 03	Met over phone
-- -- 04	Miscarriage
-- -- 05	MR
-- -- 06	Livebirth
-- -- 07	Still birth 
-- -- 08	Not observed due to fasting
-- -- 66	Refused
-- -- 77	Permanently moved
-- -- 88	Died


-- print 'check the MPF status'
-- 01	Met
-- 02	Not met (up to 35 weeks GA)
-- 03	Woman had MR
-- 04	Miscarriage
-- 05	Woman had livebirth
-- 06	Still birth 
-- 66	Refused interview
-- 77	Permanently moved
-- 88	Died



-- select allocated_arm,
-- case when safstatus=4 then 'Miscarriage- SAF'
-- when safstatus=5 then ' MR - SAF'
-- when safstatus=6 then 'Live Birth - SAF '
-- when safstatus=7 then 'Still Birth - SAF ' end
--  , count(*) from wtrak_pw 
-- where safstatus in (4,5,6,7)
-- group by allocated_arm,safstatus 
-- order by allocated_arm 

-- -- BNF form outcome values 
-- -- 1	 Livebirth
-- -- 2	 Stillbirth
-- -- 9	 Don't know


print 'count of outcomes - after lpf '
select allocated_arm,bgoutc,count(*) from wtrak_pw w
left join lpf_mv l on l.uid = w.uid 
left join lpfb_mv lb on lb.uid = w.uid 
where
pef_consent =1 and 
mpf_status ='01' 
and lpfstatus ='01' and lpfb_status = '01'
and bgoutc is not null 
group by allocated_arm,bgoutc
with rollup




-- print 'women that had an outcome after mpf and before LPF '
-- select uid,allocated_arm,mpf_status,mpf_done_date, lpf_status,lpf_done_date,safstatus,last_safstatus,last_safdate,saf_status,saf_done_date,safstatus,safdate,bnfdate,chld1vitsts,chld2vitsts,chld2vitsts,
-- case when safstatus=4 then 'Miscarriage- SAF'
-- when safstatus=5 then ' MR - SAF'
-- when safstatus=6 then 'Live Birth - SAF '
-- when safstatus=7 then 'Still Birth - SAF ' end as safstatus_desc
-- from wtrak_pw 
-- where safstatus in (4,5,6,7)
-- and  mpf_status is not null and lpf_status is null 



-- select * from fbaf_mv -- n = 26
-- select * from ibaf_mv -- n = 53
-- select 26+53

-- select uid,mbafstatus,mbafdate,bnfdate,chld1vitsts,chld2vitsts,chld3vitsts,bgoutc,bgdoutc,bgoutcsrc,bgoutcru from wtrak_pw 
-- where pef_consent=1
-- and lpf_done_date is not null
