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


-- **corrected on the server 
-- print 'correctly updating 560122'
-- update all_pefb 
-- set pebmealdate='2024-01-04'
-- ,pebmealtime='00:00:00.000+06:00' 
-- ,pebbldtime='09:30:00.000+06:00' 
-- , update_time=GETDATE()
-- ,updateed_by='FDER_ZAH-77' 
-- where uid='560122' and id='138'


-- select * from auditall_pefb 
-- where uid='858675'

-- **corrected on the server 
-- print 'correctly updating 858675'
-- update all_pefb 
-- set pebmealdate='2024-06-12'
-- ,pebmealtime='00:00:00.000+06:00' 
-- ,pebbldtime='09:23:00.000+06:00' 
-- ,update_time=GETDATE()
-- ,updateed_by='FDER_ZAH-77'  
-- where uid='858675' and id='308'



-- select * from pregtrak 
-- where mpb_fast_time <0
-- -- 403481 -- update not implemented in DB 
-- -- 533222 -- script not written to update yet - form submitted before recorded blood collection time 
-- -- 844863 -- never investigated 

--**corrected on the server 
-- print '"According to diary note, meal time will be 10.35pm 15-04-2024 and blood collection time 10.32am"'
-- update all_mpfb
-- set mpbmealtime='22:35:00.000+06:00'
-- ,update_time=GETDATE()
-- ,updateed_by='FDER_ZAH-77'
-- ,mpbmealdate='2024-04-15' 
-- where uid='403481' and id='60'

--20250510 - From Reza's email and EZ comments and corrections on 5/9/2025-- 

--**corrected on the server 
-- update all_wraeb set webbldtime='12:30:00.000+06:00', update_time=GETDATE(),webmealtime='11:24:00.000+06:00',updateed_by='FDER_ZAH-77'  where uid='005938' and id='139'

--**corrected on the server 
-- update all_wra1b set w1bbldtime='10:21:00.000+06:00', update_time=GETDATE(),updateed_by='FDER_ZAH-77'  where uid='137233' and id='42'

--**corrected on the server 
-- update all_wra1b set w1bbldtime='10:17:00.000+06:00', update_time=GETDATE(),updateed_by='FDER_ZAH-77'  where uid='133791' and id='121'

--**corrected on the server 
-- update all_pefb set pebbldtime='12:01:00.000+06:00', update_time=GETDATE(),updateed_by='FDER_ZAH-77'  where uid='203825' and id='248'

--**corrected on the server 
-- update all_pefb set pebbldtime='13:43:00.000+06:00', pebmealtime='10:15:00.000+06:00',update_time=GETDATE(),updateed_by='FDER_ZAH-77'  where uid='919508' and id='296'

--**corrected on the server 
-- update all_mpfb set mpbbldtime='11:56:00.000+06:00',mpbmealtime='08:30:00.000+06:00', update_time=GETDATE(),updateed_by='FDER_ZAH-77'  where uid='533222' and id='91'

--**corrected on the server 
-- update all_wra3b set w3bmealtime='21:50:00.000+06:00', update_time=GETDATE(),updateed_by='FDER_ZAH-77',w3bmealdate='2024-11-11' where uid='115194' and id='249'

--**corrected on the server 
-- update all_wra3b set w3bbldtime='09:28:00.000+06:00', update_time=GETDATE(),updateed_by='FDER_ZAH-77'  where uid='325739' and id='47'

--**corrected on the server 
-- print 'didn''t get run on the live server'
-- update all_m1mopb set m1bbldtime='12:55:00.000+06:00', update_time=GETDATE(),updateed_by='FDER_ZAH-77' where uid='882510' and id='276'



-- Brian update - waiting for FS to respond on. 

--**corrected on the server 
-- note that this update below should be to 10am and not the previous day like the query below that Brian wrote 
-- update all_mpfb 
-- set mpbmealdate ='2024-04-29'
-- ,update_time=GETDATE()
-- ,updateed_by='FDER_ZAH-77'
-- where uid ='844863' and id  = '82'


-- 463398 mpfb - No fix written for this one yet 
-- 208248 WRA1.5 B  -  No fix written for this one yet 

-- Send fix to Reza for 463398 MPFB 

--**corrected on the server 
-- print 'MPFB - 463398 - According to diary note meal time will be 12am 23-04-24'
-- update all_mpfb 
-- set mpbmealdate ='2024-04-23'
-- ,mpbmealtime='00:00:00.000+06:00'
-- ,update_time=GETDATE()
-- ,updateed_by='FDER_ZAH-77'
-- where uid ='463398' and id  = '76'


--**corrected on the server 
-- print 'PEFB - change blood collection time to 11:03 (form completion time).'
-- update all_pefb 
-- set pebbldtime='11:03:00.000+06:00',
-- update_time=GETDATE(),
-- updateed_by='FDER_ZAH-77'
-- where uid='463398' and id='105'



--**corrected on the server 
-- print 'MPFB - 844863 - According to diary note last meal time will be 10am'
-- update all_mpfb 
-- set mpbmealtime='10:00:00.000+06:00'
-- ,update_time=GETDATE()
-- ,updateed_by='FDER_ZAH-77'
-- where uid ='844863' and id  = '82'


print 'PEFB - change blood collection time to 11:03 (form completion time).'



--**corrected on the server 
-- print 'WRA1B - 208248 - According to diary note meal time will be 9pm '
-- update all_wra1b 
-- set w1bmealtime='21:00:00.000+06:00'
-- ,update_time=GETDATE()
-- ,updateed_by='FDER_ZAH-77' where uid='208248' and id='135'