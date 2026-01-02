use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='wmfpw_mv')
begin 
drop view wmfpw_mv 
end 
go 

create view wmfpw_mv
as 

select 
wmp.uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
idenconf,
convert(smalldatetime,wmp.wmdate,121) as wmdate,
workerid,
wmstatus,
convert(smalldatetime,wmdoc,121) as wmdoc,
convert(smalldatetime,wmdod,121) as wmdod,
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
/*serfgen,*/
version,
today,
start,
[end],
wmp.formorder,
scheduleid


from [mindr-live].dbo.all_wmf_pw wmp
right join (select eb2.uid,formorder,max(wmdate) wmdate
from [mindr-live].dbo.all_wmf_pw eb2
where eb2.duplicate is null
group by eb2.uid, eb2.formorder
) a on a.uid = wmp.uid and wmp.wmdate =a.wmdate and wmp.formorder =a.formorder  
--where a.wmdate is not null
and wmp.duplicate is null 
go 
