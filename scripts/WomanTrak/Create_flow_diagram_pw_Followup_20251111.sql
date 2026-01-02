use [mindr-live]
go

print 'count of women available for PW trial'
select count(*) from woman_pw 
--4001
-- all except 691 have been transferred to the psf cohort 

-- in creating a woman trak 
-- From Kerry 6/25/2024 11:26 am Subject:"RE: transmittal list" GA at screening and then GA at the enrollment week visits—and sometimes that was spread out over time.
--  It might be good to have both of those, but GA at the time of the enrollment visits would be the priority.

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

alter table bd_wom_pw
add peb_date smalldatetime null 

alter table bd_wom_pw
add peb_time smalldatetime null 

alter table bd_wom_pw
add peb_meal_time smalldatetime null 

alter table bd_wom_pw
add peb_fast_time decimal(10,2) null 

alter table bd_wom_pw
add peb_status integer null 

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
add wef_consent smalldatetime null 

alter table wtrak_pw_prep
add wef_consent_src varchar(10) null 

alter table wtrak_pw_prep
add wef_rnd1_date smalldatetime null 

alter table wtrak_pw_prep
add wef_rnd2_date smalldatetime null 

alter table wtrak_pw_prep
add age_wef decimal(10,1) null 

alter table wtrak_pw_prep
add age_pef decimal(10,1) null 

alter table wtrak_pw_prep
add age_date smalldatetime null 

alter table wtrak_pw_prep
add pefstatus int null 

alter table wtrak_pw_prep
add peconsent int null 

alter table wtrak_pw_prep
add pedate smalldatetime null 

alter table wtrak_pw_prep
add peb_date smalldatetime null 

alter table wtrak_pw_prep
add peb_time smalldatetime null 

alter table wtrak_pw_prep
add peb_meal_time smalldatetime null 

alter table wtrak_pw_prep
add peb_fast_time decimal(10,2) null 

alter table wtrak_pw_prep
add peb_status integer null 

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
add lmp_us smalldatetime null 
go 

alter table wtrak_pw_prep
add bglmp smalldatetime null 
go 

alter table wtrak_pw_prep
add bglmpru integer null 
go 

alter table wtrak_pw_prep
add ga_us decimal(10,2) null 
go 


alter table wtrak_pw_prep
add bgga decimal(10,2) null 
go 

alter table wtrak_pw_prep
add bgga_dy int null 
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
add first_safdate smalldatetime null
go 

alter table wtrak_pw_prep
add last_saf_status_bef_mpf int null 
go 

alter table wtrak_pw_prep
add supp_status int null 
go 

alter table wtrak_pw_prep
add saf_flow_status int null 
go 

alter table wtrak_pw_prep
add mid_preg_status int null 
go 

alter table wtrak_pw_prep
add mpb_date smalldatetime null 

alter table wtrak_pw_prep
add mpb_time smalldatetime null 

alter table wtrak_pw_prep
add mpb_meal_time smalldatetime null 

alter table wtrak_pw_prep
add mpb_fast_time decimal(10,2) null 

alter table wtrak_pw_prep
add mpb_status integer null 


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
add lpb_date smalldatetime null 
go

alter table wtrak_pw_prep
add lpb_time smalldatetime null 
go

alter table wtrak_pw_prep
add lpb_meal_time smalldatetime null 
go

alter table wtrak_pw_prep
add lpb_fast_time decimal(10,2) null 
go

alter table wtrak_pw_prep
add lpb_status integer null 
go

alter table wtrak_pw_prep
add late_preg_status int null 
go


alter table wtrak_pw_prep
add m1m_status int null
go 

alter table wtrak_pw_prep
add m1mdate smalldatetime null
go 

alter table wtrak_pw_prep
add m1mb_date smalldatetime null 
go

alter table wtrak_pw_prep
add m1mb_time smalldatetime null 
go



alter table wtrak_pw_prep
add m3m_status int null
go 

alter table wtrak_pw_prep
add m3mdate smalldatetime null
go 

alter table wtrak_pw_prep
add m3mb_date smalldatetime null 
go

alter table wtrak_pw_prep
add m3mb_time smalldatetime null 
go



alter table wtrak_pw_prep
add m6m_status int null
go 

alter table wtrak_pw_prep
add m6mdate smalldatetime null
go 

alter table wtrak_pw_prep
add m6mb_date smalldatetime null 
go

alter table wtrak_pw_prep
add m6mb_time smalldatetime null 
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

alter table wtrak_pw_prep 
add ga_at_first_saf int
go 

alter table wtrak_pw_prep 
add ga_at_mpf_gen int
go 

alter table wtrak_pw_prep 
add ga_at_mpf_done int
go 

alter table wtrak_pw_prep 
add ga_at_lpf_gen int
go 

alter table wtrak_pw_prep 
add ga_at_lpf_done int
go 

alter table wtrak_pw_prep 
add current_ga int
go 

alter table wtrak_pw_prep 
add mpf_schedule_date smalldatetime
go 

alter table wtrak_pw_prep 
add lpf_schedule_date smalldatetime
go 

alter table wtrak_pw_prep 
add lpfb_schedule_date smalldatetime
go 

alter table wtrak_pw_prep
add m1b_date smalldatetime null 
go

alter table wtrak_pw_prep
add m1b_time smalldatetime null 
go

alter table wtrak_pw_prep
add m1b_meal_time smalldatetime null 
go 


alter table wtrak_pw_prep
add m1b_fast_time decimal(10,2) null 
go

alter table wtrak_pw_prep
add m1b_status integer null 
go

alter table wtrak_pw_prep
add m1b_blspecimen integer null 
go

alter table wtrak_pw_prep
add m1b_bmspecimen integer null 
go



alter table wtrak_pw_prep
add m3b_date smalldatetime null 
go

alter table wtrak_pw_prep
add m3b_time smalldatetime null 
go

alter table wtrak_pw_prep
add m3b_meal_time smalldatetime null 
go 


alter table wtrak_pw_prep
add m3b_fast_time decimal(10,2) null 
go

alter table wtrak_pw_prep
add m3b_status integer null 
go

alter table wtrak_pw_prep
add m3b_specimen integer null 
go


alter table wtrak_pw_prep
add m6b_date smalldatetime null 
go

alter table wtrak_pw_prep
add m6b_time smalldatetime null 
go

alter table wtrak_pw_prep
add m6b_meal_time smalldatetime null 
go 


alter table wtrak_pw_prep
add m6b_fast_time decimal(10,2) null 
go

alter table wtrak_pw_prep
add m6b_status integer null 
go

alter table wtrak_pw_prep
add m6b_specimen integer null 
go

alter table wtrak_pw_prep
add m6b_slvspecimen integer null 
go


alter table wtrak_pw_prep
add parity integer null 
go

alter table wtrak_pw_prep
add gravidity integer null 
go

alter table wtrak_pw_prep
add lsi  varchar(50)
go


update wtrak_pw_prep 
set wef_rnd1_date = convert(smalldatetime,'2023-03-20',121)
from wtrak_pw_prep 

update wtrak_pw_prep 
set wef_rnd2_date = convert(smalldatetime,'2023-09-10',121)
from wtrak_pw_prep 


update wtrak_pw_prep 
set wef_consent = wp.wedate
from wtrak_pw_prep wt 
right join (select uid, min(wedate) wedate from wef_nwef_mv_prep wp
where westatus =1 and wef_consent =1 
group by uid) wp on wp.uid = wt.uid 


update wtrak_pw_prep 
set wef_consent_src = wef_src
from wtrak_pw_prep wt 
right join 
(select p.uid, wef_src from wef_nwef_mv_prep p
left join (select uid,min(wedate) wedate from wef_nwef_mv_prep wp
where westatus =1 and wef_consent =1 -- 7339
group by uid ) a on a.uid = p.uid and a.wedate = p.wedate 
where p.westatus =1 and p.wef_consent =1
and p.uid is not null and a.uid is not null ) wp on wp.uid = wt.uid 



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



-- update wtrak_pw_prep 
-- set age_wef = datediff()



update wtrak_pw_prep 
set age_wef = 
case when wef_consent >= wef_rnd1_date and wef_consent < wef_rnd2_date and wef_consent is not null 
then  cast(datediff(day,bgdob,wef_rnd1_date) as decimal(10,2)) / 365
when wef_consent >= wef_rnd2_date and wef_consent is not null 
then cast(datediff(day,bgdob,wef_rnd2_date) as decimal(10,2)) / 365
else null end ,
age_date = 
case when wef_consent >= wef_rnd1_date and wef_consent < wef_rnd2_date and wef_consent is not null 
then  wef_rnd1_date
when wef_consent >= wef_rnd2_date and wef_consent is not null 
then wef_rnd2_date
else null end 
from wtrak_pw_prep
where wef_consent_src like 'wef%'


update wtrak_pw_prep 
set age_wef = cast(datediff(day,bgdob,wef_consent) as decimal(10,2)) / 365
  from wtrak_pw_prep 
  where wef_consent_src like 'nwef%'


print 'identifying and updating some of the close 36 ages that are actually 35 '
update wtrak_pw_prep 
set age_wef = 
case when cast(substring(convert(varchar,w.age_date,120),1,4) as numeric) - cast(substring(convert(varchar,w.bgdob,120),1,4) as numeric) =36 and 
cast(substring(convert(varchar,w.age_date,120),6,2) as numeric) - cast(substring(convert(varchar,w.bgdob,120),6,2) as numeric) <0 then 35 
when cast(substring(convert(varchar,w.age_date,120),1,4) as numeric) - cast(substring(convert(varchar,w.bgdob,120),1,4) as numeric) =36 and 
cast(substring(convert(varchar,w.age_date,120),6,2) as numeric) - cast(substring(convert(varchar,w.bgdob,120),6,2) as numeric)  = 0 and 
cast(substring(convert(varchar,w.age_date,120),9,2) as numeric) - cast(substring(convert(varchar,w.bgdob,120),9,2) as numeric) < 0 then 35 else 
w.age_wef end 
from wtrak_pw_prep w
where wef_consent_src like 'wef%'
and age_wef >=36



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
set age_pef = cast(datediff(day,bgdob,pedate) as decimal(10,2)) / 365
from wtrak_pw_prep 



print ' updating the pef blood collection and mealtimes'
update wtrak_pw_prep
set peb_date = pb.pebdate
,peb_time = convert(datetime,substring(convert(varchar,pebdate,121),1,10)+' '+ substring(convert(varchar,pebbldtime,121),1,10)) 
,peb_meal_time = convert(datetime,substring(convert(varchar,pebmealdate,121),1,10)+' '+ substring(convert(varchar,pebmealtime,121),1,10)) 
,peb_fast_time  = datediff(minute,convert(datetime,substring(convert(varchar,pebmealdate,121),1,10)+' '+ substring(convert(varchar,pebmealtime,121),1,10)) 
,convert(datetime,substring(convert(varchar,pebdate,121),1,10)+' '+ substring(convert(varchar,pebbldtime,121),1,10))) 
,peb_status = pb.pebstatus
from wtrak_pw_prep w 
left join pefb_mv pb on pb.uid = w.uid 
where peconsent =1 




print ' updating the mid pregnancy visit blood collection and mealtimes'
update wtrak_pw_prep
set mpb_date = pb.mpbdate
,mpb_time = convert(datetime,substring(convert(varchar,mpbdate,121),1,10)+' '+ substring(convert(varchar,mpbbldtime,121),1,10)) 
,mpb_meal_time = convert(datetime,substring(convert(varchar,mpbmealdate,121),1,10)+' '+ substring(convert(varchar,mpbmealtime,121),1,10)) 
,mpb_fast_time  = datediff(minute,convert(datetime,substring(convert(varchar,mpbmealdate,121),1,10)+' '+ substring(convert(varchar,mpbmealtime,121),1,10)) 
,convert(datetime,substring(convert(varchar,mpbdate,121),1,10)+' '+ substring(convert(varchar,mpbbldtime,121),1,10))) 
,mpb_status = pb.mpbstatus
from wtrak_pw_prep w 
left join mpfb_mv pb on pb.uid = w.uid 
where peconsent =1 


print ' updating the pef blood collection and mealtimes'
update wtrak_pw_prep
set lpb_date = pb.lpbdate
,lpb_time = convert(datetime,substring(convert(varchar,lpbdate,121),1,10)+' '+ substring(convert(varchar,lpbbldtime,121),1,10)) 
,lpb_meal_time = convert(datetime,substring(convert(varchar,lpbmealdate,121),1,10)+' '+ substring(convert(varchar,lpbmealtime,121),1,10)) 
,lpb_fast_time  = datediff(minute,convert(datetime,substring(convert(varchar,lpbmealdate,121),1,10)+' '+ substring(convert(varchar,lpbmealtime,121),1,10)) 
,convert(datetime,substring(convert(varchar,lpbdate,121),1,10)+' '+ substring(convert(varchar,lpbbldtime,121),1,10))) 
,lpb_status = pb.lpbstatus
from wtrak_pw_prep w 
left join lpfb_mv pb on pb.uid = w.uid 
where peconsent =1 


print ' updating the pef blood collection and mealtimes'
update wtrak_pw_prep
set m1b_date = pb.m1bdate
,m1b_time = convert(datetime,substring(convert(varchar,m1bdate,121),1,10)+' '+ substring(convert(varchar,m1bbldtime,121),1,10)) 
,m1b_meal_time = convert(datetime,substring(convert(varchar,m1bmealdate,121),1,10)+' '+ substring(convert(varchar,m1bmealtime,121),1,10)) 
,m1b_fast_time  = datediff(minute,convert(datetime,substring(convert(varchar,m1bmealdate,121),1,10)+' '+ substring(convert(varchar,m1bmealtime,121),1,10)) 
,convert(datetime,substring(convert(varchar,m1bdate,121),1,10)+' '+ substring(convert(varchar,m1bbldtime,121),1,10))) 
,m1b_status = pb.m1bstatus
,m1b_bmspecimen = case when pb.m1bbmilkv!='000' and (m1bbmspecid is not null or m1bbmspecid!= '000') then '1' else null end 
,m1b_blspecimen = case when pb.m1bblood1 > 0 and (pb.m1bspecid1 is not null) then '1' else null end 
from wtrak_pw_prep w 
left join m1mopb_mv pb on pb.uid = w.uid 
where peconsent =1 


print ' updating the m3 breastmilk specimen collection and mealtimes'
update wtrak_pw_prep
set m3b_date = pb.m3bdate
,m3b_time = convert(datetime,substring(convert(varchar,m3bdate,121),1,10)+' '+ substring(convert(varchar,m3bcols,121),1,10)) 
--,m3b_meal_time = convert(datetime,substring(convert(varchar,m3bmealdate,121),1,10)+' '+ substring(convert(varchar,m3bmealtime,121),1,10)) 
--,m3b_fast_time  = datediff(minute,convert(datetime,substring(convert(varchar,m3bmealdate,121),1,10)+' '+ substring(convert(varchar,m3bmealtime,121),1,10)) 
--,convert(datetime,substring(convert(varchar,m3bdate,121),1,10)+' '+ substring(convert(varchar,m3bbldtime,121),1,10))) 
,m3b_status = pb.m3bstatus
,m3b_specimen = case when pb.m3bbmilkv!='000' and (m3bbmspecid is not null or m3bbmspecid!= '000') then '1' else null end 
from wtrak_pw_prep w 
left join m36mopb_mv pb on pb.uid = w.uid 
where peconsent =1 



print ' updating the m3 breastmilk specimen collection and mealtimes'
update wtrak_pw_prep
set m6b_date = pb.m6bdate
,m6b_time = convert(datetime,substring(convert(varchar,m6bdate,121),1,10)+' '+ substring(convert(varchar,m6bcols,121),1,10)) 
--,m6b_meal_time = convert(datetime,substring(convert(varchar,m6bmealdate,121),1,10)+' '+ substring(convert(varchar,m6bmealtime,121),1,10)) 
--,m6b_fast_time  = datediff(minute,convert(datetime,substring(convert(varchar,m6bmealdate,121),1,10)+' '+ substring(convert(varchar,m6bmealtime,121),1,10)) 
--,convert(datetime,substring(convert(varchar,m6bdate,121),1,10)+' '+ substring(convert(varchar,m6bbldtime,121),1,10))) 
,m6b_status = pb.m6bstatus
,m6b_specimen = case when pb.m6bbmilkv!='000' and (m6bbmspecid is not null or m6bbmspecid!= '000') then '1' else null end 
,m6b_slvspecimen = case when pb.m6bbspecimenid is not null then '1' else null end
from wtrak_pw_prep w 
left join m69mopb_mv pb on pb.uid = w.uid 
where peconsent =1 




-- update wtrak_pw_prep 
-- set m1mb_date = m1.m1bdate,
-- m1b_status = m1.m1bstatus,
-- m1b_bmspecimen = case when m1.m1bbmilkv!='000' and (m1bbmspecid is not null or m1bbmspecid!= '000') then '1' else 
-- wtrak_pw_prep pw
-- left join m1mopb_mv m1 on m1.uid = pw.uid 
-- where  pw.pef_consent = 1
-- and m1.m1bstatus is not null 


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
go 


update wtrak_pw_prep 
set supp_status = safstatus 
from wtrak_pw_prep 

print 'update the supplementation status of the woman'
print 'lets order the next reasons why a woman could have been discontinued in order of study timeline'

print ' where women refused Pregnancy enrollment blood'
update wtrak_pw_prep 
set supp_status = 60
from wtrak_pw_prep pw
where pefb_status = 66  and supp_status is null

-- left join pw_log pl on pw.uid =pl.uid 
-- where DISCONTINUED ='1111111111' and DISCNTD_Source = 'USG>16GA'

-- filling in maybe some of the reasons why there wasn't 
-- any supplementation 
-- update wtrak_pw_prep 
-- set supp_status = 61
-- from wtrak_pw_prep pw
-- left join pw_log pl on pw.uid =pl.uid 
-- where DISCONTINUED ='1111111111' and DISCNTD_Source = 'USG>16GA'

-- I think we update the supp_status and only update when it is null 
-- with a reason why there was no supplementation 
-- Do I update this if there is a not met code to say what happened ? 


update wtrak_pw_prep 
set supp_status = 62
from wtrak_pw_prep pw
left join pw_log1 pl on pw.uid =pl.uid 
where Discontinued in('Discontinued','Disenrollment') and DISCNTD_Source = 'PX_Data_Baseline'
and (supp_status !=60 or supp_status is null)

update wtrak_pw_prep 
set supp_status = 61
from wtrak_pw_prep pw
left join pw_log1 pl on pw.uid =pl.uid 
where DISCONTINUED in('Discontinued','Disenrollment') and DISCNTD_Source = 'USG>16GA'
and supp_status not in ('60','62')

-- update wtrak_pw_prep 
-- set supp_status = 62
-- from wtrak_pw_prep pw
-- left join pw_log pl on pw.uid =pl.uid 
-- where DISCONTINUED ='1111111111' and DISCNTD_Source = 'PX_Data_Baseline'


update wtrak_pw_prep 
set supp_status = 69
from wtrak_pw_prep pw
left join pw_log1 pl on pw.uid =pl.uid 
where Discontinued in('Discontinued','Disenrollment') and DISCNTD_Source = 'PX_Data_Midline'
and supp_status not in ('60','62','61')


update wtrak_pw_prep 
set supp_status = 70
from wtrak_pw_prep pw
left join pw_log1 pl on pw.uid =pl.uid 
where Discontinued in('Discontinued','Disenrollment') and DISCNTD_Source = 'PX_Data_LPF'
and supp_status not in ('60','62','61','69')


update wtrak_pw_prep 
set supp_status = 71
from wtrak_pw_prep pw
where cast(uvf_ga as decimal (10,2))>= 17
and (supp_status not in ('60','62','61','69','70') or supp_status is null)
and uid not in ('489704') -- This woman was kept in the study for monitoring LPF BAF and MOP 
-- even though her UVF GA was >17 GA 

-- uvf status 
-- 3	Woman had MR
-- 4	Miscarriage
-- 6	Refused interview
-- 7	permanently moved 
-- 8	died 

print 'uvf_descrepency in the woman table so resetting the variable with the live view data'


update wtrak_pw_prep
set uvf_status =null,
uvf_done_date = null 
from wtrak_pw_prep
go 


update wtrak_pw_prep
set uvf_status = u.uvstatus,
uvf_done_date = u.uvdate 
from wtrak_pw_prep w
left join (select uid, uvdate,uvstatus from uvf_mv) u  on u.uid = w.uid 
go 



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

-- pw_log1 is where all the checks are happening for the PX data 

print 'update only the status for what happens before MPF for the flow diagram'
print 'finding the min value for this range'
update wtrak_pw_prep 
set saf_flow_status = saf.min_sastatus
from wtrak_pw_prep pw
left join (select s.uid,min(sastatus) as min_sastatus from safpw_mv s left join wtrak_pw_prep p on p.uid =s.uid and s.sadate <p.mpf_done_date group by s.uid 
) saf on saf.uid  = pw.uid 


print 'finding the max value for this range for stop reasons - where no supplementation happened yet'
update wtrak_pw_prep 
set saf_flow_status = b.sastatus
from wtrak_pw_prep pw
right join (
select s.uid, s.sastatus , max(s.sadate)  sadate from 
safpw_mv s 
inner join (select s.uid,max(sastatus) max_sastatus from safpw_mv s 
left join wtrak_pw_prep p on p.uid =s.uid  
where pef_consent=1 and s.sastatus in ('04','05','06','07','77','88') 
group by s.uid ) a on a.uid = s.uid and a.max_sastatus = s.sastatus
group by s.uid, s.sastatus 
) b on b.uid = pw.uid and (b.sadate <= pw.mpf_done_date or (b.sadate = pw.saf_done_date and pw.mpf_done_date is null and pw.lpf_done_date is null ))
 where saf_flow_status >1



update wtrak_pw_prep 
set saf_flow_status = supp_status
from wtrak_pw_prep pw
where supp_status >59 
and supp_status not in ('66','69','70','77','88') -- already pulled these in where they saf was before MPF 




print 'getting variables for tracking mpf status and what happened based on Gestation age and scheduling '
update wtrak_pw_prep
 set ga_at_first_saf = datediff(week,pw.uvf_lmp_date,s.first_saf_date) 
 ,first_safdate = s.first_saf_date
,ga_at_mpf_gen = datediff(week,pw.uvf_lmp_date,sc.schedule_gen_date)
,ga_at_mpf_done = datediff(week,pw.uvf_lmp_date,pw.mpf_done_date)
,current_ga = datediff(week,pw.uvf_lmp_date,'2025-05-13')
from wtrak_pw_prep pw 
left join 
--saf_first_supped 
(SELECT sa.uid,min(sadate) first_saf_date
FROM safpw_mv sa
left join wtrak_pw_prep pw on pw.uid = sa.uid
where --sa.sadate < dateadd(week,22 ,pw.uvf_lmp_date)
--and
(sastatus='01' or sastatus='03') 
-- and the ga 
group by sa.uid ) s on s.uid = pw.uid  
left join (select uid, schedule_gen_date from schedule_pw where form_name='MPF') sc on sc.uid = pw.uid 
where saf_flow_status=1 


print 'getting variables for tracking LPF status and what happened based on Gestation age and scheduling '
update wtrak_pw_prep
set ga_at_lpf_gen = datediff(week,pw.uvf_lmp_date,sc.schedule_gen_date)
,ga_at_lpf_done = datediff(week,pw.uvf_lmp_date,pw.lpf_done_date)
from wtrak_pw_prep pw 
left join (select uid, schedule_gen_date from schedule_pw where form_name='LPF') sc on sc.uid = pw.uid 
where saf_flow_status =1 and pef_consent =1 





update wtrak_pw_prep 
set 
bnfdate = b.bnfdate,
chld1vitsts = b.bnfchldvitsts1,
chld2vitsts = b.bnfchldvitsts2,
chld3vitsts = b.bnfchldvitsts3
from wtrak_pw_prep pw
left join bnf_mv b on b.uid = pw.uid 


update wtrak_pw_prep
set mpf_status = null ,
mpf_done_date = null
from wtrak_pw_prep
go 

update wtrak_pw_prep 
set mpf_status = mp.mpstatus,
mpf_done_date = mp.mpdate from 
wtrak_pw_prep pw
left join mpf_mv mp on mp.uid = pw.uid 
and mp.mpstatus is not null 

-- Pending 
-- PX at midline 
-- Not met 
-- outcome before visit
-- start SAF ater 22 GA 




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


-- select uid,m1bdate,m1bstatus,m1bbmspecid,m1bbmilkv 
-- from 


-- m1bstatus =1 --287
-- and m1bbmspecid is not null -- 276 
-- and m1bbmilkv !='000' --276


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



update wtrak_pw_prep 
set fdose_date = c.fdose_date,
      edose_date = c.edose_date,
      totdose_days = c.totdose_days,
      totdose_mns = c.totdose_mns,
      totdose_bep = c.totdose_bep,
      pcomp_mns = c.pcomp_mns,
      pcomp_bep = c.pcomp_bep
from wtrak_pw_prep wt 
left join mindr_pw_compliance_20241015 c on c.uid = wt.uid 


--- add Brian's GA calc from USG 
update wtrak_pw_prep
set crl_median = ga.crl_median
, uvf_ga_bd = ga.uvf_ga_bd
from wtrak_pw_prep wt 
left join usggaview ga on ga.uid = wt.uid 
where ga.uid is not null 




update wtrak_pw_prep 
set last_saf_status_bef_mpf = sastatus
from wtrak_pw_prep pw1 left join 
safpw_mv sa on sa.uid = pw1.uid 
right join (
select s.uid, max(s.sadate) sadate from safpw_mv s
left join wtrak_pw_prep p on p.uid = s.uid 
where s.sadate < p.mpf_done_date 
and cast(sastatus as int) not in (2,3)
group by s.uid 
) a on a.uid = sa.uid and sa.sadate = a.sadate



update wtrak_pw_prep 
set mpf_schedule_date = schedule_gen_date
from wtrak_pw_prep pw1  
left join (select uid,schedule_gen_date from schedule_pw  where form_name ='MPF') s on pw1.uid =s.uid 


update wtrak_pw_prep 
set lpf_schedule_date = schedule_gen_date
from wtrak_pw_prep pw1  
left join (select uid,schedule_gen_date from schedule_pw  where form_name ='LPF') s on pw1.uid =s.uid 

update wtrak_pw_prep 
set lpfb_schedule_date = schedule_gen_date
from wtrak_pw_prep pw1  
left join (select uid,schedule_gen_date from schedule_pw  where form_name ='LPFB') s on pw1.uid =s.uid 








update wtrak_pw_prep 
set mid_preg_status = '8' -- Discontinued at PX Midline
from wtrak_pw_prep pw 
left join pw_log1 pl on pw.uid =pl.uid 
where Discontinued in('Discontinued','Disenrollment') and DISCNTD_Source = 'PX_Data_Midline'
and mid_preg_status is null


print 'mpf canceled due to NO supplementation before their MPF'
update wtrak_pw_prep
set mid_preg_status = '2'
--select uid ,a.supped 
from wtrak_pw_prep pw 
left join 
(SELECT sa.uid, case when SUM(CASE WHEN cast(sastatus as int) = 1 THEN 1 ELSE 0 END)=0 then 0 else 1 end as supped 
FROM safpw_mv sa
left join wtrak_pw_prep pw on pw.uid = sa.uid 
where peconsent = 1 and psfurt=1 and pef_eligible= 1 and pef_consent = 1 and  saf_flow_status=1
GROUP BY sa.uid) a on a.uid = pw.uid 
where (
    pw.ga_at_first_saf > pw.ga_at_mpf_gen
 or pw.ga_at_first_saf > 22) -- weeks at which cutting off  MPF
and  saf_flow_status=1 
and pw.mpf_status is null-- and -- may want to delete this there is 1 that has an mpf even though they were not 
-- supplemented before 22 weeks 
-- was there a decision date for this cuttoff? 
and mid_preg_status is null 


select w.uid,uvf_ga_bd, psflmp,uvf_lmp_date,s.schedule_gen_date as mpf_gen_date,saf_done_date,first_safdate, ga_at_first_saf,ga_at_mpf_gen,current_ga,mid_preg_status,mpf_status,mpfb_status  from wtrak_pw_prep w
left join (select uid,schedule_gen_date from schedule_pw  where form_name ='MPF') s on w.uid =s.uid 
where pef_consent =1 
and saf_flow_status = 1
and allocated_arm='A'
and mpf_status =1
and mid_preg_status=2


-- a.uid not in (SELECT sa.uid--, case when SUM(CASE WHEN cast(sastatus as int) = 1 THEN 1 ELSE 0 END)=0 then 0 else 1 end as supped 
-- FROM safpw_mv sa
-- left join wtrak_pw_prep pw on pw.uid = sa.uid
-- where sa.sadate < dateadd(week,22 ,pw.uvf_lmp_date)
-- and  saf_flow_status=1
--  --and peconsent = 1 and psfurt=1 and pef_eligible= 1 and pef_consent = 1 and  saf_flow_status=1
-- GROUP BY sa.uid)





update wtrak_pw_prep 
set mid_preg_status = '1' -- Met at MPF
from wtrak_pw_prep pw 
where mpf_status ='01' and mpb_status =1
and mid_preg_status is null
go

update wtrak_pw_prep 
set mid_preg_status = '4' -- Not met at MPF
from wtrak_pw_prep pw 
--left join pw_log1 pl on pw.uid =pl.uid 
where ((mpf_status ='01' and mpb_status =2)
or (mpf_status ='02' and mpb_status is null)
or(mpf_status='01' and mpb_status is null ))

and mid_preg_status is null
go


-- updated since I already handled the not mets above
update wtrak_pw_prep 
set mid_preg_status = case when mpf_status >2 and mid_preg_status is not null then mpf_status 
when mpfb_status >2  and mid_preg_status is not null then mpfb_status else mid_preg_status 
end 
from wtrak_pw_prep pw 


-- update wtrak_pw_prep 
-- set mid_preg_status = '2' 
-- --where sastatus != 1 -- and sadate < date at 22wks GA 
-- from wtrak_pw_prep pw1 left join 
-- safpw_mv sa on sa.uid = pw1.uid 
-- right join (
-- select s.uid, max(s.sadate) sadate from safpw_mv s
-- left join wtrak_pw_prep p on p.uid = s.uid 
-- where s.sadate < dateadd(week,22 ,p.uvf_lmp_date)
-- and cast(s.sastatus as int) not in (1)
-- group by s.uid 
-- ) a on a.uid = sa.uid and sa.sadate = a.sadate


-- When is this generating
-- figure out the ga where date is today (2024-10-15)
-- if ga current date < schedule_gen_date then code this as pending form 



print 'Pending a Mid - Pregnancy visit '
update wtrak_pw_prep 
set mid_preg_status = '6' 
--select w.uid, allocated_arm,saf_flow_status, w.mpf_status ,w.mpfb_status,w.bgoutc,w.uvf_lmp_date,w.psf_lmp_date,datediff(week,coalesce(w.uvf_lmp_date,w.psf_lmp_date),convert(smalldatetime,'2025-05-13',121)) gestation_age,s.schedule_gen_date,datediff(week,coalesce(w.uvf_lmp_date,w.psf_lmp_date),s.schedule_gen_date) ga_at_mpf ,mid_preg_status,l.* 
from wtrak_pw_prep w
left join pw_log1 l on w.uid =l.uid 
left join (select uid,schedule_gen_date from schedule_pw  where form_name='MPF') s on s.uid = l.uid 
where pef_consent =1
and mid_preg_status is null 
and saf_flow_status = 1
and convert(smalldatetime,'2025-05-13',121) < s.schedule_gen_date -- this form is pending (current date < schedule generation date)
and datediff(week,coalesce(w.uvf_lmp_date,w.psf_lmp_date),convert(smalldatetime,'2025-05-13',121)) < 40 -- ga date is < 40 (max week that an mpf has had)
and w.mpf_status is null and w.mpfb_status is null ---and bgoutc is null 


print ' No mid-pregnancy visit because woman had an outcome before the mid pregnancy visit was scheduled '
update wtrak_pw_prep 
set mid_preg_status = '3' 
--select w.uid, allocated_arm,saf_flow_status, w.mpf_status ,w.mpfb_status,w.bgoutc,w.bgdoutc,w.uvf_lmp_date,w.psf_lmp_date,datediff(week,coalesce(w.uvf_lmp_date,w.psf_lmp_date),convert(smalldatetime,'2025-05-13',121)) gestation_age,s.schedule_gen_date,datediff(week,coalesce(w.uvf_lmp_date,w.psf_lmp_date),s.schedule_gen_date) ga_at_mpf ,mid_preg_status,ga_at_first_saf,ga_at_mpf_gen,ga_at_mpf_done,current_ga,l.* 
from wtrak_pw_prep w
left join pw_log1 l on w.uid =l.uid 
left join (select uid,schedule_gen_date from schedule_pw  where form_name='MPF') s on s.uid = l.uid 
where pef_consent =1
and saf_flow_status = 1
and w.mpf_status is null and w.mpfb_status is null ---and bgoutc is null 
and 
bgdoutc <= convert(smalldatetime,s.schedule_gen_date,121) -- had an outcome mc sb before mpf was generated 

update wtrak_pw_prep 
set mid_preg_status = '66' 
--select * 
from wtrak_pw_prep pw
left join pw_log1 pl on pl.uid = pw.uid 
where rtrim(ltrim(pl.mpf_status)) = 'Refused to stay in the study'
and pw.saf_flow_status =1 
-- where pw.uid in (
-- '296837',
-- '226211',
-- '626325')





print 'adding the late pregnancy status where there is not reasoning in the lpf form itself '

-- print 'Discontinued supplementation at LPF '
-- update wtrak_pw_prep 
-- set late_preg_status = '8' -- Discontinued at PX LPF
-- --select *
-- from wtrak_pw_prep pw 
-- left join pw_log1 pl on pw.uid =pl.uid 
-- where Discontinued in('Discontinued','Disenrollment') and DISCNTD_Source = 'PX_Data_LPF'





print 'Outcome happened before LPF visit was scheduled'
update wtrak_pw_prep 
set late_preg_status = '3' -- Outcome happened before LPF visit was scheduled
-- select *
from wtrak_pw_prep pw 
where 
(mid_preg_status !=3 or mid_preg_status is null)
and saf_flow_status =1 
and lpf_status is null and lpb_status is null
and late_preg_status is null 
and bgdoutc <= lpf_schedule_date 

print 'LPF - not eligible for LPF yet '
update wtrak_pw_prep 
set late_preg_status = '6' -- Not Eligible for LPF yet
from wtrak_pw_prep pw 
--left join pw_log1 pl on pw.uid =pl.uid 
where lpf_schedule_date >= convert(smalldatetime,'2025-05-13',121)
and (mid_preg_status !=3 or mid_preg_status is null)
and saf_flow_status =1 and late_preg_status is null 
and late_preg_status is null 





print 'Discontinued after mid-pregnancy and before lpf visit '
update wtrak_pw_prep 
set late_preg_status = '7' -- Outcome happened after LPF visit was scheduled but no LPF visit occured
-- select *
from wtrak_pw_prep pw 
where 
(mid_preg_status !=3 or mid_preg_status is null)
and saf_flow_status =1 
and lpf_status is null and lpfb_status is null
and mid_preg_status = 8 -- discontinued at midpregnancy PX
and late_preg_status is null 
and bgdoutc > lpf_schedule_date -- outcome happened after lpf 




print 'Outcome happened after LPF visit was scheduled but no LPF visit occured '
update wtrak_pw_prep 
set late_preg_status = '4' -- Outcome happened after LPF visit was scheduled but no LPF visit occured
-- select *
from wtrak_pw_prep pw 
where 
(mid_preg_status !=3 or mid_preg_status is null)
and saf_flow_status =1 
and lpf_status is null and lpfb_status is null
and late_preg_status is null 
and bgdoutc > lpf_schedule_date -- outcome happened after lpf 




print 'Outcome happened on or before the day the LPFB was scheduled but no LPF visit occured '
update wtrak_pw_prep 
set late_preg_status = '9' -- Outcome happened after LPF visit but before LPFB occurred
-- select *
from wtrak_pw_prep pw 
where 
(mid_preg_status !=3 or mid_preg_status is null)
and saf_flow_status =1 
and lpf_status ='01' and lpfb_status is null
and late_preg_status is null 
and bgdoutc <= lpfb_schedule_date -- outcome happened on or before the day the lpfb was scheduled  



print 'Not met - LPF visit'
update wtrak_pw_prep 
set late_preg_status = '2' -- Outcome happened before LPF visit was scheduled
-- select *
from wtrak_pw_prep pw 
where 
((lpf_status ='01' and lpb_status ='2')
or (lpf_status ='01' and lpb_status is null)
or (lpf_status ='02' and lpb_status is null and mid_preg_status !='66')
)
and late_preg_status is null 



print 'Met - LPF visit'
update wtrak_pw_prep 
set late_preg_status = '1' -- Outcome happened before LPF visit was scheduled
-- select *
from wtrak_pw_prep pw 
where 
lpf_status ='01' and lpb_status ='1'
and late_preg_status is null 





print 'adding parity '
print 'create a parity table from the PEF '

if exists(select o.name from sysobjects o where o.name='live_born_cnt')
begin 
drop table live_born_cnt
end 
go 



select 
uid,
'1' as p_round,
pep1mm as pepmm,
pep1yy as pepyy,
pep1outc as pepoutc,
pep1kids as pepkids,
pep1sex as pepsex,
pep1vit as pepvit,
pep1sex1 as pepsex1,
pep1vit1 as pepvit1,
pep1sex2 as pepsex2,
pep1vit2 as pepvit2,
pep1sex3 as pepsex3,
pep1vit3 as pepvit3
into live_born_cnt
from pef_mv 
--where pep1kids is not null

union 

select 
uid,
'2' as p_round,
pep2mm as pepmm,
pep2yy as pepyy,
pep2outc as pepoutc,
pep2kids as pepkids,
pep2sex as pepsex,
pep2vit as pepvit,
pep2sex1 as pepsex1,
pep2vit1 as pepvit1,
pep2sex2 as pepsex2,
pep2vit2 as pepvit2,
pep2sex3 as pepsex3,
pep2vit3 as pepvit3
from pef_mv 
--where pep2kids is not null

union 

select 
uid,
'3' as p_round,
pep3mm as pepmm,
pep3yy as pepyy,
pep3outc as pepoutc,
pep3kids as pepkids,
pep3sex as pepsex,
pep3vit as pepvit,
pep3sex1 as pepsex1,
pep3vit1 as pepvit1,
pep3sex2 as pepsex2,
pep3vit2 as pepvit2,
pep3sex3 as pepsex3,
pep3vit3 as pepvit3
from pef_mv 
--where pep3kids is not null

union 

select 
uid,
'4' as p_round,
pep4mm as pepmm,
pep4yy as pepyy,
pep4outc as pepoutc,
pep4kids as pepkids,
pep4sex as pepsex,
pep4vit as pepvit,
pep4sex1 as pepsex1,
pep4vit1 as pepvit1,
pep4sex2 as pepsex2,
pep4vit2 as pepvit2,
pep4sex3 as pepsex3,
pep4vit3 as pepvit3
from pef_mv 
--where pep4kids is not null

union 

select 
uid,
'5' as p_round,
pep5mm as pepmm,
pep5yy as pepyy,
pep5outc as pepoutc,
pep5kids as pepkids,
pep5sex as pepsex,
pep5vit as pepvit,
pep5sex1 as pepsex1,
pep5vit1 as pepvit1,
pep5sex2 as pepsex2,
pep5vit2 as pepvit2,
pep5sex3 as pepsex3,
pep5vit3 as pepvit3
from pef_mv 
--where pep5kids is not null

union 

select 
uid,
'6' as p_round,
pep6mm as pepmm,
pep6yy as pepyy,
pep6outc as pepoutc,
pep6kids as pepkids,
pep6sex as pepsex,
pep6vit as pepvit,
pep6sex1 as pepsex1,
pep6vit1 as pepvit1,
pep6sex2 as pepsex2,
pep6vit2 as pepvit2,
pep6sex3 as pepsex3,
pep6vit3 as pepvit3
from pef_mv 
--where pep6kids is not null

union 

select 
uid,
'7' as p_round,
pep7mm as pepmm,
pep7yy as pepyy,
pep7outc as pepoutc,
pep7kids as pepkids,
pep7sex as pepsex,
pep7vit as pepvit,
pep7sex1 as pepsex1,
pep7vit1 as pepvit1,
pep7sex2 as pepsex2,
pep7vit2 as pepvit2,
pep7sex3 as pepsex3,
pep7vit3 as pepvit3
from pef_mv 
--where pep7kids is not null

union 

select 
uid,
'8' as p_round,
pep8mm as pepmm,
pep8yy as pepyy,
pep8outc as pepoutc,
pep8kids as pepkids,
pep8sex as pepsex,
pep8vit as pepvit,
pep8sex1 as pepsex1,
pep8vit1 as pepvit1,
pep8sex2 as pepsex2,
pep8vit2 as pepvit2,
pep8sex3 as pepsex3,
pep8vit3 as pepvit3
from pef_mv 
--where pep8kids is not null


union 

select 
uid,
'9' as p_round,
pep9mm as pepmm,
pep9yy as pepyy,
pep9outc as pepoutc,
pep9kids as pepkids,
pep9sex as pepsex,
pep9vit as pepvit,
pep9sex1 as pepsex1,
pep9vit1 as pepvit1,
pep9sex2 as pepsex2,
pep9vit2 as pepvit2,
pep9sex3 as pepsex3,
pep9vit3 as pepvit3
from pef_mv 
--where pep9kids is not null




update wtrak_pw_prep
set parity = n_lb 
from wtrak_pw_prep w
right join (
select uid,sum(n_lb) as n_lb from (
select uid, case when pepoutc=3 then 1 
when pepoutc=4 then 1 
else 0 
end as n_lb
from live_born_cnt) a 
group by uid ) b on b.uid = w.uid 




update wtrak_pw_prep
set gravidity = p.peprvprn 
from wtrak_pw_prep w
left join pef_mv p on p.uid = w.uid 



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



-- null as lmp_us,
-- null as ga_us,
-- null as bglmp,
-- null as bglmpru,
-- null as bgga,

-- vars from mindr_bgga_20250603
-- us_lmp us_lmp_dt
-- us_ga
-- psf_lmp psf_lmp_dt 
-- psf_ga 
-- bglmp - bglmprd_dt 
-- bglmpru
-- bgga_dy
-- bgga_wk 



print 'Now add the us_lmp and bglmp and bglmpru'


update wtrak_pw_prep
set lmp_us = case when bg.us_lmp_dt = convert(smalldatetime, '1900-01-01',121) then null else bg.us_lmp_dt end ,
ga_us = case when bg.us_ga='' then null else cast(bg.us_ga as decimal(10,6)) end,
bglmp = bg.bglmprd_dt, 
bglmpru = bg.bglmpru,
bgga_dy = case when bg.bgga_dy='' then null else cast(bg.bgga_dy as int) end ,
bgga = case when bg.bgga_wk = '' then null else cast(bg.bgga_wk as decimal(10,5)) end
from wtrak_pw_prep wt 
left join  mindr_bgga_20250603 bg on bg.uid = wt.uid 


  update wtrak_pw_prep 
  set 
  lsi = i.lsi
  from wtrak_pw_prep w
  left join indices_pw i on i.uid = w.uid 




print ' For the 3mop visits this was the inclusion criteria'
-- any woman with a child older than 205 days at enrollment start time '2025-02-01' was exluded from followup 

select distinct uid from (
select p.uid,k.childuid,fuw.selection_status,k.ibaf_status,k.fbaf_status,k.i1status,p.m1b_status,datediff(day,k.BGdob,'2025-02-01') agedays_3mop_elig
--, * 
from pregtrak p
left join kidtrak k on k.momuid = p.uid 
left join followup_women fuw on fuw.uid = p.uid 
where pef_consent=1
and datediff(day,k.BGdob,'2025-02-01') <=205 -- 210
and ((k.ibaf_status !=8 or k.ibaf_status is null ) and (k.fbaf_status!=8 or k.fbaf_status is null)) -- 204
) a --203 women 

print 'Add a flag for followup eligible women'



alter table wtrak_pw_prep
add fu_elig int 
go


update wtrak_pw_prep 
set fu_elig = 1
from wtrak_pw_prep w
right join (
select p.uid,fuw.selection_status,i.ibstatus,f.fbstatus,i1.i1status,p.m1b_status,datediff(day,p.bgdoutc,'2025-02-01') agedays_3mop_elig
--, * 
from wtrak_pw_prep p
left join ibaf_mv i on i.uid = p.uid 
left join fbaf_mv f on f.uid = p.uid 
left join i1mop_mv i1 on i1.uid = p.uid 
left join followup_women fuw on fuw.uid = p.uid 
left join mbaf_mv mb on mb.uid =p.uid 
where p.pef_consent=1
and datediff(day,p.bgdoutc,'2025-02-01') <=205 -- 210
and ((i.ibstatus !=8 or i.ibstatus is null ) and (f.fbstatus !=8 or f.fbstatus  is null)) -- 208
and mb.mblbn >0 --203
) m on m.uid = w.uid 


update wtrak_pw_prep 
set fu_elig = 6
from wtrak_pw_prep w
right join (
select p.uid,fuw.selection_status,i.ibstatus,f.fbstatus,i1.i1status,p.m1b_status,datediff(day,p.bgdoutc,'2025-02-01') agedays_3mop_elig
--, * 
from wtrak_pw_prep p
left join ibaf_mv i on i.uid = p.uid 
left join fbaf_mv f on f.uid = p.uid 
left join i1mop_mv i1 on i1.uid = p.uid 
left join followup_women fuw on fuw.uid = p.uid 
left join mbaf_mv mb on mb.uid =p.uid 
where p.pef_consent=1
and datediff(day,p.bgdoutc,'2025-02-01') <=205 -- 210
and ((i.ibstatus !=8 or i.ibstatus is null ) and (f.fbstatus !=8 or f.fbstatus  is null)) -- 208
and mb.mblbn =0 --203
) m on m.uid = w.uid 
where w.fu_elig is null

update wtrak_pw_prep 
set fu_elig = 8
from wtrak_pw_prep w
right join (
select p.uid,fuw.selection_status,i.ibstatus,f.fbstatus,i1.i1status,p.m1b_status,datediff(day,p.bgdoutc,'2025-02-01') agedays_3mop_elig
--, * 
from wtrak_pw_prep p
left join ibaf_mv i on i.uid = p.uid 
left join fbaf_mv f on f.uid = p.uid 
left join i1mop_mv i1 on i1.uid = p.uid 
left join followup_women fuw on fuw.uid = p.uid 
left join mbaf_mv mb on mb.uid =p.uid 
where p.pef_consent=1
and datediff(day,p.bgdoutc,'2025-02-01') <=205 -- 210
and (i.ibstatus =8 or f.fbstatus =8 ) -- 208
--and mb.mblbn >0 --203
) m on m.uid = w.uid 
where w.fu_elig is null


update wtrak_pw_prep 
set fu_elig = 9
from wtrak_pw_prep w
right join (
select p.uid,fuw.selection_status,i.ibstatus,f.fbstatus,i1.i1status,p.m1b_status,datediff(day,p.bgdoutc,'2025-02-01') agedays_3mop_elig
--, * 
from wtrak_pw_prep p
left join ibaf_mv i on i.uid = p.uid 
left join fbaf_mv f on f.uid = p.uid 
left join i1mop_mv i1 on i1.uid = p.uid 
left join followup_women fuw on fuw.uid = p.uid 
left join mbaf_mv mb on mb.uid =p.uid 
where p.pef_consent=1
and datediff(day,p.bgdoutc,'2025-02-01') >205 -- 210
--and ((i.ibstatus !=8 or i.ibstatus is null ) and (f.fbstatus !=8 or f.fbstatus  is null)) -- 208
--and mb.mblbn =0 --203
) m on m.uid = w.uid 
where w.fu_elig is null



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
-- allocated_arm,
case when allocated_arm = 'A' then 'Y'
when allocated_arm = 'B' then 'W'
when allocated_arm = 'C' then 'Z'
when allocated_arm = 'D' then 'X' end as 
allocated_arm,  /*keep*/
bnf_done_date,
bnf_status,
dod,
--we_date_min,
wef_consent,
wef_consent_src,
wef_rnd1_date,
wef_rnd2_date,
age_wef,
age_pef,
pef_eligable,
pef_status,
pef_done_date,
pef_consent,   /*keep*/
pef_consent_date,  /*keep*/
peb_date,
peb_time,
peb_meal_time,
peb_fast_time ,
peb_status,
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
lmp_us,
ga_us,
bglmp,
bglmpru,
bgga_dy,
bgga,
saf_done_date,
saf_past_order,
saf_status,
safstatus,
safdate,
last_safstatus,
last_safdate,
supp_status, /*keep*/
saf_flow_status, /*keep*/
mid_preg_status,
uvf_done_date,
uvf_status,
uvf_ga,
uvf_lmp_date,
ses_done_date,
ses_status,
mpf_done_date,  /*keep*/
mpf_status,  /*keep*/
mpb_date,
mpb_time,
mpb_meal_time,
mpb_fast_time ,
mpb_status,
mpfb_done_date,  /*keep*/
mpfb_status,  /*keep*/
lpf_done_date,  /*keep*/
lpf_status,  /*keep*/
lpb_date,
lpb_time,
lpb_meal_time,
lpb_fast_time ,
lpb_status,



late_preg_status,
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
m1b_date,
m1b_time,
m1b_meal_time,
m1b_fast_time ,
m1b_status,
m1b_bmspecimen,
m1b_blspecimen,
fu_elig,
m3b_date,
m3b_time,
m3b_meal_time,
m3b_fast_time,
m3b_status,
m3b_specimen,
m6b_date,
m6b_time,
m6b_meal_time,
m6b_fast_time ,
m6b_status,
m6b_specimen,
m6b_slvspecimen,
mopb_status,
mopb_done_date,
/*outcome_date,*/
/*outcome_status,*/
mpf_ga,
lmp_status,
/*ga_at_psfurt,*/
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
pcomp_bep,
parity,
gravidity,
cast(lsi as decimal(10,5)) as lsi
into wtrak_pw 
from wtrak_pw_prep 
where 
woman_status !=8 -- women who are duplicates
or woman_status is null


go 



print 'now generate a copy of the generate pregtrak do file'

if exists(select o.name from sysobjects o where o.name ='pregtrak' )
Begin 
drop table pregtrak
End 


SELECT
uid,
tlpin,
sector,
hhid,
/*woman_status,*/
bgdob as wom_dob,
/*age,*/
age_pef,
age_wef,
allocated_arm as arm_pw,
/*age_grp,*/
/*dobyy,*/
/*dobdd,*/
/*dobmm,*/
/*convert(smalldatetime,dod,121) as wom_dod, -- ez said no deaths is this true ?  - create a dod var to catch these*/ 
/*pef_eligable,*/
/*pef_eligible,*/
/*pef_status,*/
peconsent as pef_consent,
pedate as pef_date,
pefstatus as pef_status,
/*convert(smalldatetime,pef_done_date,121) as pef_done_date,*/
/*pef_consent,*/
/*convert(smalldatetime,pefb_done_date,121) as pefb_date,*/
/*pefb_status,*/
peb_date,
peb_time,
peb_meal_time,
peb_fast_time ,
peb_status,
/*psfstatus as psf_status,*/
/*psf_date,*/
/*last_psf_status,*/
/*last_psf_date,*/
/*psfurt,*/
psfurt_date as urtpos_psf,
/*ga_at_psfurt as ga_psf,*/
/*psflmp as lmp_psf,*/ -- excluded 20250604
/*convert(smalldatetime,psf_done_date,121) as psf_done_date,*/
/*psf_eligable,*/
/*convert(smalldatetime,psf_lmp_date,121) as psf_lmp_date,*/
/*psf_status,*/
/*psf_urt,*/
/*convert(smalldatetime,saf_done_date,121) as saf_done_date,*/
/*saf_past_order,*/
/*saf_status,*/
/*safdate,*/
/*last_safstatus,*/
/*convert(smalldatetime,last_safdate,121) as saf_date,*/
/*safstatus as saf_status,*/
/*uvf_done_date as uvf_date,*/
--------------- excluded these 20250604
/*uvf_status,*/
/*uvf_ga,*/
/*uvf_lmp_date,*/
/*lmp_us,*/
/*ga_us,*/
bglmp,
bglmpru,
--bgga_dy,
bgga,
bgoutc as outc,
/*bgoutcru as outcru,*/
bgoutcsrc as outcsrc,
/*bgwoutc as woutc,*/
bgdoutc as outcd,
parity,
gravidity,
/*supp_status,*/
saf_flow_status as ever_supp,
/*convert(smalldatetime,ses_done_date,121) as ses_date,*/
/*ses_status,*/
convert(smalldatetime,mpf_done_date,121) as mp_date,
mpf_status as mp_status,
mpb_date,
mpb_time,
mpb_meal_time,
mpb_fast_time,
mpb_status,
mid_preg_status,
lpfdate as lp_date,
lpfstatus as lp_status,
lpb_date,
lpb_time,
lpb_meal_time,
lpb_fast_time,
lpb_status,
late_preg_status,
bnfdate as bnf_date,
/*convert(smalldatetime,bnf_done_date,121) as bnf_date,*/
/*bnf_status,*/
/*bnfstatus,*/
/*convert(smalldatetime,fbaf_done_date,121) as fbaf_date,*/
/*fbaf_status,*/
/*convert(smalldatetime,ibaf_done_date,121) as ibaf_date,*/
/*ibaf_status,*/
/*convert(smalldatetime,mbaf_done_date,121) as mbaf_date,*/
/*mbaf_status,*/
mbafdate as mbaf_date ,
mbafstatus as mbaf_status,
/*convert(smalldatetime,i1mop_done_date,121) as i1mop_date,*/
/*i1mop_status,*/
convert(smalldatetime,m1mop_done_date,121) as m1mop_date,
m1mop_status,
m1b_date,
m1b_time,
m1b_meal_time,
m1b_fast_time,
m1b_status,
m1b_bmspecimen,
m1b_blspecimen,
fu_elig,
m3b_date,
m3b_time,
m3b_meal_time,
m3b_fast_time ,
m3b_status,
m3b_specimen,
m6b_date,
m6b_time,
m6b_meal_time,
m6b_fast_time ,
m6b_status,
m6b_specimen,
m6b_slvspecimen,
lsi
/*convert(smalldatetime,mopb_done_date,121) as mopb_date,*/
/*mopb_status,*/
/*convert(smalldatetime,outcome_date,121) as outcome_date,*/
/*outcome_status,*/
/*mpf_ga,*/
/*lmp_status,*/
/*chld1vitsts,*/
/*chld2vitsts,*/
/*chld3vitsts,*/
/*bgdoutcru as doutcru*/
/*fdose_date,*/
/*edose_date,*/
/*totdose_days,*/
/*totdose_mns,*/
/*totdose_bep,*/
/*pcomp_mns,*/
/*pcomp_bep*/
into pregtrak
FROM [mindr-live].dbo.wtrak_pw
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


print 'Baseline competed'
select * from wtrak_pw 
where peconsent = 1
and peb_status=1 --337 

print 'Baseline competed'
select allocated_arm ,count(*) from wtrak_pw 
where peconsent = 1
and peb_status=1 --337 
and allocated_arm is not null 
group by allocated_arm


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


select pefstatus,pef_eligible,pef_consent, count(*) from wtrak_pw 
where psfurt =1 
group by pefstatus,pef_eligible ,pef_consent
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




select allocated_arm,p.pestatus,p2.pebstatus, count(*) from wtrak_pw w 
left join pefb_mv p2 on p2.uid = w.uid 
left join pef_mv p on p.uid = w.uid 
where 
peconsent =1  and  -- consented 
allocated_arm is not null -- allocated to an arm 
group by allocated_arm,p.pestatus,p2.pebstatus
order by allocated_arm



select allocated_arm,p.pestatus,p2.pebstatus,supp_status, count(*) from wtrak_pw w 
left join pefb_mv p2 on p2.uid = w.uid 
left join pef_mv p on p.uid = w.uid 
where 
peconsent =1  and  -- consented 
allocated_arm is not null -- allocated to an arm 
group by allocated_arm,p.pestatus,p2.pebstatus,supp_status
order by allocated_arm





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


-- when saf_flow_status =62 then 'SAF - Discontinued due to PX Baseline measure'
--  when saf_flow_status =64 then 'UVF - Miscarriage'
--  when saf_flow_status =65 then 'UVF - Refused interview'
--  when saf_flow_status =71 then 'UVF - UVF Gestational age >= 17'



select * from wtrak_pw wt
right join 
(select distinct uid from safpw_mv 
where sastatus = 1 ) sa on sa.uid = wt.uid 
and pef_consent=1
-- n = 301 



print 'supplementation status (after baseline ) ' 
 select wt.allocated_arm,saf_flow_status,
 case when saf_flow_status =1 then 'SAF - Met'
 when saf_flow_status =2 then 'SAF - Not met'
 when saf_flow_status =3 then 'SAF - Met over phone'
 when saf_flow_status =4 then 'SAF - Miscarriage'
 when saf_flow_status =5 then 'SAF - Menstrual regulation '
 when saf_flow_status =6 then 'SAF - Live birth'
 when saf_flow_status =7 then 'SAF - Still birth'
 when saf_flow_status =8 then 'SAF - Not observed due to fasting'
 when saf_flow_status =60 then 'PEFB - Woman refused pregnancy enrollment blood'
 when saf_flow_status =61 then 'SAF - Discontinued due to USG GA > 16'
 when saf_flow_status =62 then 'SAF - Discontinued due to PX Baseline measure'
 when saf_flow_status =63 then 'UVF - Menstrual Regulation'
 when saf_flow_status =64 then 'UVF - Miscarriage'
 when saf_flow_status =65 then 'UVF - Refused interview'
 when saf_flow_status =66 then 'SAF - Refused'
 when saf_flow_status =67 then 'UVF - Permanent Move'
 when saf_flow_status =68 then 'UVF - Died'
 when saf_flow_status =69 then 'PX Data Midline Discontinuation of supplement'
 when saf_flow_status =70 then 'PX data LP Disenrollment'
 when saf_flow_status =71 then 'UVF - UVF Gestational age >= 17'
 when saf_flow_status =77 then 'SAF - Permanently moved'
 when saf_flow_status =88 then 'SAF - Died'
 end 
 as saf_flow_status_desc
 , count(*)

 from wtrak_pw wt
 left join pefb_mv pb on pb.uid = wt.uid 
 where 
 pef_consent =1 and pb.pebstatus ='01' 
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

-- print 'mid pregnancy visit status'
-- select allocated_arm,saf_flow_status, mpf_status ,mpb_status,w.bgoutc ,count(*) from wtrak_pw w
-- where pef_consent =1 
-- and saf_flow_status = 1
-- group by allocated_arm,saf_flow_status,mpf_status,mpb_status,w.bgoutc
-- with rollup 




print 'mid pregnancy visit status'
select allocated_arm,saf_flow_status,mpf_status,mpb_status,w.bgoutc,mid_preg_status,
case when mid_preg_status =66 then 'Refused Continuation in the Study - Mid-pregnancy visit'
when mid_preg_status =1 then 'Met - Mid-pregnancy visit'
when mid_preg_status =2 then 'Mid-pregnancy visits canceled'
when mid_preg_status =3 then 'Outcome happened before mid-pregnancy visit'
--when mid_preg_status is null and mpb_status = 2 and mpf_status ='01' then 'MPFB  - not met'
--when mid_preg_status is null and mpf_status ='02' then 'MPF  - not met'
when mid_preg_status =4 then 'Not met - Mid-pregnancy visit'
when mid_preg_status =8 then 'Discontinued at PX Midline'
end as mid_preg_desc ,count(*) 
from wtrak_pw w
where pef_consent =1 
and saf_flow_status = 1 and peb_status='01'
group by allocated_arm,saf_flow_status,mpf_status,mpb_status,w.bgoutc,mid_preg_status
with rollup 





-- case when mid_preg_status =66 then 'MPF Refused Continuation in the Study'
-- when mid_preg_status =2 then 'Mid-pregnancy visits canceled'
-- when mid_preg_status =3 then 'Outcome happned before MPF Mid-pregnancy visit'
-- when mid_preg_status =8 then 'Discontinued at PX Midline'
-- end as mid_preg_desc



print ' count of all mpf visits'
select allocated_arm, count(*) from wtrak_pw 
where  pef_consent =1 and 
saf_flow_status = 1 and 
mpf_status ='01' 
and mpb_status =1
group by allocated_arm
-- n = 269



-- print 'late pregnancy visit status'
-- select allocated_arm,lpf_status ,lpb_status ,count(*) from wtrak_pw w
-- left join lpf_mv l on l.uid = w.uid 
-- left join lpfb_mv lb on lb.uid = w.uid 
-- where
-- pef_consent =1 and 
-- mpf_status ='01' and mpb_status ='01'
-- group by allocated_arm,lpf_status,lpb_status 
-- with rollup 




print 'late pregnancy visit status'
select allocated_arm,lpf_status ,lpb_status ,bgoutc,count(*) from wtrak_pw w
left join lpf_mv l on l.uid = w.uid 
left join lpfb_mv lb on lb.uid = w.uid 
where
pef_consent =1 and 
mpf_status ='01' and mpb_status =1
group by allocated_arm,lpf_status,lpb_status ,bgoutc
with rollup 


print 'late pregnancy visit status'
select allocated_arm,lpf_status ,lpb_status ,bgoutc,late_preg_status,count(*) from wtrak_pw w
left join lpf_mv l on l.uid = w.uid 
left join lpfb_mv lb on lb.uid = w.uid 
where
pef_consent =1 and 
mpf_status ='01' and mpb_status =1
group by allocated_arm,lpf_status,lpb_status ,bgoutc,late_preg_status
with rollup 




print 'mid pregnancy visit status'
select allocated_arm,saf_flow_status, mpf_status,mpf_status,mpb_status,w.bgoutc ,mid_preg_status,count(*) from wtrak_pw w
where pef_consent =1 
and saf_flow_status = 1
--and allocated_arm ='B'
group by allocated_arm,saf_flow_status,mpf_status,mpb_status,w.bgoutc,mid_preg_status
with rollup 





print 'count of mpf '
select allocated_arm,bgoutc,count(*) from wtrak_pw w
left join lpf_mv l on l.uid = w.uid 
left join lpfb_mv lb on lb.uid = w.uid 
where
pef_consent =1 and 
mpf_status ='01' and mpb_status =1
--and lpfstatus ='01' and lpb_status = 1
--and bgoutc is not null 
group by allocated_arm,bgoutc
with rollup



print 'late pregnancy visit status'
select allocated_arm,bgoutc,mpf_status,mpb_status,mid_preg_status,lpf_status,lpb_status,late_preg_status,count(*) from wtrak_pw w
left join lpf_mv l on l.uid = w.uid 
left join lpfb_mv lb on lb.uid = w.uid 
where
pef_consent =1 
and 
saf_flow_status = 1--and 
--mpf_status ='01' and mpb_status =1
group by allocated_arm,bgoutc,mpf_status,mpb_status,mid_preg_status,lpf_status,lpb_status,late_preg_status
with rollup 





print 'Totals of LPF visits'
select allocated_arm, count(*) from wtrak_pw w
where
pef_consent =1 
and 
saf_flow_status = 1--and 
and lpf_status ='01' and lpb_status =1
group by allocated_arm



select * from wtrak_pw w
where
pef_consent =1 
and 
saf_flow_status = 1--and 
and lpf_status ='01' and lpb_status =1
and allocated_arm = 'W'



select * from wtrak_pw w
where
pef_consent =1 
and 
saf_flow_status = 1--and 
and lpf_status ='01' and lpb_status =1
and allocated_arm = 'X'

select * from wtrak_pw w
where
pef_consent =1 
and 
saf_flow_status = 1--and 
and lpf_status ='01' and lpb_status =1
and allocated_arm = 'Y'

select * from wtrak_pw w
where
pef_consent =1 
and 
saf_flow_status = 1--and 
and lpf_status ='01' and lpb_status =1
and allocated_arm = 'Z'




-- print 'outcomes after LPF'
-- select allocated_arm,lpfstatus ,lpb_status ,count(*) from wtrak_pw w
-- left join lpf_mv l on l.uid = w.uid 
-- left join lpfb_mv lb on lb.uid = w.uid 
-- where
-- pef_consent =1 and 
-- mpf_status ='01' 
-- and lpfstatus ='01' and lpb_status = '01'
-- group by allocated_arm,lpfstatus,lpb_status 
-- with rollup 


-- print 'count of total outcomes'
-- select allocated_arm,bgoutc,count(*) from wtrak_pw w
-- left join lpf_mv l on l.uid = w.uid 
-- left join lpfb_mv lb on lb.uid = w.uid 
-- where
-- pef_consent =1 and 
-- mpf_status ='01' 
-- and lpfstatus ='01' and lpb_status = '01'
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
pef_consent =1 
--and mpf_status ='01' 
--and 
and lpfstatus ='01' and lpb_status = 1
and bgoutc is not null 
group by allocated_arm,bgoutc
with rollup



select allocated_arm
--,bgoutc
,count(*) as count_completed from wtrak_pw w
left join m1mop_mv m1 on m1.uid = w.uid 
left join m1mopb_mv m1b on m1b.uid = w.uid 
where pef_consent =1 
and m1.m1status=1 and m1b.m1bstatus='01'
group by allocated_arm
with rollup


print ' women that had m1mop visit'

select allocated_arm
--,bgoutc
,count(*) as count_completed from wtrak_pw w
left join m1mop_mv m1 on m1.uid = w.uid 
left join m1mopb_mv m1b on m1b.uid = w.uid 
where pef_consent =1 
and m1.m1status=1 and m1b.m1bstatus='01'
group by allocated_arm
with rollup




print 'count of outcomes - after lpf '
select allocated_arm,bgoutc,count(*) from wtrak_pw w
left join lpf_mv l on l.uid = w.uid 
left join lpfb_mv lb on lb.uid = w.uid 
where
pef_consent =1 
--and mpf_status ='01' 
--and 
and lpfstatus ='01' and lpb_status = 1
and bgoutc is not null 
group by allocated_arm,bgoutc
with rollup



select allocated_arm
--,bgoutc
,count(*) as count_completed from wtrak_pw w
left join m1mop_mv m1 on m1.uid = w.uid 
left join m1mopb_mv m1b on m1b.uid = w.uid 
where pef_consent =1 
and m1.m1status=1 and m1b.m1bstatus='01'
group by allocated_arm
with rollup



-- select allocated_arm
-- --,bgoutc
-- ,count(*) as count_completed from wtrak_pw w
-- left join m1mop_mv m1 on m1.uid = w.uid 
-- left join m1mopb_mv m1b on m1b.uid = w.uid 
-- and m1b.m1bspecid1 is !=

select * from m1mopb_mv

-- where pef_consent =1 
-- and m1.m1status=1 and m1b.m1bstatus='01'
-- group by allocated_arm
-- with rollup




select allocated_arm
--,bgoutc
,count(*) as count_completed from wtrak_pw w
left join m36mop_mv m3 on m3.uid = w.uid 
left join m36mopb_mv m3b on m3b.uid = w.uid 
where pef_consent =1 
and m3.m3status=1 and m3b.m3bstatus=1
group by allocated_arm
with rollup




select allocated_arm
--,bgoutc
,count(*) as count_completed from wtrak_pw w
left join m36mop_mv m3 on m3.uid = w.uid 
left join m36mopb_mv m3b on m3b.uid = w.uid 
where pef_consent =1 
and m3.m3status=1 and m3b.m3bstatus=1
and w.m3b_specimen=1 /*volume is greater than 0 and there is a label assigned*/
group by allocated_arm
with rollup



select allocated_arm
--,bgoutc
,count(*) as count_completed from wtrak_pw w
left join m69mop_mv m6 on m6.uid = w.uid 
left join m69mopb_mv m6b on m6b.uid = w.uid 
where pef_consent =1 
and m6.m6status=1 and m6b.m6bstatus=1
and w.m6b_specimen=1 /*volume is greater than 0 and there is a label assigned*/
group by allocated_arm
with rollup


--m6b_slvspecimen


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





select allocated_arm
--,bgoutc

,lb.lpbstatus
,lp.lpstatus
,mb.mbstatus
,m1.m1status
,m1b.m1bstatus
,count(*) as consented_pef_women from wtrak_pw w
left join m1mop_mv m1 on m1.uid = w.uid 
left join m1mopb_mv m1b on m1b.uid = w.uid 
left join mbaf_mv mb on mb.uid = w.uid 
left join lpf_mv lp on lp.uid = w.uid 
left join lpfb_mv lb on lb.uid = w.uid 
where pef_consent =1 
--and m1.m1status=1 and m1b.m1bstatus='01'

group by allocated_arm
,lb.lpbstatus
,lp.lpstatus
,mb.mbstatus
,m1.m1status
,m1b.m1bstatus
with rollup






select allocated_arm
--,bgoutc

,lb.lpbstatus
,lp.lpstatus
,mb.mbstatus
,m1.m1status
,m1b.m1bstatus
,w.fu_elig
,m3.m3status
,m3b.m3bstatus
,count(*) as consented_pef_women from wtrak_pw w
left join mbaf_mv mb on mb.uid = w.uid 
left join m1mop_mv m1 on m1.uid = w.uid 
left join m1mopb_mv m1b on m1b.uid = w.uid 
left join m3mop_mv m3 on m3.uid = w.uid 
left join m3mopb_mv m3b on m3b.uid = w.uid 
left join lpf_mv lp on lp.uid = w.uid 
left join lpfb_mv lb on lb.uid = w.uid 
where pef_consent =1 
and m1.m1status=1 and m1b.m1bstatus='01'

group by allocated_arm
,lb.lpbstatus
,lp.lpstatus
,mb.mbstatus
,m1.m1status
,m1b.m1bstatus
,w.fu_elig
,m3.m3status
,m3b.m3bstatus
with rollup








select allocated_arm
,w.bgoutc

--,lb.lpbstatus
--,lp.lpstatus
,mb.mbstatus
,m1.m1status
,m1b.m1bstatus
,w.fu_elig
,m3.m3status
,m3b.m3bstatus
,m6.m6status
,m6b.m6bstatus
,count(*) as consented_pef_women from wtrak_pw w
left join mbaf_mv mb on mb.uid = w.uid 
left join m1mop_mv m1 on m1.uid = w.uid 
left join m1mopb_mv m1b on m1b.uid = w.uid 
left join m36mop_mv m3 on m3.uid = w.uid 
left join m36mopb_mv m3b on m3b.uid = w.uid 
left join m69mop_mv m6 on m6.uid = w.uid 
left join m69mopb_mv m6b on m6b.uid = w.uid 
left join lpf_mv lp on lp.uid = w.uid 
left join lpfb_mv lb on lb.uid = w.uid 
where pef_consent =1 
--and m1.m1status=1 and m1b.m1bstatus='01'

group by allocated_arm
--,lb.lpbstatus
--,lp.lpstatus
,w.bgoutc
,mb.mbstatus
,m1.m1status
,m1b.m1bstatus
,w.fu_elig
,m3.m3status
,m3b.m3bstatus
,m6.m6status
,m6b.m6bstatus
with rollup




select p.arm_pw,count(*) from pregtrak p 
left join m69mopb_mv m6 on m6.uid = p.uid 
where m6.m6bstatus =1
group by p.arm_pw
with rollup 
