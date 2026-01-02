

use [mindr-live]
go
--** Corrected in the live server 
-- print ' MPF - 463398 - According to diary note meal time will be 12am 23-04-24' 
-- update all_mpfb set mpbmealtime='00:00:00.000+06:00',
-- mpmealdate='2024-04-23',
-- update_time=GETDATE(),
-- updateed_by='FDER_ZAH-77' 
-- where uid='463398' and id='76'


--** Corrected in the live server 
-- print 'WRA - 005938 -According to diary note meal time will be 11.24am.- Interview completed at 12:38 PM'
-- update all_wraeb 
-- set webmealtime='11:24:00.000+06:00'
-- ,update_time=GETDATE()
-- ,updateed_by='FDER_ZAH-77'
-- where uid='005938' and id='140'




--** Corrected on server 
-- print ' WRA1B - 133791 - According to diary note 10.35am'
-- update all_wra1b set w1bbldtime='10:35:00.000+06:00'
-- ,update_time=GETDATE()
-- ,updateed_by='FDER_ZAH-77'
-- where uid='133791' and id='121'


--** Corrected on server 
-- print 'PEFB - 203825 - According to diary note blood collection time will be 12.05pm as women was fasting last meal 3.30am'
-- update all_pefb 
-- set pebbldtime='12:05:00.000+06:00', 
-- update_time=GETDATE(),updateed_by='FDER_ZAH-77'  where uid='203825' and id='248'




--** Corrected on server 
-- print 'PEFB - 919508 - "According to diary note meal time will be 10.15am and blood collection time 1.45pm"'
-- update all_pefb 
-- set pebmealtime='10:15:00.000+06:00'
-- ,update_time=GETDATE()
-- ,updateed_by='FDER_ZAH-77'
-- where uid='919508' and id='296'


--** Corrected on server 
-- print 'MPF - 533222 - According to diary note meal time will be 8.30am'

-- update all_mpfb 
-- set 
-- mpbmealtime='08:30:00.000+06:00'
-- ,update_time=GETDATE()
-- ,updateed_by='FDER_ZAH-77'
-- where uid='533222' and id='137'