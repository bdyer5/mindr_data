 cd "./"
#delimit ;
clear;
/*ses_pw*/
set more off;
/*set memory 700m;   removed 2024.05.14  */
capture log close;
log using "..\datasets\logs\ses_pw.log", replace;
odbc load,exec("
select
uid,
tlpin,
sector,
hhid,
/*hhchange,*/
/*newhhid,*/
sswkint,
ssdate,
/*womname,*/
/*husbname,*/
/*idenconf,*/
workerid,
ssstatus,
ssdoc,
ssdod,
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
sstv,
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
from [mindr-live].dbo.sespw_mv

") dsn("rammps");

fixdate ssdate ssdoc ssdod;

#delimit cr

save "..\datasets\stata\ses_pw.dta", replace
saveold "..\datasets\stata\ses_pw.dta",replace version(12)  /*restored 2024.06.10  removed 2024.05.14  */

log close
