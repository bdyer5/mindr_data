use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='sespw_mv')
begin 
drop view sespw_mv 
end 
go 

create view sespw_mv 
as 
select
se.uid,
tlpin,
sector,
hhid,
hhchange,
newhhid,
jw.jivitaweek as sswkint,
convert(smalldatetime,se.ssdate,121) as ssdate,
womname,
husbname,
idenconf,
workerid,
ssstatus,
convert(smalldatetime,se.ssdoc,121) as ssdoc,
convert(smalldatetime,se.ssdod,121) as ssdod,
sshdl1,
sshde1,
sshdo1,
 sshdo1s,
sshdemp1,
sshdtype1,
sshdtype1s,
sshdworkd1,
sshdvs2,
sshda2,
sshdl2,
sshde2,
sshdo2,
sshdo2s,
sshdemp2,
sshdtype2,
sshdtype2s,
sshdworkd2,
sshhm50,
sshhf50,
sshhm1949,
sshhf1949,
sshhs1949,
sshhm1318,
sshhf1318,
sshhs1318,
sshhm512,
sshhf512,
sshhs512,
sshhm04,
sshhf04,
sshhs04,
ssfmoutside,
ssfmincome,
ssreligion,
sscattle,
ssgoats,
sschickens,
ssducks,
ssland,
sslandu,
sselectric,
sssolar,
sscycle,
ssmotorc,
ssmrickshaw,
ssnmarickshaw,
sswoodbed,
ssclock,
sssewmach,
ssalmira,
ssdtable,
sstabfans,
sscng,
sstc as sstv,
sspc,
ssmobile,
ssradios,
sscfans,
sstubewell,
ssirrpump,
sstractor,
ssbatauto,
ssrefrig,
sslivrm,
ssgfloor,
ssroof,
sskitchen,
sstoilet,
ssdwater,
sscwater,
ssbwater,
sswwater,
ssawater,
ssfswor,
ssfsworh,
ssfspref,
ssfsprefh,
ssfslim,
ssfslimh,
ssfssome,
ssfssomeh,
ssfssmall,
ssfssmallh,
ssfsfew,
ssfsfewh,
ssfsnofood,
ssfsnofoodh,
ssfsnight,
ssfsnighth,
ssfswholed,
ssfswholedh,
version,
today,
start,
[end],
scheduleid
from [mindr-live].dbo.all_ses_pw se
join shapla.dbo.jivitaweek jw on jw.romandate = convert(smalldatetime,se.ssdate,121)
left join 
(select b.uid,b.ssdate,max(b._submission_time) _submission_time
from (select se1.uid,se1.ssdate,_submission_time from [mindr-live].dbo.all_ses_pw se1
left join (select se2.uid, max(ssdate) ssdate 
from [mindr-live].dbo.all_ses_pw se2
where duplicate is null
group by se2.uid) a on a.uid = se1.uid and se1.ssdate =a.ssdate where a.ssdate is not null
and se1.duplicate is null 

) b group by b.uid,b.ssdate) c on c.uid = se.uid  and c.ssdate = se.ssdate and c._submission_time = se._submission_time 
where se.duplicate is null and c.uid is not null  