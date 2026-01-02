

use [mindr-live] 
go 

if exists(select o.name from sysobjects o where o.name='bgdoutcview')
begin 
drop view bgdoutcview
end 
go 


create view [dbo].[bgdoutcview]
as


-- pef_status (pestatus)
-- 1 = Met
-- 2 = Not met (up to 28 weeks post-LMP)
-- 3 = Woman had MR
-- 4 = Miscarriage
-- 5 = Woman had livebirth
-- 6 = Refused interview
-- 7 = Permanently moved
-- 8 = Died

-- ibaf_status 
-- 1 = Met
-- 2 = Not met until 1MOP
-- 5 = Child given away for adoption
-- 6 = Refused interview
-- 7 = Permanently moved
-- 8 = Died

-- fbaf_status 
-- 1 = Met
-- 2 = Not met until 1MOP
-- 5 = Child given away for adoption
-- 6 = Refused interview
-- 7 = Permanently moved
-- 8 = Died

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


-- for outcomes check
-- wef  - done
-- psf - done 
-- pef - done 
-- 1msaf - done ms1 
-- msaf - done ms 
-- raf - done raf
-- lpf - done lpf
-- ses - done ses
-- bnf - done bn 
-- baf -  done - baf 
-- SB bnf first 
-- msaf 
-- raf 


--saf status 
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


-- m1saf status
-- 01 = Met
-- 02 = Not met
-- 03 = Woman had MR
-- 04 = Miscarriage
-- 05 = Woman had livebirth
-- 06 = Stillbirth
-- 66 = Refused interview
-- 77 = Permanently moved
-- 88 = Died


-- msaf (msfstatus) status
-- 01 = Met
-- 02 = Not met by the end of the week 
-- 03 = Woman had MR
-- 04 = Miscarriage
-- 05 = Woman had livebirth
-- 06 = Stillbirth
-- 66 = Refused interview
-- 77 = Permanently moved
-- 88 = Died
-- 99 = Remote dosing (met over phone)

-- lpf (lpstatus) status 
-- 01 = Met
-- 02 = Not met until pregnancy outcome
-- 03 = Woman had MR
-- 04 = Miscarriage
-- 05 = Woman had livebirth
-- 06 = Stillbirth
-- 66 = Refused interview
-- 77 = Permanently moved
-- 88 = Died

-- bnf child visit status
-- 1 = Livebirth
-- 2 = Stillbirth
-- 9 = Dont know



--miscarriages from msbf

select wt.uid ,
coalesce(baf.outc,fbaf.outc,bnsb.outc,bnlb.outc,saf.outc,mpf.outc,lp.outc) bgoutc,
coalesce(baf.bgdoutc,fbaf.bgdoutc,bnsb.bgdoutc,bnlb.bgdoutc,saf.bgdoutc,mpf.bgdoutc,lp.bgdoutc) bgdoutc,
coalesce(baf.bgwoutc,fbaf.bgwoutc,bnsb.bgwoutc,bnlb.bgwoutc,saf.bgwoutc,mpf.bgwoutc,lp.bgwoutc  ) bgwoutc,
coalesce(baf.bgdoutcru,fbaf.bgdoutcru,bnsb.bgdoutcru,bnlb.bgdoutcru,saf.bgdoutcru,mpf.bgdoutcru,lp.bgdoutcru ) bgdoutcru,
coalesce(baf.bgrptdwk,fbaf.bgrptdwk,bnsb.bgrptdwk,bnlb.bgrptdwk,saf.bgrptdwk,mpf.bgrptdwk,lp.bgrptdwk) bgrptdwk,
coalesce(baf.bgoutcsrc,fbaf.bgoutcsrc,bnsb.bgoutcsrc,bnlb.bgoutcsrc,saf.bgoutcsrc,mpf.bgoutcsrc,lp.bgoutcsrc ) bgoutcsrc



--Lees codes to compare outc 3='MR' 4='MC' 5='1LB' 6='1SB' 7='2LB' 8='1L1S' 55='1L-Pend' 66='1S-Pend' 88='Mom-Dead' 99='NotYet' ;

-- live births 
-- mc/sb /mr


from (select uid from pw_enrollment_consent where pe_consent = '1') wt

left join(
    
select
bn.uid,
'06' as outc, /*child still birth from ibaf*/
convert(smalldatetime,substring(bn.bnfdtoo,1,10),121) as bgdoutc,
b.jivitaweek  as bgwoutc,
'01' as bgdoutcru,
j.jivitaweek  as bgrptdwk,
'bnf_sb' as bgoutcsrc
from [mindr-live].dbo.bnf_mv bn
left join 
(
select bn.uid, min(bnfdate) bnfdate,
case when bn.bnfchldvitsts1 =1 and bn.bnfchldvitsts2 !=1 then  bn.bnfchldvitsts1 
when bn.bnfchldvitsts1 = 1 and bn.bnfchldvitsts2 is null then bn.bnfchldvitsts1 
when bn.bnfchldvitsts1 != 1 and  bn.bnfchldvitsts2 = 1 then bn.bnfchldvitsts2 else bn.bnfchldvitsts1 end  bnfchldvitsts
from bnf_mv  bn
where 
case when bn.bnfchldvitsts1 =1 and bn.bnfchldvitsts2 !=1 then  bn.bnfchldvitsts1 
when bn.bnfchldvitsts1 = 1 and bn.bnfchldvitsts2 is null then bn.bnfchldvitsts1 
when bn.bnfchldvitsts1 != 1 and  bn.bnfchldvitsts2 = 1 then bn.bnfchldvitsts2 else bn.bnfchldvitsts1 end  = '2'
group by bn.uid, 
case when bn.bnfchldvitsts1 =1 and bn.bnfchldvitsts2 !=1 then  bn.bnfchldvitsts1 
when bn.bnfchldvitsts1 = 1 and bn.bnfchldvitsts2 is null then bn.bnfchldvitsts1 
when bn.bnfchldvitsts1 != 1 and  bn.bnfchldvitsts2 = 1 then bn.bnfchldvitsts2 else bn.bnfchldvitsts1 end 
) a 
on a.uid = bn.uid and a.bnfdate =bn.bnfdate 
left join shapla.dbo.jivitaweek j on j.RomanDate = bn.bnfdate 
left join shapla.dbo.jivitaweek b on b.RomanDate = convert(date,bn.bnfdtoo,121)
where case when bn.bnfchldvitsts1 =1 and bn.bnfchldvitsts2 !=1 then  bn.bnfchldvitsts1 
when bn.bnfchldvitsts1 = 1 and bn.bnfchldvitsts2 is null then bn.bnfchldvitsts1 
when bn.bnfchldvitsts1 != 1 and  bn.bnfchldvitsts2 = 1 then bn.bnfchldvitsts2 else bn.bnfchldvitsts1 end = 2

) bnsb on bnsb.uid =wt.uid 


left join(
    
select
bn.uid,
'05' as outc, /*live birth from bnf*/
convert(smalldatetime,substring(bn.bnfdtoo,1,10),121) as bgdoutc,
b.jivitaweek  as bgwoutc,
'01' as bgdoutcru,
j.jivitaweek  as bgrptdwk,
'bnf_lb' as bgoutcsrc
from [mindr-live].dbo.bnf_mv bn
left join 
(
select bn.uid, min(bnfdate) bnfdate,
case when bn.bnfchldvitsts1 =1 or bn.bnfchldvitsts2 =1 or bn.bnfchldvitsts3 =1 then 1 else bn.bnfchldvitsts1 end  bnfchldvitsts
from bnf_mv  bn
where 
case when bn.bnfchldvitsts1 =1 or bn.bnfchldvitsts2 =1 or bn.bnfchldvitsts3 =1 then 1 else bn.bnfchldvitsts1 end  = 1
group by bn.uid, 
case when bn.bnfchldvitsts1 =1 or bn.bnfchldvitsts2 =1 or bn.bnfchldvitsts3 =1 then 1 else bn.bnfchldvitsts1 end
) a 
on a.uid = bn.uid and a.bnfdate =bn.bnfdate 
left join shapla.dbo.jivitaweek j on j.RomanDate = bn.bnfdate 
left join shapla.dbo.jivitaweek b on b.RomanDate = convert(date,bn.bnfdtoo,121)
where case when bn.bnfchldvitsts1 =1 or bn.bnfchldvitsts2 =1 or bn.bnfchldvitsts3 =1 then 1 else bn.bnfchldvitsts1 end = 1

) bnlb on bnlb.uid =wt.uid 



left join(
select
s.uid,
sa.sastatus as outc, /*code from saf*/
sa.sadoc as  bgdoutc,
j.jivitaweek  as bgwoutc,
'01' as bgdoutcru,
b.jivitaweek as bgrptdwk,
'saf' as bgoutcsrc
from safpw_mv sa
join (select uid, min(sadate) sadate,sastatus from safpw_mv 
where sastatus in ('04','05','06','07','77','88')
group by uid ,sastatus)
s on sa.uid=s.uid and sa.sadate = s.sadate
left join shapla.dbo.jivitaweek j on j.romandate = sa.sadoc
left join shapla.dbo.jivitaweek b on b.RomanDate = s.sadate
where s.uid is not null and s.sadate is not null
) saf on saf.uid = wt.uid 

left join (
select
mpf.uid,
mpf.mpstatus as outc, /*code from msaf*/
mpf.mpdoc as bgdoutc,
b.jivitaweek  as bgwoutc,
'01' as bgdoutcru,
j.jivitaweek as bgrptdwk,
'mpf' as bgoutcsrc
 from mpf_mv mpf
left join 
(select uid, min(mpdate) mpdate,mpstatus  from mpf_mv 
where mpstatus in ('03','04','05','06','77','88')
group by uid ,mpstatus ) a on a.uid = mpf.uid  and a.mpdate = mpf.mpdate
left join shapla.dbo.jivitaweek j on j.RomanDate = mpf.mpdate 
left join shapla.dbo.jivitaweek b on b.RomanDate = mpf.mpdoc
where a.uid is not null and a.mpdate is not null
) mpf on mpf.uid =wt.uid

left join(
select
i.uid,
'05' as outc, /*child live birth from ibaf*/
ibdob as bgdoutc,
j.jivitaweek  as bgwoutc,
'01' as bgdoutcru,
j.jivitaweek  as bgrptdwk,
 'ibaf' as bgoutcsrc
from (select uid from pw_enrollment_consent where pe_consent = '1') w
join
(
select d.uid,d.ibstatus,d.ibdate,d.ibdob from ibaf_mv d
join (
select a.uid,min(ibdate) ibdate,a.ibdob from ibaf_mv a 
join(
select uid, min(ibdob) ibdob from ibaf_mv
group by uid
) b on b.uid = a.uid and b.ibdob = a.ibdob 
where a.ibdob = b.ibdob
group by a.uid, a.ibdob
) c on c.uid =d.uid and c.ibdate = d .ibdate and c.ibdob= d.ibdob) 
i on w.uid=i.uid
left join shapla.dbo.jivitaweek j on j.romandate = i.ibdob
left join shapla.dbo.jivitaweek b on b.RomanDate = i.ibdate
where ibstatus=1 and ibdob is not null
) baf on baf.uid = wt.uid 


left join(
select 
f.uid,
fbstatus,
fbdob,
'05' as outc, /*child live birth from ibaf*/
fbdob as bgdoutc,
j.jivitaweek  as bgwoutc,
'01' as bgdoutcru,
j.jivitaweek  as bgrptdwk,
 'fbaf' as bgoutcsrc
from (select uid from pw_enrollment_consent where pe_consent = '1') w
join 
(
select d.uid,d.fbstatus,d.fbdate,d.fbdob from fbaf_mv d
join (
select a.uid,min(fbdate) fbdate,a.fbdob from fbaf_mv a 
join(
select uid, min(fbdob) fbdob from fbaf_mv
group by uid
) b on b.uid = a.uid and b.fbdob = a.fbdob 
where a.fbdob = b.fbdob
group by a.uid, a.fbdob
) c on c.uid =d.uid and c.fbdate = d .fbdate and c.fbdob= d.fbdob)
f on w.uid=f.uid
left join shapla.dbo.jivitaweek j on j.romandate = f.fbdob
left join shapla.dbo.jivitaweek b on b.RomanDate = f.fbdate
where fbstatus=1 and fbdob is not null
) fbaf on fbaf.uid = wt.uid 




left join (
select
lpf.uid,
lpf.lpstatus as outc, /*code from msaf*/
lpf.lpdoc as  bgdoutc,
b.jivitaweek  as bgwoutc,
'01' as bgdoutcru,
j.jivitaweek as bgrptdwk,
'late pregnancy visit' as bgoutcsrc
 from lpf_mv lpf
left join 
(select uid, min(lpdate) lpdate,lpstatus  from lpf_mv 
where lpstatus in ('03','04','05','06','77','88')
group by uid ,lpstatus ) a on a.uid = lpf.uid  and a.lpdate = lpf.lpdate
left join shapla.dbo.jivitaweek j on j.RomanDate = lpf.lpdate 
left join shapla.dbo.jivitaweek b on b.RomanDate = lpf.lpdoc
where a.uid is not null and a.lpdate is not null
) lp on lp.uid =wt.uid

/*Add in the SES_mv here*/






