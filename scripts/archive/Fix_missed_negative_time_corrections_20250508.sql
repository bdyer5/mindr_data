use [mindr-live]
go 

-- Check data for these datasets with 
-- WRA-EB, WRA-1.5B, WRA-3B, PEF-B, MPF-B, and LPF-B

-- select * from pregtrak 
-- where peb_fast_time <0

-- 203825 -- uid is being investigated -- pending decision -- script not written to update yet - form submitted before recorded blood collection time
-- 560122 -- update script was incorrect — updated pebbldtime instead of pebmealtime
-- 858675  -- update script was incorrect — updated pebbldtime instead of pebmealtime
-- 919508 -- update not implemented -- pending decision



print 'correctly updating 560122'
update all_pefb 
set pebmealdate='2024-01-04'
,pebmealtime='00:00:00.000+06:00' 
,pebbldtime='09:30:00.000+06:00' 
, update_time=GETDATE()
,updateed_by='FDER_ZAH-77' 
where uid='560122' and id='138'


-- select * from auditall_pefb 
-- where uid='858675'

print 'correctly updating 858675'
update all_pefb 
set pebmealdate='2024-06-12'
,pebmealtime='00:00:00.000+06:00' 
,pebbldtime='09:23:00.000+06:00' 
,update_time=GETDATE()
,updateed_by='FDER_ZAH-77'  
where uid='858675' and id='308'



-- select * from pregtrak 
-- where mpb_fast_time <0
-- -- 403481 -- update not implemented in DB 
-- -- 533222 -- script not written to update yet - form submitted before recorded blood collection time 
-- -- 844863 -- never investigated 


print '"According to diary note, meal time will be 10.35pm 15-04-2024 and blood collection time 10.32am"'
update all_mpfb
set mpbmealtime='22:35:00.000+06:00'
,update_time=GETDATE()
,updateed_by='FDER_ZAH-77'
,mpbmealdate='2024-04-15' 
where uid='403481' and id='60'