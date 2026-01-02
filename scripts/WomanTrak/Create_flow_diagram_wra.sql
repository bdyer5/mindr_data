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


print 'count of women randomized - by arm'
select allocated_arm, count(*) from wtrak_wra_prep 
where allocated_arm is not null
group by allocated_arm
with rollup

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
add w1b_status int null
go 

alter table wtrak_wra_prep
add w1b_date smalldatetime null
go 

alter table wtrak_wra_prep
add w3b_status int null
go 


alter table wtrak_wra_prep
add w3b_date smalldatetime null
go 



update wtrak_wra_prep 
set discnt = 'bl'
from  wtrak_wra_prep wt 
left join wra_log  wl on wl.uid =wt.uid 
where discntd_source = 'PX_Data_Baseline'

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

update wtrak_wra_prep 
--select wt.uid ,
set w1b_status = w1.w1bstatus ,
 w1b_date = w1.w1bdate
from  wtrak_wra_prep wt 
left join wra_1b_mv w1 on w1.uid = wt.uid 
where wt.allocated_arm is not null
and supplementation_status = '01'


update wtrak_wra_prep 
--select wt.uid ,
set w3b_status = w3.w3bstatus ,
 w3b_date = w3.w3bdate
from  wtrak_wra_prep wt 
left join wra_3b_mv w3 on w3.uid = wt.uid 
where wt.allocated_arm is not null
and supplementation_status = '01'





if exists(select o.name from sysobjects o where o.name='wtrak_wra')
begin 
drop table wtrak_wra
end 
go 


select 
uid,
insert_time,
inserted_by,
update_time,
updateed_by,
age,
age_grp,
case when allocated_arm = 'A' then 'Y'
when allocated_arm = 'B' then 'W'
when allocated_arm = 'C' then 'Z'
when allocated_arm = 'D' then 'X' end as allocated_arm,  /*keep*/
blood_cal_date_15b,
blood_cal_date_3b,
blood_cal_date_eb,
blood_cal_status_15b,
blood_cal_status_3b,
blood_cal_status_eb,
changed_hhid,
consent,
consent_date,
dod,
drf1_complete,
drf1_done_date,
drf1_status,
drf2_done_date,
drf2_status,
drf3_done_date,
drf3_status,
enroll_id_age,
enroll_id_overall,
hhid,
husband_name,
mobile,
rpt_drf_eligible,
sadf1,
sadfp1,
saf_done_date,
saf_past_order,
saf_start,
saf_status,
sector,
selection_status,
serf_14d_done_date,
serf_14d_saf_stop,
serf_14d_status,
serf_7d_done_date,
serf_7d_saf_stop,
serf_7d_status,
serf_decision,
serf_done_date,
serf_end_date,
serf_hv_done_date,
serf_hv_saf_stop,
serf_hv_status,
serf_saf_stop,
serf_start_date,
serf_status,
ses_done_date,
ses_status,
stool_cal_date_suf1,
stool_cal_date_suf3,
stool_cal_status_suf1,
stool_cal_status_suf3,
sudf1_done_date,
sudf1_status,
sudf2_done_date,
sudf2_status,
sudf3_done_date,
sudf3_status,
suf1_done_date,
suf1_status,
suf2_done_date,
suf2_status,
suf3_done_date,
suf3_status,
tlpin,
urine_cal_date_suf1,
urine_cal_date_suf2,
urine_cal_date_suf3,
urine_cal_status_suf1,
urine_cal_status_suf2,
urine_cal_status_suf3,
wmf_done_date,
wmf_past_order,
wmf_start,
wmf_status,
woman_name,
woman_status,
wra15b_done_date,
wra15b_status,
wra3b_done_date,
wra3b_status,
weaeb_done_date,
wraeb_status,
wra_serial,
wravf1_1attm_date,
wravf1_done_date,
wravf1_status,
wravf2_done_date,
wravf2_status,
wravf3_done_date,
wravf3_status,
dvf_done_date,
dvf_status,
eser_done_date,
eser_rpdesc,
px_done_date,
drink_status,
serf_2nd7hv_done_date,
serf_2nd7hv_status,
serf_hv_rp_assmt,
discnt,
supplementation_status,
w1b_status,
w1b_date,
w3b_status,
w3b_date 
into wtrak_wra
from wtrak_wra_prep




print 'supplementation status'
select wt.allocated_arm,wt.supplementation_status, count(*)
from wtrak_wra wt
where wt.allocated_arm is not null
group by wt.allocated_arm,supplementation_status 
with rollup 


print 'women who have started supplementation'
select allocated_arm, count(*) from wtrak_wra wt
where wt.allocated_arm is not null
and supplementation_status = '01'
group by wt.allocated_arm
with rollup



select allocated_arm,supplementation_status,discnt,count(*)
from wtrak_wra wt
where wt.allocated_arm is not null
--and supplementation_status = '01'
group by allocated_arm,supplementation_status,discnt
with rollup
order by allocated_arm 


print 'women who have started supplementation'
select allocated_arm, count(*) from wtrak_wra wt
where wt.allocated_arm is not null
and supplementation_status = '01'
group by wt.allocated_arm
with rollup





print 'women who have mid-line visits'
select allocated_arm,supplementation_status,wra15b_status,count(*)
from wtrak_wra wt
where wt.allocated_arm is not null
and supplementation_status = '01'
group by allocated_arm,supplementation_status,wra15b_status
with rollup
order by allocated_arm 


print 'mid-line visits'
select allocated_arm,wra15b_status,count(*)
from wtrak_wra wt
where wt.allocated_arm is not null
and supplementation_status = '01'
and wra15b_status = 1
group by allocated_arm,wra15b_status
with rollup
order by allocated_arm 



print 'end-line visits status'
select allocated_arm,w3b_status,count(*)
from wtrak_wra wt
where wt.allocated_arm is not null
and supplementation_status = '01'
and wra15b_status = 1
group by allocated_arm,w3b_status
with rollup
order by allocated_arm 




print 'end-line visits status'
select allocated_arm,w3b_status,count(*)
from wtrak_wra wt
where wt.allocated_arm is not null
and supplementation_status = '01'
and wra15b_status = 1
and w3b_status = 1
group by allocated_arm,w3b_status
with rollup
order by allocated_arm 






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