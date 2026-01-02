use [mindr-live]
go 

-- Check data for these datasets with 
-- WRA-EB, WRA-1.5B, WRA-3B, PEF-B, MPF-B, and LPF-B


print 'wra_eb'
select w1.uid ,[start]
,convert(smalldatetime,substring(convert(varchar,[start],121),1,10)+' '+substring(convert(varchar,[start],121),12,8),121) as [start_2]
,convert(smalldatetime,substring(convert(varchar,webdate,121),1,10)+' '+ substring(webbldtime,1,8),121) as webldtime
,convert(smalldatetime,substring(convert(varchar,webmealdate,121),1,10)+' '+ substring(webmealtime,1,8),121) as webmealtime
,datediff(minute
,convert(smalldatetime,substring(convert(varchar,webmealdate,121),1,10)+' '+ substring(webmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,webdate,121),1,10)+' '+ substring(webbldtime,1,8),121)
) as timediff_min
,cast(datediff(minute
,convert(smalldatetime,substring(convert(varchar,webmealdate,121),1,10)+' '+ substring(webmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,webdate,121),1,10)+' '+ substring(webbldtime,1,8),121)
)/60.0 as decimal(10,1)) as timediff_hour
,webdate,webmealdate,webmealtime,webspecid1,webspecid2 
--,w1.*
--,lr.*
from 
wra_eb_mv w1
left join lab_recv lr on lr.specimenid = w1.webspecid1
where 
datediff(minute
,convert(smalldatetime,substring(convert(varchar,webmealdate,121),1,10)+' '+ substring(webmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,webdate,121),1,10)+' '+ substring(webbldtime,1,8),121)
) < 0
order by w1.uid
-- 005938
-- 019142
-- 042926
-- 045618
-- 071574
-- 170934
-- 178616
-- 259319
-- 345203
-- 360296
-- 440259
-- 590214
-- 937136


print 'wra_1b'
select w1.uid ,[start]
,convert(smalldatetime,substring(convert(varchar,[start],121),1,10)+' '+substring(convert(varchar,[start],121),12,8),121) as [start_2]
,convert(smalldatetime,substring(convert(varchar,w1bdate,121),1,10)+' '+ substring(w1bbldtime,1,8),121) as w1bldtime
,convert(smalldatetime,substring(convert(varchar,w1bmealdate,121),1,10)+' '+ substring(w1bmealtime,1,8),121) as w1bmealtime
,datediff(minute
,convert(smalldatetime,substring(convert(varchar,w1bmealdate,121),1,10)+' '+ substring(w1bmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,w1bdate,121),1,10)+' '+ substring(w1bbldtime,1,8),121)
) as timediff_min
,cast(datediff(minute
,convert(smalldatetime,substring(convert(varchar,w1bmealdate,121),1,10)+' '+ substring(w1bmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,w1bdate,121),1,10)+' '+ substring(w1bbldtime,1,8),121)
)/60.0 as decimal(10,1)) as timediff_hour
,w1bdate,w1bmealdate,w1bmealtime,w1bspecid1,w1bspecid2 
--,w1.*
--,lr.*
from 
wra_1b_mv w1
left join lab_recv lr on lr.specimenid = w1.w1bspecid1
where 
datediff(minute
,convert(smalldatetime,substring(convert(varchar,w1bmealdate,121),1,10)+' '+ substring(w1bmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,w1bdate,121),1,10)+' '+ substring(w1bbldtime,1,8),121)
) < 0
order by w1.uid
-- 004803
-- 086615
-- 133791
-- 137233
-- 291483
-- 315137
-- 364579
-- 470211
-- 804953
-- 993561



print 'wra_3b'
select w1.uid ,[start]
,convert(smalldatetime,substring(convert(varchar,[start],121),1,10)+' '+substring(convert(varchar,[start],121),12,8),121) as [start_2]
,convert(smalldatetime,substring(convert(varchar,w3bdate,121),1,10)+' '+ substring(w3bbldtime,1,8),121) as w3bldtime
,convert(smalldatetime,substring(convert(varchar,w3bmealdate,121),1,10)+' '+ substring(w3bmealtime,1,8),121) as w3bmealtime
,datediff(minute
,convert(smalldatetime,substring(convert(varchar,w3bmealdate,121),1,10)+' '+ substring(w3bmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,w3bdate,121),1,10)+' '+ substring(w3bbldtime,1,8),121)
) as timediff_min
,cast(datediff(minute
,convert(smalldatetime,substring(convert(varchar,w3bmealdate,121),1,10)+' '+ substring(w3bmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,w3bdate,121),1,10)+' '+ substring(w3bbldtime,1,8),121)
)/60.0 as decimal(10,1)) as timediff_hour
,w3bdate,w3bmealdate,w3bmealtime,w3bspecid1,w3bspecid2 
--,w1.*
--,lr.*
from 
wra_3b_mv w1
left join lab_recv lr on lr.specimenid = w1.w3bspecid1
where 
datediff(minute
,convert(smalldatetime,substring(convert(varchar,w3bmealdate,121),1,10)+' '+ substring(w3bmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,w3bdate,121),1,10)+' '+ substring(w3bbldtime,1,8),121)
) < 0
order by w1.uid
-- 115194
-- 325739
-- 359015
-- 881437
-- 921166
-- 959887



print 'pefb'
select w1.uid ,[start]
,convert(smalldatetime,substring(convert(varchar,[start],121),1,10)+' '+substring(convert(varchar,[start],121),12,8),121) as [start_2]
,convert(smalldatetime,substring(convert(varchar,pebdate,121),1,10)+' '+ substring(pebbldtime,1,8),121) as pebldtime
,convert(smalldatetime,substring(convert(varchar,pebmealdate,121),1,10)+' '+ substring(pebmealtime,1,8),121) as pebmealtime
,datediff(minute
,convert(smalldatetime,substring(convert(varchar,pebmealdate,121),1,10)+' '+ substring(pebmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,pebdate,121),1,10)+' '+ substring(pebbldtime,1,8),121)
) as timediff_min
,cast(datediff(minute
,convert(smalldatetime,substring(convert(varchar,pebmealdate,121),1,10)+' '+ substring(pebmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,pebdate,121),1,10)+' '+ substring(pebbldtime,1,8),121)
)/60.0 as decimal(10,1)) as timediff_hour
,pebdate,pebmealdate,pebmealtime,pebspecid1,pebspecid2 
--,w1.*
--,lr.*
from 
pefb_mv w1
left join lab_recv lr on lr.specimenid = w1.pebspecid1
where 
datediff(minute
,convert(smalldatetime,substring(convert(varchar,pebmealdate,121),1,10)+' '+ substring(pebmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,pebdate,121),1,10)+' '+ substring(pebbldtime,1,8),121)
) < 0
order by w1.uid
-- 034703
-- 079849
-- 203825
-- 270853
-- 339513
-- 427547
-- 485578
-- 519061
-- 882510
-- 919508



print 'MPF-B'
select w1.uid ,[start]
,convert(smalldatetime,substring(convert(varchar,[start],121),1,10)+' '+substring(convert(varchar,[start],121),12,8),121) as [start_2]
,convert(smalldatetime,substring(convert(varchar,mpbdate,121),1,10)+' '+ substring(mpbbldtime,1,8),121) as mpbldtime
,convert(smalldatetime,substring(convert(varchar,mpbmealdate,121),1,10)+' '+ substring(mpbmealtime,1,8),121) as mpbmealtime
,datediff(minute
,convert(smalldatetime,substring(convert(varchar,mpbmealdate,121),1,10)+' '+ substring(mpbmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,mpbdate,121),1,10)+' '+ substring(mpbbldtime,1,8),121)
) as timediff_min
,cast(datediff(minute
,convert(smalldatetime,substring(convert(varchar,mpbmealdate,121),1,10)+' '+ substring(mpbmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,mpbdate,121),1,10)+' '+ substring(mpbbldtime,1,8),121)
)/60.0 as decimal(10,1)) as timediff_hour
,mpbdate,mpbmealdate,mpbmealtime,mpbspecid1,mpbspecid2 
--,w1.*
--,lr.*
from 
mpfb_mv w1
left join lab_recv lr on lr.specimenid = w1.mpbspecid1
where 
datediff(minute
,convert(smalldatetime,substring(convert(varchar,mpbmealdate,121),1,10)+' '+ substring(mpbmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,mpbdate,121),1,10)+' '+ substring(mpbbldtime,1,8),121)
) < 0
order by w1.uid

-- 403481
-- 504318
-- 533222
-- 564714
-- 714979
-- 746600
-- 844863
-- 950019


print 'LPF-B'
select w1.uid ,[start]
,convert(smalldatetime,substring(convert(varchar,[start],121),1,10)+' '+substring(convert(varchar,[start],121),12,8),121) as [start_2]
,convert(smalldatetime,substring(convert(varchar,lpbdate,121),1,10)+' '+ substring(lpbbldtime,1,8),121) as lpbldtime
,convert(smalldatetime,substring(convert(varchar,lpbmealdate,121),1,10)+' '+ substring(lpbmealtime,1,8),121) as lpbmealtime
,datediff(minute
,convert(smalldatetime,substring(convert(varchar,lpbmealdate,121),1,10)+' '+ substring(lpbmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,lpbdate,121),1,10)+' '+ substring(lpbbldtime,1,8),121)
) as timediff_min
,cast(datediff(minute
,convert(smalldatetime,substring(convert(varchar,lpbmealdate,121),1,10)+' '+ substring(lpbmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,lpbdate,121),1,10)+' '+ substring(lpbbldtime,1,8),121)
)/60.0 as decimal(10,1)) as timediff_hour
,lpbdate,lpbmealdate,lpbmealtime,lpbspecid1,lpbspecid2 
--,w1.*
--,lr.*
from 
lpfb_mv w1
left join lab_recv lr on lr.specimenid = w1.lpbspecid1
where 
datediff(minute
,convert(smalldatetime,substring(convert(varchar,lpbmealdate,121),1,10)+' '+ substring(lpbmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,lpbdate,121),1,10)+' '+ substring(lpbbldtime,1,8),121)
) < 0
order by w1.uid

-- 063466
-- 189857
-- 229652
-- 504318
-- 705031
-- 784622
-- 988986



use [mindr-live]
go 

print 'm1mop-B'
select w1.uid ,[start]
,convert(smalldatetime,substring(convert(varchar,[start],121),1,10)+' '+substring(convert(varchar,[start],121),12,8),121) as [start_2]
,convert(smalldatetime,substring(convert(varchar,m1bdate,121),1,10)+' '+ substring(m1bbldtime,1,8),121) as m1bldtime
,convert(smalldatetime,substring(convert(varchar,m1bmealdate,121),1,10)+' '+ substring(m1bmealtime,1,8),121) as m1bmealtime
,datediff(minute
,convert(smalldatetime,substring(convert(varchar,m1bmealdate,121),1,10)+' '+ substring(m1bmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,m1bdate,121),1,10)+' '+ substring(m1bbldtime,1,8),121)
) as timediff_min
,cast(datediff(minute
,convert(smalldatetime,substring(convert(varchar,m1bmealdate,121),1,10)+' '+ substring(m1bmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,m1bdate,121),1,10)+' '+ substring(m1bbldtime,1,8),121)
)/60.0 as decimal(10,1)) as timediff_hour
,m1bdate,m1bmealdate,m1bmealtime,m1bspecid1,m1bspecid2 
--,w1.*
--,lr.*
from 
m1mopb_mv w1
left join lab_recv lr on lr.specimenid = w1.m1bspecid1
where 
datediff(minute
,convert(smalldatetime,substring(convert(varchar,m1bmealdate,121),1,10)+' '+ substring(m1bmealtime,1,8),121)
,convert(smalldatetime,substring(convert(varchar,m1bdate,121),1,10)+' '+ substring(m1bbldtime,1,8),121)
) < 0
order by w1.uid


print 'check for null fasting times' 


select * from pefb_mv
left join lab_recv 
where pebstatus =1 
and pebbldtime is not null --337

select * from mpfb_mv
where mpbstatus =1 --269
and mpbbldtime is not null 


select * from lpfb_mv
where lpbstatus =1 --261
and lpbbldtime is not null 

select * from m1mopb_mv
where m1bstatus =1 --287
and m1bbldtime is not null 

select * from wra_eb_mv
where webstatus=1 --285
and webbldtime is not null 

select * from wra_1b_mv
where w1bstatus=1 --257
and w1bbldtime is not null 

select * from wra_3b_mv
where w3bstatus=1 -- 243 
and w3bbldtime is not null 


