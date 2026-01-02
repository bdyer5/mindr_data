use [mindr-live]
go


-------------------------------------------------------------------------------------------------------------------------------------------

print'Started Pregnancy Surveilance' 
select * from wtrak_pw where 
last_psf_status is not null 


select count(*) from wtrak_pw 
where psfurt =1 

print 'Pregnancy Enrollment - consented to the pw trial'
select * from wtrak_pw 
where peconsent = 1
-- n = 313 
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
 when saf_flow_status =65 then 'UVF  - Refused interview'
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
