use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='wmfwra_mv')
begin 
drop view wmfwra_mv 
end 
go 

create view wmfwra_mv
as 
select 
wma.uid,
tlpin,
sector,
hhid,
/*hhchange,*/
/*newhhid,*/
/*womname,*/
/*husbname,*/
/*idenconf,*/
convert(smalldatetime,wma.wmdate,121) as wmdate,
workerid,
wmstatus,
convert(smalldatetime,wmdoc,121) as wmdoc,
wmdod,
wmvmt7 as wmnsvmt7,
wmdiar7,
wmtoes7,
wmrash7,
wmhair7,
wmweak7,
wmhach7,
wmvision7,
wmbleed7,
wmdys7,
wmbruis7,
wmodor7,
today,
start,
[end],
wma.formorder,
scheduleid

from [mindr-live].dbo.all_wmf_wra wma
right join (select eb2.uid,formorder,max(wmdate) wmdate
from [mindr-live].dbo.all_wmf_wra eb2
where eb2.duplicate is null
group by eb2.uid, eb2.formorder
) a on a.uid = wma.uid and wma.wmdate =a.wmdate and wma.formorder =a.formorder  
--where a.wmdate is not null
and wma.duplicate is null 
