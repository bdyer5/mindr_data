use [mindr-live]
go


print 'count of women available for PW trial'
select count(*) from woman_pw 
--4001
-- all except 691 have been transferred to the psf cohort 

print 'count of women available for WRA trial'
select count(*) from woman_wra
-- n= 607

if exists(select o.name from sysobjects o where o.name='wtrak_wra_prep')
begin 
drop table wtrak_wra_prep
end 
go 

select * into wtrak_wra_prep 
from woman_wra 


-- update wtrak_wra_prep 
-- set allocated_arm = null 
-- from wtrak_wra_prep 
-- where uid in ('005938','006949','019142','027872','028001')

print' this uid doesn''t exist in wra log 006949,027872,028001'
print 'these 3 refused urt at the wef_nwef' 
select * from wef_nwef_mv_prep
where uid in ('006949','027872','028001')


-- updating script so that it is keeping pending eleigible uids 

print 'For some reason a couple of uids were assigned an allocation that consented to wra trial but refused the urt test.'
update wtrak_wra_prep 
set allocated_arm = null 
from wtrak_wra_prep 
where uid not in (
select vf.uid from
all_wra_vf vf where 
vf.duplicate is null
and vf.form_order='1'
and vf.wvstatus='1'
and vf.wv_consent='1'
)


-- select wt.uid,wt.allocated_arm as wtallocated_arm,r.allocated_arm as rallocated_arm  from wtrak_wra_prep wt
-- left join (select uid ,allocated_arm from wra_rand where allocated_arm is not null) r 
-- on r.uid = wt.uid 

-- select * from wtrak_wra_prep 
-- where allocated_arm is not null 

print 'count of women randomized'
select count(*) from wtrak_wra_prep 
where allocated_arm is not null


print 'eligible and consented and enrolled'
select wom.allocated_arm,count(*) from wra_vf_mv wra 
right join wtrak_wra_prep wom on wom.uid = wra.uid 
where wra.wv_consent= 1 
group by wom.allocated_arm 



print 'Women who have started supplementation'
select wt.allocated_arm,saf.sastatus, count(*)
from wtrak_wra_prep wt
left join saf_wra_mv saf  on saf.uid = wt.uid 
right join 
(select uid , min(_submission_time)  _submission_time from saf_wra_mv
group by uid) a on a.uid = saf.uid and a._submission_time = saf._submission_time 
where wt.allocated_arm is not null
and wt.saf_done_date is not null
group by wt.allocated_arm, saf.sastatus 
with rollup 

-- print 'discontinued at baseline'
-- select * from wra_log 
-- where discntd_source = 'PX_Data_Baseline'

alter table wtrak_wra_prep
add discnt char(10) null
go 

alter table wtrak_wra_prep
add supplementation_status char(2) null
go 

alter table wtrak_wra_prep
add age_date smalldatetime null 
go 

alter table wtrak_wra_prep
add age_wef decimal(10,2) null
go 

alter table wtrak_wra_prep
add age_wra decimal(10,2) null
go 

alter table wtrak_wra_prep
add wef_consent smalldatetime null
go 

alter table wtrak_wra_prep
add wef_consent_src varchar(10) null 
go 

alter table wtrak_wra_prep
add wef_rnd1_date smalldatetime null 
go 

alter table wtrak_wra_prep
add wef_rnd2_date smalldatetime null 
go 

alter table wtrak_wra_prep
add wra_consent_date smalldatetime null
go 


alter table wtrak_wra_prep
add wra_consent integer null
go 


alter table wtrak_wra_prep
add safstatus int null
go 

alter table wtrak_wra_prep
add safdate smalldatetime null
go 



alter table wtrak_wra_prep
add wvfe_status int null
go 

alter table wtrak_wra_prep
add wvfe_date smalldatetime null
go 


alter table wtrak_wra_prep
add wvf1_status int null
go 

alter table wtrak_wra_prep
add wvf1_date smalldatetime null
go 


alter table wtrak_wra_prep
add wvf3_status int null
go 

alter table wtrak_wra_prep
add wvf3_date smalldatetime null
go 


alter table wtrak_wra_prep
add web_status int null
go 

alter table wtrak_wra_prep
add web_date smalldatetime null
go 

alter table wtrak_wra_prep
add web_time datetime null
go 

alter table wtrak_wra_prep
add web_meal_time datetime null
go 

alter table wtrak_wra_prep
add web_fast_time decimal(10,2) null
go 

alter table wtrak_wra_prep
add w1b_status int null
go 

alter table wtrak_wra_prep
add w1b_date smalldatetime null
go 

alter table wtrak_wra_prep
add w1b_time datetime null
go 

alter table wtrak_wra_prep
add w1b_meal_time datetime null
go 

alter table wtrak_wra_prep
add w1b_fast_time decimal(10,2) null
go 

alter table wtrak_wra_prep
add mid_study_status int null
go 


alter table wtrak_wra_prep
add w3b_status int null
go 


alter table wtrak_wra_prep
add w3b_date smalldatetime null
go 

alter table wtrak_wra_prep
add w3b_time datetime null
go 

alter table wtrak_wra_prep
add w3b_meal_time datetime null
go 

alter table wtrak_wra_prep
add w3b_fast_time decimal(10,2) null
go 

alter table wtrak_wra_prep
add end_study_status int null
go 


alter table wtrak_wra_prep
add sesstatus int null
go 


alter table wtrak_wra_prep
add sesdate smalldatetime null
go 


alter table wtrak_wra_prep
add dr1_status int null
go 


alter table wtrak_wra_prep
add dr1_date smalldatetime null
go 


alter table wtrak_wra_prep
add dr2_status int null
go 


alter table wtrak_wra_prep
add dr2_date smalldatetime null
go 


alter table wtrak_wra_prep
add dr3_status int null
go 


alter table wtrak_wra_prep
add dr3_date smalldatetime null
go 

alter table wtrak_wra_prep 
add suf1date smalldatetime null 
go

alter table wtrak_wra_prep 
add suf1status int null 
go

alter table wtrak_wra_prep 
add suf1urine int null 
go

alter table wtrak_wra_prep 
add suf1stool int null 
go

alter table wtrak_wra_prep 
add suf2date smalldatetime null 
go

alter table wtrak_wra_prep 
add suf2status int null 
go

alter table wtrak_wra_prep 
add suf2urine int null 
go


alter table wtrak_wra_prep 
add suf3date smalldatetime null 
go

alter table wtrak_wra_prep 
add suf3status int null 
go

alter table wtrak_wra_prep 
add suf3urine int null 
go

alter table wtrak_wra_prep 
add suf3stool int null 
go


alter table wtrak_wra_prep 
add dobyy char(4)
go 

alter table wtrak_wra_prep 
add dobdd char(2)
go 

alter table wtrak_wra_prep 
add dobmm char(2)
go 

alter table wtrak_wra_prep 
add bgdob smalldatetime
go 

alter table wtrak_wra_prep 
add pxdate_bl smalldatetime
go 

alter table wtrak_wra_prep 
add pxdate_ml smalldatetime
go 


alter table wtrak_wra_prep 
add fdose_date smalldatetime
go 

alter table wtrak_wra_prep 
add edose_date smalldatetime
go 


alter table wtrak_wra_prep 
add totdose_days decimal(10,2)
go 

alter table wtrak_wra_prep 
add totdose_mns decimal(10,2)
go 

alter table wtrak_wra_prep 
add totdose_bep decimal(10,2)
go 

alter table wtrak_wra_prep 
add pcomp_mns decimal(10,2)
go 

alter table wtrak_wra_prep 
add pcomp_bep decimal(10,2)
go 



if exists (select o.name from sysobjects o where o.name='neser')
begin
	drop table neser
end 

select *,
ROW_NUMBER() OVER (PARTITION BY uid ORDER BY eserdate ASC) AS counter into neser from all_eser_wra
where uid in (select rp.uid from all_eser_wra rp where rpdesc =1)
go 








-- there aren't any women that died , PM, or refused in saf so no need to add this yet. 
-- 01	Met
-- 02	Not met
-- 03	Met over phone
-- 08	Not observed due to fasting
-- 66	Refused
-- 77	Permanently moved
-- 88	Died


-- update wtrak_wra_prep 
-- set supplementation_status = '66'
-- from  wtrak_wra_prep wt 
-- where discnt = 'bl'

--select wt.uid ,
update wtrak_wra_prep 
set safstatus =  wv.sastatus ,
safdate = wv.sadate
from  wtrak_wra_prep wt 
left join (select uid,sastatus,min(sadate) sadate from saf_wra_mv 
where cast(sastatus as int) =1 and duplicate is null
group by uid,sastatus ) wv on wv.uid = wt.uid 


print ' update the wtrak where there are no met status and get the first status for that woman that is''nt a met status'
update wtrak_wra_prep 
set safstatus =  s2.sastatus ,
safdate = s2.sadate
from  wtrak_wra_prep wt 
left join saf_wra_mv s2 on s2.uid = wt.uid 
left join (select uid, min(sadate) sadate  from saf_wra_mv 
group by uid) s1  on s1.uid = s2.uid and s2.sadate = s1.sadate 
where wt.safstatus is null 



update wtrak_wra_prep 
--select wt.uid ,
set wvfe_status = wv.wvestatus ,
 wvfe_date = wv.wvedate
from  wtrak_wra_prep wt 
left join wravf_e_mv wv on wv.uid = wt.uid 
where wt.allocated_arm is not null

update wtrak_wra_prep 
--select wt.uid ,
set wvf1_status = wv.wvmstatus,
wvf1_date = wv.wvmdate
from  wtrak_wra_prep wt 
left join wravf_m_mv wv on wv.uid = wt.uid 
where wt.allocated_arm is not null
--and supplementation_status = '01'

update wtrak_wra_prep 
--select wt.uid ,
set wvf3_status = wv.wvfstatus ,
 wvf3_date = wv.wvfdate
from  wtrak_wra_prep wt 
left join wravf_f_mv wv on wv.uid = wt.uid 
where wt.allocated_arm is not null
--and supplementation_status = '01'

update wtrak_wra_prep 
--select wt.uid ,
set 
 web_date = we.webdate
,web_time = convert(datetime,substring(convert(varchar,webdate,121),1,10)+' '+ substring(convert(varchar,webbldtime,121),1,10)) 
,web_meal_time = convert(datetime,substring(convert(varchar,webmealdate,121),1,10)+' '+ substring(convert(varchar,webmealtime,121),1,10)) 
,web_fast_time  = datediff(minute,convert(datetime,substring(convert(varchar,webmealdate,121),1,10)+' '+ substring(convert(varchar,webmealtime,121),1,10)) 
,convert(datetime,substring(convert(varchar,webdate,121),1,10)+' '+ substring(convert(varchar,webbldtime,121),1,10))) 
,web_status = we.webstatus
from  wtrak_wra_prep wt 
left join wra_eb_mv we on we.uid = wt.uid 
where wt.allocated_arm is not null
--and supplementation_status = '01'

update wtrak_wra_prep 
--select wt.uid ,
set w1b_date = w1.w1bdate
,w1b_time = convert(datetime,substring(convert(varchar,w1.w1bdate,121),1,10)+' '+ substring(convert(varchar,w1.w1bbldtime,121),1,10)) 
,w1b_meal_time = convert(datetime,substring(convert(varchar,w1.w1bmealdate,121),1,10)+' '+ substring(convert(varchar,w1.w1bmealtime,121),1,10)) 
,w1b_fast_time  = datediff(minute,convert(datetime,substring(convert(varchar,w1.w1bmealdate,121),1,10)+' '+ substring(convert(varchar,w1.w1bmealtime,121),1,10)) 
,convert(datetime,substring(convert(varchar,w1.w1bdate,121),1,10)+' '+ substring(convert(varchar,w1.w1bbldtime,121),1,10))) 
,w1b_status = w1.w1bstatus
from  wtrak_wra_prep wt 
left join wra_1b_mv w1 on w1.uid = wt.uid 
where wt.allocated_arm is not null
--and supplementation_status = '01'



update wtrak_wra_prep 
set discnt = a.assign
from wtrak_wra_prep w
right join 
(
select rp.uid,convert(smalldatetime,rp.eserdate,121) as eserdate
,
case when rp.eserdate > w.wvfe_date and  (rp.eserdate < w.wvf1_date or w.wvf1_date is null)  then 'bl'
when la.[counter]=2 then 'ml' 
when rp.uid ='889326' then 'bl' -- uid px baseline sample was used to make RP decision not ml sample 
when rp.eserdate>= w.wvf1_date then 'ml' else 'bl' end as assign
--,w.discnt
--,w.saf_status
--,rp.rpdesc,la.counter
--,w.wravfe
--,w.* 
from all_eser_wra rp
right join wtrak_wra_prep w on w.uid = rp.uid 
--left join (select uid from neser where counter=2 and rpdesc=1) 
left join (select *  from neser where rpdesc=1 ) la on la.uid =rp.uid 
where rp.rpdesc =1 
and rp.eserdate > w.wvfe_date 
 ) a on a.uid = w.uid 



-- select assign,count(*) from 
-- (
-- select rp.uid,convert(smalldatetime,rp.eserdate,121) as eserdate
-- ,
-- case when rp.eserdate > w.wb_date and  (rp.eserdate < w.wm_date or w.wm_date is null)  then 'bl'
-- when la.[counter]=2 then 'ml' 
-- when rp.uid ='889326' then 'bl' -- uid px baseline sample was used to make RP decision not ml sample 
-- when rp.eserdate>= w.wm_date then 'ml' else 'bl' end as assign
-- ,w.discnt
-- ,w.saf_status
-- ,rp.rpdesc,la.counter
-- --,w.wravfe
-- --,w.* 
-- from all_eser_wra rp
-- right join wtrak_wra w on w.uid = rp.uid 
-- --left join (select uid from neser where counter=2 and rpdesc=1) 
-- left join (select *  from neser where rpdesc=1 ) la on la.uid =rp.uid 
-- where rp.rpdesc =1 
-- and rp.eserdate > w.wb_date 
-- --and ( w.wm_date is null or la.counter )
-- order by 
-- case when rp.eserdate > w.wb_date and  (rp.eserdate < w.wm_date or w.wm_date is null)  then 'bl'
-- when la.[counter]=2 then 'ml' 
-- when rp.eserdate>= w.wm_date then 'ml' else 'bl' end 



-- commented out on 20241218 --- not using wra_log sticking with pulling from all_eser 
-- update wtrak_wra_prep 
-- set discnt = 'bl'
-- from  wtrak_wra_prep wt 
-- left join wra_log  wl on wl.uid =wt.uid 
-- where discntd_source = 'PX_Data_Baseline'

-- update wtrak_wra_prep 
-- set discnt = 'ml'
-- from  wtrak_wra_prep wt 
-- left join wra_log  wl on wl.uid =wt.uid 
-- where discntd_source = 'PX_Data_Midline'

update wtrak_wra_prep 
set supplementation_status = a.sastatus
from  wtrak_wra_prep wt 
right join 
(select uid , min(sastatus) sastatus from saf_wra_mv
group by uid 
) a on a.uid = wt.uid 


update wtrak_wra_prep 
set supplementation_status = '09'
from  wtrak_wra_prep wt 
where discnt = 'bl'



update wtrak_wra_prep 
--select wt.uid ,
set mid_study_status = case when wravf_mid_status ='Pregnant' then 4 
when wravf_mid_status = 'Not_eligible_yet' and wvf1_status is null 
then 5 end from wtrak_wra_prep  wt
left join WRA_Log wl on wl.uid = wt.uid 
 where wt.allocated_arm is not null
and supplementation_status = '01' and (wvf1_status !=1  or wvf1_status  is null)






update wtrak_wra_prep 
--select wt.uid ,
set w3b_date = w3.w3bdate
,w3b_time = convert(datetime,substring(convert(varchar,w3.w3bdate,121),1,10)+' '+ substring(convert(varchar,w3.w3bbldtime,121),1,10)) 
,w3b_meal_time = convert(datetime,substring(convert(varchar,w3.w3bmealdate,121),1,10)+' '+ substring(convert(varchar,w3.w3bmealtime,121),1,10)) 
,w3b_fast_time  = datediff(minute,convert(datetime,substring(convert(varchar,w3.w3bmealdate,121),1,10)+' '+ substring(convert(varchar,w3.w3bmealtime,121),1,10)) 
,convert(datetime,substring(convert(varchar,w3.w3bdate,121),1,10)+' '+ substring(convert(varchar,w3.w3bbldtime,121),1,10))) 
,w3b_status = w3.w3bstatus
from  wtrak_wra_prep wt 
left join wra_3b_mv w3 on w3.uid = wt.uid 
where wt.allocated_arm is not null
and supplementation_status = '01'

-- update wtrak_wra_prep 
-- --select wt.uid ,
-- set end_study_status = case when wravf_end_status ='Pending'  and wvf3_status is null then 0
-- when wravf_end_status ='Pregnant' then 4 
-- when wravf_end_status = 'Not_eligible_yet' and wvf3_status is null 
-- then 5 
-- when wravf_end_status = 'Discontinued' and wvf3_status is null 
-- then 8 end 
-- from wtrak_wra_prep  wt
-- left join WRA_Log wl on wl.uid = wt.uid 
--  where wt.allocated_arm is not null
-- and supplementation_status = '01' and (wvf3_status !=1  or wvf3_status  is null)
-- and  (w3b_status !=1  or w3b_status  is null)

update wtrak_wra_prep 
--select wt.uid ,
set end_study_status = case when wravf_end_status ='Pending'  and wvf3_status is null then 0
when wravf_end_status ='Pregnant' then 4 
when wravf_end_status = 'Not_eligible_yet' and wvf3_status is null 
then 5 
when wravf_end_status = 'Discontinued' and wvf3_status is null 
then 8 end 
from wtrak_wra_prep  wt
left join WRA_Log wl on wl.uid = wt.uid 
 where wt.allocated_arm is not null
and supplementation_status = '01' and (wvf3_status !=1  or wvf3_status  is null)
and  (w3b_status !=1  or w3b_status  is null)


-- select * from px_data_dashboard_WRA
-- where disenrolled =1 or discontinued =1 
-- Brian need to crosscheck this 




update wtrak_wra_prep 
--select wt.uid ,
set sesstatus = 
ss.ssstatus ,
 sesdate = ss.ssdate
from  wtrak_wra_prep wt 
left join all_ses_wra ss on ss.uid = wt.uid 
where wt.allocated_arm is not null

update wtrak_wra_prep 
--select wt.uid ,
set dr1_status =dr.drstatus ,
dr1_date = dr.drdate
from  wtrak_wra_prep wt 
left join all_drf_wra dr on dr.uid = wt.uid 
where formorder =1  and duplicate is null


update wtrak_wra_prep 
--select wt.uid ,
set dr2_status =dr.drstatus ,
dr2_date = dr.drdate
from  wtrak_wra_prep wt 
left join all_drf_wra dr on dr.uid = wt.uid 
where formorder =2  and duplicate is null


update wtrak_wra_prep 
--select wt.uid ,
set dr3_status =dr.drstatus ,
dr3_date = dr.drdate
from  wtrak_wra_prep wt 
left join all_drf_wra dr on dr.uid = wt.uid 
where formorder =3  and duplicate is null

update wtrak_wra_prep 
--select wt.uid ,
set suf1date = s.sudate,
suf1status = s.sustatus,
suf1urine = s.suucol,
suf1stool = s.suscol
from wtrak_wra_prep wt 
left join suf_wra_mv s on s.uid = wt.uid 
where suvisit =1


update wtrak_wra_prep 
--select wt.uid ,
set suf2date = s.sudate,
suf2status = s.sustatus,
suf2urine = s.suucol

-- suf2stool = s.suscol
from wtrak_wra_prep wt 
left join suf_wra_mv s on s.uid = wt.uid 
where suvisit =2


update wtrak_wra_prep 
--select wt.uid ,
set suf3date = s.sudate,
suf3status = s.sustatus,
suf3urine = s.suucol,
suf3stool = s.suscol
from wtrak_wra_prep wt 
left join suf_wra_mv s on s.uid = wt.uid 
where suvisit =3


print 'update dob values from person table and nwef and clean up the month and days'
update wtrak_wra_prep 
set dobyy = case when isdate(nw.nwedobdate) =1  then substring(convert(nvarchar,nw.nwedobdate,121),1,4) when nw.nwedobyy !=9999 and nw.nwedobyy is not null then nw.nwedobyy when trim(p.dobyy)='' or trim(p.dobyy)='9999' then null else p.dobyy end, 
dobmm = case when nw.nwedobmm !=99 and nw.nwedobmm is not null then nw.nwedobmm when trim(p.dobmm)='' or trim(p.dobmm)='99' or trim(p.dobmm)='00' or trim(p.dobmm)='$$' then null else p.dobmm end ,
dobdd = case when trim(nw.nwedobdd) !='99' and nw.nwedobdd is not null then nw.nwedobdd when trim(p.dobdd)='' or trim(p.dobdd)='99' or trim(p.dobdd)='00' or trim(p.dobdd)='$$' then null else p.dobdd end 
from wtrak_wra_prep w
left join shapla.dbo.person p on p.uid = w.uid 
left join [mindr-live].dbo.nwef_mv_prep nw on nw.uid =w.uid



update wtrak_wra_prep 
set dobmm = case when dobmm is null then '06' else dobmm end 
,dobdd= case when dobdd is null then '15' else dobdd end 
from wtrak_wra_prep w

update wtrak_wra_prep 
set bgdob = convert(smalldatetime, dobyy+'-'+dobmm+'-'+dobdd)






update wtrak_wra_prep 
set wef_consent = wp.wedate
from wtrak_wra_prep wt 
right join (select uid, min(wedate) wedate from wef_nwef_mv_prep wp
where westatus =1 and wef_consent =1 
group by uid) wp on wp.uid = wt.uid 
go 

update wtrak_wra_prep 
set wef_consent_src = wef_src
from wtrak_wra_prep wt 
right join 
(select p.uid, wef_src from wef_nwef_mv_prep p
left join (select uid,min(wedate) wedate from wef_nwef_mv_prep wp
where westatus =1 and wef_consent =1 -- 7339
group by uid ) a on a.uid = p.uid and a.wedate = p.wedate 
where p.westatus =1 and p.wef_consent =1
and p.uid is not null and a.uid is not null ) wp on wp.uid = wt.uid 


update wtrak_wra_prep 
set wef_rnd1_date = convert(smalldatetime,'2023-03-20',121)
from wtrak_wra_prep 

update wtrak_wra_prep 
set wef_rnd2_date = convert(smalldatetime,'2023-09-10',121)
from wtrak_wra_prep 
go


update wtrak_wra_prep 
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
from wtrak_wra_prep
where wef_consent_src like 'wef%'


update wtrak_wra_prep 
set age_wef = cast(datediff(day,bgdob,wef_consent) as decimal(10,2)) / 365
from wtrak_wra_prep 
where wef_consent_src like 'nwef%'


print 'identifying and updating some of the close 36 ages that are actually 35 '
update wtrak_wra_prep 
set age_wef = 
case when cast(substring(convert(varchar,w.age_date,120),1,4) as numeric) - cast(substring(convert(varchar,w.bgdob,120),1,4) as numeric) =36 and 
cast(substring(convert(varchar,w.age_date,120),6,2) as numeric) - cast(substring(convert(varchar,w.bgdob,120),6,2) as numeric) <0 then 35 
when cast(substring(convert(varchar,w.age_date,120),1,4) as numeric) - cast(substring(convert(varchar,w.bgdob,120),1,4) as numeric) =36 and 
cast(substring(convert(varchar,w.age_date,120),6,2) as numeric) - cast(substring(convert(varchar,w.bgdob,120),6,2) as numeric)  = 0 and 
cast(substring(convert(varchar,w.age_date,120),9,2) as numeric) - cast(substring(convert(varchar,w.bgdob,120),9,2) as numeric) < 0 then 35 else 
w.age_wef end 
from wtrak_wra_prep w
where wef_consent_src like 'wef%'
and age_wef >=36

print 'Add WRA enrollment consent'

update wtrak_wra_prep
set wra_consent = wc.wv_consent
from wtrak_wra_prep w
right join (select uid,wv_consent,max(wvdate) wvdate from wra_vf_mv
where wv_consent is not null 
group by uid ,wv_consent) wc on w.uid = wc.uid 




update wtrak_wra_prep 
set wra_consent_date = wc.wvdate
from wtrak_wra_prep w
right join (select uid,wvdate  from wra_vf_mv
where wv_consent =1) wc on w.uid = wc.uid 




update wtrak_wra_prep 
set age_wra = cast(datediff(day,bgdob,wra_consent_date) as decimal(10,2)) / 365.25
from wtrak_wra_prep


print 'identifying and updating some of the close 36 ages that are actually 35 '
update wtrak_wra_prep 
set age_wra = 
case when cast(substring(convert(varchar,w.wra_consent_date,120),1,4) as numeric) - cast(substring(convert(varchar,w.bgdob,120),1,4) as numeric) =36 and 
cast(substring(convert(varchar,w.wra_consent_date,120),6,2) as numeric) - cast(substring(convert(varchar,w.bgdob,120),6,2) as numeric) <0 then 35 
when cast(substring(convert(varchar,w.wra_consent_date,120),1,4) as numeric) - cast(substring(convert(varchar,w.bgdob,120),1,4) as numeric) =36 and 
cast(substring(convert(varchar,w.wra_consent_date,120),6,2) as numeric) - cast(substring(convert(varchar,w.bgdob,120),6,2) as numeric)  = 0 and 
cast(substring(convert(varchar,w.wra_consent_date,120),9,2) as numeric) - cast(substring(convert(varchar,w.bgdob,120),9,2) as numeric) < 0 then 35 else 
w.age_wra end 
from wtrak_wra_prep w
where --wef_consent_src like 'wef%'
--and 
age_wra >=36



update wtrak_wra_prep 
--select wt.uid ,
set pxdate_bl = p.[date]
from wtrak_wra_prep wt 
left join px_data p on p.uid = wt.uid 
where p.visit_Type ='Baseline' and trial = 'WRA'

update wtrak_wra_prep 
--select wt.uid ,
set pxdate_ml = p.[date]
from wtrak_wra_prep wt 
left join px_data p on p.uid = wt.uid 
where p.visit_Type ='Midline' and trial = 'WRA'


print 'adding compliance fields from Sujan''s dta files '

-- update wtrak_wra_prep 
-- set fdose_date = c.fdose_date,
--       edose_date = c.edose_date,
--       totdose_days = c.totdose_days,
--       totdose_mns = c.totdose_mns,
--       totdose_bep = c.totdose_bep,
--       pcomp_mns = c.pcomp_mns,
--       pcomp_bep = c.pcomp_bep
-- from wtrak_wra_prep wt 
-- left join mindr_wra_compliance_20240828 c on c.uid = wt.uid 


update wtrak_wra_prep 
set fdose_date = c.fdose_date,
      edose_date = c.edose_date,
      totdose_days = c.totdose_days,
      totdose_mns = c.totdose_mns,
      totdose_bep = c.totdose_bep,
      pcomp_mns = c.pcomp_mns,
      pcomp_bep = c.pcomp_bep
from wtrak_wra_prep wt 
left join mindr_wra_compliance_20241015 c on c.uid = wt.uid 




if exists(select o.name from sysobjects o where o.name='wtrak_wra')
begin 
drop table wtrak_wra
end 
go 


select 
uid,
tlpin,
sector,
hhid,

bgdob as wom_dob,
age_wef, -- pending
age_wra, -- pending
allocated_arm as arm_wra,
-- case when allocated_arm = 'A' then 'Y'
-- when allocated_arm = 'B' then 'W'
-- when allocated_arm = 'C' then 'Z'
-- when allocated_arm = 'D' then 'X' end as 
-- arm_wra,  /*keep*/

--dod,
wra_consent as consent,
wra_consent_date as consent_date,
null as lsi, -- pending 
wvfe_date as wb_date,
wvfe_status as wb_status,
web_date as wbb_date,
web_time as wbb_time,
web_meal_time as wbb_meal_time,
web_fast_time as wbb_fast_time,
web_status as wbb_status,
wvf1_date as wm_date,
wvf1_status as wm_status,
w1b_date as wmb_date,
w1b_time as wmb_time,
w1b_meal_time as wmb_meal_time,
w1b_fast_time as wmb_fast_time,
w1b_status as wmb_status,
mid_study_status,
wvf3_date as we_date,
wvf3_status as we_status,
w3b_date as web_date,
w3b_time as web_time,
w3b_meal_time as web_meal_time,
w3b_fast_time as web_fast_time,
w3b_status as web_status,
end_study_status,
sesdate  as ses_date,
sesstatus as ses_status,
safdate as saf_date,
safstatus as saf_status,
supplementation_status as supp_status,
null as adh_mns,
null as adh_bep,

-- dr1_date as drf1_date,
-- dr1_status as drf1_status,
-- dr2_date as drf2_date,
-- dr2_status as drf2_status,
-- dr3_date as drf3_date,
-- dr3_status as drf3_status,
-- suf1date as suf1_date,
-- suf1status as suf1_status,
-- suf1urine as suf1_urine,
-- suf1stool as suf1_stool,
-- suf2date as suf2_date,
-- suf2status as suf2_status,
-- suf2urine as suf2_urine,
-- suf3date as suf3_date,
-- suf3status as suf3_status,
-- suf3urine as suf3_urine,
-- suf3stool as suf3_stool,


/*drf1_complete,*/
/*drf1_done_date,*/
/*drf1_status,*/
/*drf2_done_date,*/
/*drf2_status,*/
/*drf3_done_date,*/
/*drf3_status,*/
/*enroll_id_age,*/
/*enroll_id_overall,*/
/*husband_name,*/
/*mobile,*/
/*rpt_drf_eligible,*/
/*sadf1,*/
/*sadfp1,*/
/*saf_done_date,*/
/*saf_past_order,*/
/*saf_start,*/
/*saf_status,*/
/* selection_status,*/
/* serf_14d_done_date,*/
/* serf_14d_saf_stop,*/
/* serf_14d_status,*/
/* serf_7d_done_date,*/
/* serf_7d_saf_stop,*/
/* serf_7d_status,*/
/* serf_decision,*/
/* serf_done_date,*/
/* serf_end_date,*/
/* serf_hv_done_date,*/
/* serf_hv_saf_stop,*/
/* serf_hv_status,*/
/* serf_saf_stop,*/
/* serf_start_date,*/
/* serf_status,*/
/*ses_done_date,*/
/*ses_status,*/
-- stool_cal_date_suf1,
-- stool_cal_date_suf3,
-- stool_cal_status_suf1,
-- stool_cal_status_suf3,
-- sudf1_done_date,
-- sudf1_status,
-- sudf2_done_date,
-- sudf2_status,
-- sudf3_done_date,
-- sudf3_status,
-- suf1_done_date,
-- suf1_status,
-- suf2_done_date,
-- suf2_status,
-- suf3_done_date,
-- suf3_status,
-- urine_cal_date_suf1,
-- urine_cal_date_suf2,
-- urine_cal_date_suf3,
-- urine_cal_status_suf1,
-- urine_cal_status_suf2,
-- urine_cal_status_suf3,
-- wmf_done_date,
-- wmf_past_order,
-- wmf_start,
-- wmf_status,
-- woman_name,
-- woman_status,
-- wmb_done_date,
-- wmb_status,
-- web_done_date,
-- web_status,
-- weaeb_done_date,
-- wbb_status,
-- wra_serial,
-- wravf1_1attm_date,
-- wravf1_done_date,
-- wravf1_status,
-- wravf2_done_date,
-- wravf2_status,
-- we_done_date,
-- we_status,
-- dvf_done_date,
-- dvf_status,
-- eser_done_date,
-- eser_rpdesc,
-- px_done_date,
-- drink_status,
-- serf_2nd7hv_done_date,
-- serf_2nd7hv_status,
-- serf_hv_rp_assmt,
-- Brian's variables 
/*pxdate_bl as px_bl_date,*/
/*pxdate_ml as px_ml_date,*/
discnt,
fdose_date,
edose_date,
totdose_days,
totdose_mns,
totdose_bep,
pcomp_mns,
pcomp_bep
-- sesdate,
-- sesstatus,
-- safdate,
-- safstatus,

-- dr1_status,
-- dr1_date,
-- dr2_status,
-- dr2_date,
-- dr3_status,
-- dr3_date,
-- suf1date,
-- suf1status,
-- suf1urine,
-- suf1stool,
-- suf2date,
-- suf2status,
-- suf2urine,
-- suf2stool,
-- suf3date,
-- suf3status,
-- suf3urine,
-- suf3stool
/* insert_time,*/
/* inserted_by,*/
/* update_time,*/
/* updateed_by,*/
/* age,*/
/* age_grp,*/
/* blood_cal_date_15b,*/
/* blood_cal_date_3b,*/
/* blood_cal_date_eb,*/
/* blood_cal_status_15b,*/
/* blood_cal_status_3b,*/
/* blood_cal_status_eb,*/
/* changed_hhid,*/

into wtrak_wra
from wtrak_wra_prep


/*---------------------------------------------------------------------------------------------*/


print 'count of women available for WRA trial'
select count(*) from woman_wra
-- n= 607

print 'eligible and consented and enrolled'
select arm_wra, count(*) from wtrak_wra wt
where wt.arm_wra is not null
--and supp_status = '01'
group by wt.arm_wra
with rollup

print 'not supplemented -status'
select wt.arm_wra,wt.supp_status, count(*)
from wtrak_wra wt
where wt.arm_wra is not null
group by wt.arm_wra,supp_status 
with rollup 

print 'women who have started supplementation'
select arm_wra, count(*) from wtrak_wra wt
where wt.arm_wra is not null
and supp_status = '01'
group by wt.arm_wra
with rollup


select arm_wra,supp_status,discnt,count(*)
from wtrak_wra wt
where wt.arm_wra is not null
--and supp_status = '01'
group by arm_wra,supp_status,discnt
with rollup
order by arm_wra 



print 'women who have mid-line visits'
select arm_wra,supp_status,wmb_status,count(*)
from wtrak_wra wt
where wt.arm_wra is not null
and supp_status = '01'
group by arm_wra,supp_status,wmb_status
with rollup
order by arm_wra 


print 'mid-line visits'
select arm_wra,wmb_status,count(*)
from wtrak_wra wt
where wt.arm_wra is not null
and supp_status = '01'
and wmb_status = 1
group by arm_wra,wmb_status
with rollup
order by arm_wra 


print 'women who have mid-line visits'
select arm_wra,supp_status,wm_status,wmb_status,mid_study_status,end_study_status,count(*)
from wtrak_wra wt
left join wra_log wl on wl.uid = wt.uid 
where wt.arm_wra is not null
and supp_status = '01'
group by arm_wra,supp_status,wm_status,wmb_status,mid_study_status,end_study_status
--with rollup
order by arm_wra 

select * from wtrak_wra 
where arm_wra='W' and 
supp_status='01' and wm_status =1 and wmb_status is null 


print 'women who have end-line visits'
select arm_wra,supp_status,we_status,web_status,end_study_status,count(*)
from wtrak_wra wt
--left join wra_log wl on wl.uid = wt.uid 
where wt.arm_wra is not null
and supp_status = '01'
and wm_status =1 and wmb_status =1
group by arm_wra,supp_status,we_status,web_status,end_study_status
with rollup
order by arm_wra 



print 'end-line visits status'
select arm_wra,web_status,count(*)
from wtrak_wra wt
where wt.arm_wra is not null
and supp_status = '01'
and wmb_status = 1
group by arm_wra,web_status
with rollup
order by arm_wra 


print 'end-line visits status'
select arm_wra,count(*)
from wtrak_wra wt
where wt.arm_wra is not null
and supp_status = '01'
and wmb_status = 1
and web_status = 1
group by arm_wra
with rollup



print 'end-line visits status'
select arm_wra,web_status,count(*)
from wtrak_wra wt
where wt.arm_wra is not null
and supp_status = '01'
and wmb_status = 1
and web_status = 1
group by arm_wra,web_status
with rollup
order by arm_wra 






--- For PW trial use 
-- the eligibility for psf on the WEF  
-- (${wefpm}='0' or ((${wefpt}='1' or  ${wefpt}='5' or ${wefpt}='6' or ${wefpt}='8')  and (${wewant6m}='1' or  ${wewant6m}='9')) or ((${wefpt}='1' or  ${wefpt}='5' or ${wefpt}='6' or ${wefpt}='8')  and ${wewant6m}='0' and ${wecurbfd}='1')) or (${pwcon}='1' and ${westatus}='1')

select *  from wef_nwef_mv_prep
where 
(wefpm='0' or
((wefpt='1' or  wefpt='5' or wefpt='6' or wefpt='8')  
and (wewant6m='1' or  wewant6m='9')) 

or ((wefpt='1' or  wefpt='5' or wefpt='6' or wefpt='8')  
and wewant6m='0' and wecurbfd='1')) 

or (pwcon='1' and westatus='1')