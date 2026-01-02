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
/*woman_status,*/
bgdob as wom_dob,
/*age,*/
allocated_arm as arm,
/*age_grp,*/
/*dobyy,*/
/*dobdd,*/
/*dobmm,*/
convert(smalldatetime,dod,121) as wom_dod,
/*pef_eligable,*/
pef_eligible,
/*pef_status,*/
pefstatus as pef_status,
pedate as pef_date,
/*convert(smalldatetime,pef_done_date,121) as pef_done_date,*/
peconsent as pef_consent,
/*pef_consent,*/
convert(smalldatetime,pefb_done_date,121) as pefb_date,
pefb_status,
/*pefstatus,*/
psfstatus as psf_status,
psf_date,
last_psf_status,
last_psf_date,
psfurt,
psfurt_date,
ga_at_psfurt,
psflmp,
/*convert(smalldatetime,psf_done_date,121) as psf_done_date,*/
/*psf_eligable,*/
/*convert(smalldatetime,psf_lmp_date,121) as psf_lmp_date,*/
/*psf_status,*/
/*psf_urt,*/
/*convert(smalldatetime,saf_done_date,121) as saf_done_date,*/
/*saf_past_order,*/
/*saf_status,*/
/*safdate,*/
/*last_safstatus,*/
convert(smalldatetime,last_safdate,121) as saf_date,
safstatus as saf_status,
uvf_done_date as uvf_date,
uvf_status,
uvf_ga,
uvf_lmp_date,
supp_status,
saf_flow_status,
convert(smalldatetime,ses_done_date,121) as ses_date,
ses_status,
convert(smalldatetime,mpf_done_date,121) as mpf_date,
mpf_status,
convert(smalldatetime,mpfb_done_date,121) as mpfb_date,
mpfb_status,
lpfdate as lpf_date,
lpfstatus as lpf_status,
/*convert(smalldatetime,lpf_done_date,121) as lpf_date,*/
/*lpf_status,*/
convert(smalldatetime,lpfb_done_date,121) as lpfb_date,
lpfb_status,
bnfdate as bnf_date,
/*convert(smalldatetime,bnf_done_date,121) as bnf_date,*/
/*bnf_status,*/
/*bnfstatus,*/
/*convert(smalldatetime,fbaf_done_date,121) as fbaf_date,*/
/*fbaf_status,*/
/*convert(smalldatetime,ibaf_done_date,121) as ibaf_date,*/
/*ibaf_status,*/
/*convert(smalldatetime,mbaf_done_date,121) as mbaf_date,*/
/*mbaf_status,*/
mbafdate as mbaf_date ,
mbafstatus as mbaf_status,
/*convert(smalldatetime,i1mop_done_date,121) as i1mop_date,*/
/*i1mop_status,*/
convert(smalldatetime,m1mop_done_date,121) as m1mop_date,
m1mop_status,
convert(smalldatetime,mopb_done_date,121) as mopb_date,
mopb_status,
/*convert(smalldatetime,outcome_date,121) as outcome_date,*/
/*outcome_status,*/
/*mpf_ga,*/
/*lmp_status,*/
/*chld1vitsts,*/
/*chld2vitsts,*/
/*chld3vitsts,*/
bgoutc as outc,
/*bgoutcru as outcru,*/
bgoutcsrc as outcsrc,
/*bgwoutc as woutc,*/
bgdoutc as doutc,
/*bgdoutcru as doutcru*/
fdose_date,
edose_date,
totdose_days,
totdose_mns,
totdose_bep,
pcomp_mns,
pcomp_bep
FROM [mindr-live].dbo.wtrak_pw
") dsn("rammps");

fixdate wom_dob bnf_date wom_dod lpf_date lpfb_date m1mop_date mbaf_date mpf_date mpfb_date mopb_date pef_date pefb_date psf_date saf_date uvf_date uvf_lmp_date ses_date psf_date last_psf_date psfurt_date psflmp saf_date bnf_date mbaf_date lpf_date doutc fdose_date edose_date;

#delimit cr

save "..\datasets\stata\wtrak_pw.dta", replace
saveold "..\datasets\stata\wtrak_pw.dta",replace version(12) 

log close
