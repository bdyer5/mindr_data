

use [mindr-live]
go 


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




print 'women who have started supplementation'
select allocated_arm, count(*) from wtrak_wra wt
where wt.allocated_arm is not null
and supplementation_status = '01'
group by wt.allocated_arm
with rollup



print 'women who have mid-line visits'
select allocated_arm,wra15b_status,count(*)
from wtrak_wra wt
where wt.allocated_arm is not null
and supplementation_status = '01'
group by allocated_arm,wra15b_status
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