select * from 
wef_nwef_mv_prep wp

join shapla.dbo.JiVitAWeek jw on jw.RomanDate = convert(smalldatetime,wp.wedate,121)
left join 
(select b.uid,b.wedate,max(b._submission_time) _submission_time
from (select wp1.uid,wp1.wedate,_submission_time from [mindr-live].dbo.wef_nwef_mv_prep wp1
left join (select wp2.uid, max(wedate) wedate 
from [mindr-live].dbo.wef_nwef_mv_prep uv2
where duplicate is null
group by wp2.uid) a on a.uid = wp1.uid and wp1.wedate =a.wedate where a.wedate is not null
and wp1.duplicate is null 
) b group by b.uid,b.wedate) c on c.uid = wp.uid  and c.wedate = wp.wedate and c._submission_time = wp._submission_time 
where wp.duplicate is null and c.uid is not null                  
