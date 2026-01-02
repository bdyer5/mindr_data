 cd "./"
#delimit ;
clear;
/*wtrak_pw*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\wtrak_pw.log", replace;
odbc load,exec("
SELECT
uid,
tlpin,
sector,
hhid,
woman_status,
age,
age_grp,
dobyy,
dobdd,
dobmm,
bgdob,
allocated_arm,
convert(smalldatetime,bnf_done_date,121) as bnf_done_date,
bnf_status,
convert(smalldatetime,dod,121) as dod,
pef_eligable,
pef_status,
convert(smalldatetime,pef_done_date,121) as pef_done_date,
pef_consent,
convert(smalldatetime,pef_consent_date,121) as pef_consent_date,
convert(smalldatetime,pefb_done_date,121) as pefb_done_date,
pefb_status,
pef_eligible,
pefstatus,
peconsent,
pedate,
psfstatus,
psf_date,
last_psf_status,
last_psf_date,
psfurt,
psfurt_date,
psflmp,
convert(smalldatetime,psf_done_date,121) as psf_done_date,
psf_eligable,
convert(smalldatetime,psf_lmp_date,121) as psf_lmp_date,
psf_status,
psf_urt,
convert(smalldatetime,saf_done_date,121) as saf_done_date,
saf_past_order,
saf_status,
safstatus,
safdate,
last_safstatus,
last_safdate,
supp_status,
saf_flow_status,
convert(smalldatetime,ses_done_date,121) as ses_done_date,
ses_status,
convert(smalldatetime,mpf_done_date,121) as mpf_done_date,
mpf_status,
convert(smalldatetime,mpfb_done_date,121) as mpfb_done_date,
mpfb_status,
convert(smalldatetime,lpf_done_date,121) as lpf_done_date,
lpf_status,
convert(smalldatetime,lpfb_done_date,121) as lpfb_done_date,
lpfb_status,
convert(smalldatetime,fbaf_done_date,121) as fbaf_done_date,
fbaf_status,
convert(smalldatetime,ibaf_done_date,121) as ibaf_done_date,
ibaf_status,
convert(smalldatetime,mbaf_done_date,121) as mbaf_done_date,
mbaf_status,
convert(smalldatetime,i1mop_done_date,121) as i1mop_done_date,
i1mop_status,
convert(smalldatetime,m1mop_done_date,121) as m1mop_done_date,
m1mop_status,
mopb_status,
convert(smalldatetime,mopb_done_date,121) as mopb_done_date,
/*convert(smalldatetime,outcome_date,121) as outcome_date,*/
/*outcome_status,*/
mpf_ga,
lmp_status,
ga_at_psfurt,
bnfstatus,
bnfdate,
chld1vitsts,
chld2vitsts,
chld3vitsts,
mbafstatus,
mbafdate,
lpfstatus,
lpfdate,
bgoutc,
bgoutcru,
bgoutcsrc,
bgwoutc,
bgdoutc,
bgdoutcru
FROM [mindr-live].dbo.wtrak_pw
") dsn("rammps");

fixdate bgdob bnf_done_date dod fbaf_done_date i1mop_done_date ibaf_done_date lpf_done_date lpfb_done_date m1mop_done_date mbaf_done_date mpf_done_date mpfb_done_date mopb_done_date pef_consent_date pef_done_date pefb_done_date psf_done_date psf_lmp_date saf_done_date ses_done_date pedate psf_date last_psf_date psfurt_date psflmp safdate last_safdate bnfdate mbafdate lpfdate bgdoutc;

#delimit cr

save "..\datasets\stata\wtrak_pw.dta", replace
saveold "..\datasets\stata\wtrak_pw.dta",replace version(12) 

log close
