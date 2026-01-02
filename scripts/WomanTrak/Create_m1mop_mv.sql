use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='m1mop_mv')
begin 
drop view m1mop_mv
end 
go 

Create view m1mop_mv as 
select 



mp.uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
womname,
husbname,
idenconf,
convert(smalldatetime,mp.m1date,121) as m1date,
workerid,
m1status,
convert(smalldatetime,m1dod,121) as m1dod,
/*section B*/
m1cgh30,
m1cgh30d,
m1cghtx1,
m1cghtx2,
m1cgh7,
m1cgh7n,
m1brth30,
m1brth30d,
m1brthtx1,
m1brthtx2,
m1brth7,
m1brth7n,
m1conv30,
m1conv30d,
m1convtx1,
m1convtx2,
m1conv7,
m1conv7n,
m1swlh30,
m1swlh30d,
m1swlhtx1,
m1swlhtx2,
m1swlh7,
m1swlh7n,
m1swlf30,
m1swlf30d,
m1swlftx1,
m1swlftx2,
m1swlf7,
m1swlf7n,
m1hach30,
m1hach30d,
m1hachtx1,
m1hachtx2,
m1hach7,
m1hach7n,
m1hfvr30,
m1hfvr30d,
m1hfvrtx1,
m1hfvrtx2,
m1hfvr7,
m1hfvr7n,
m1lfvr30,
m1lfvr30d,
m1lfvrtx1,
m1lfvrtx2,
m1lfvr7,
m1diar30,
m1diar30d,
m1diartx1,
m1diartx2,
m1diar7,
m1diar7n,
m1dys30,
m1dys30d,
m1dystx1,
m1dystx2,
m1dys7,
m1dys7n,
m1wdys30,
m1wdys30d,
m1wdystx1,
m1wdystx2,
m1wdys7,
m1labd30,
m1labd30d,
m1labdtx1,
m1labdtx2,
m1labd7,
m1labd7n,
m1urin30,
m1urin30d,
m1urintx1,
m1urintx2,
m1urin7,
m1urin7n,
m1vagd30,
m1vagd30d,
m1vagdtx1,
m1vagdtx2,
m1vagd7,
m1vagd7n,
m1xn30,
m1xn30d,
m1xntx1,
m1xntx2,
m1xn7,
m1xn7n,
/*End grp*/
/*seeff*/
m1tab30,
m1tabphoto30,
m1tabn30,
m1tab30o1,
/*e4re1*/
m1tabphoto301,
m1tabn301,
/*End grp*/
m1tab30o2,
/*e4re2*/
m1tabphoto302,
m1tabn302,
/*End grp*/
m1tab30o3,
/*e4re3*/
m1tabphoto303,
m1tabn303,
/*End grp*/
m1tab30o4,
/*e4re4*/
m1tabphoto304,
m1tabn304,
/*End grp*/
m1tab30o5,
/*e4re5*/
m1tabphoto305,
m1tabn305,
/*End grp*/
version,
today,
start,
[end],
/*mp.formorder,*/
mp.schedule_id as scheduleid,
insert_time,
update_time,
mp._submission_time,
/*_submitted_by,*/
/*_date_modified,*/
_xform_id,
instance_id as instanceid,
/*_duration,*/
/*_media_all_received,*/
/*_media_count,*/
_id,
_uuid,
_version--,
--duplicate
from [mindr-live].dbo.all_m1mop mp
left join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,mp.m1date,121) 
left join 
(select b.uid,b.m1date,max(b._submission_time) _submission_time
from (select mp1.uid,mp1.m1date,_submission_time from [mindr-live].dbo.all_m1mop mp1
left join (select mp2.uid, max(m1date) m1date 
from [mindr-live].dbo.all_m1mop mp2
where duplicate is null
group by mp2.uid) a on a.uid = mp1.uid and mp1.m1date =a.m1date where a.m1date is not null
and mp1.duplicate is null 
) b group by b.uid,b.m1date) c on c.uid = mp.uid  and c.m1date = mp.m1date and c._submission_time = mp._submission_time 
where mp.duplicate is null and c.uid is not null                  

