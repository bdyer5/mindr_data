 cd "./"
#delimit ;
clear;
/*p_test*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\p_test.log", replace;
odbc load,exec("SELECT
uid,
tlpin,
sector,
hhid,
/*woman_status,*/
bgdob as wom_dob,
/*age,*/
age_pef,
age_wef,
allocated_arm as arm_pw,
/*age_grp,*/
/*dobyy,*/
/*dobdd,*/
/*dobmm,*/
/*convert(smalldatetime,dod,121) as wom_dod, -- ez said no deaths is this true ?  - create a dod var to catch these*/ 
/*pef_eligable,*/
/*pef_eligible,*/
/*pef_status,*/
peconsent as pef_consent,
pedate as pef_date,
pefstatus as pef_status,
/*convert(smalldatetime,pef_done_date,121) as pef_done_date,*/
/*pef_consent,*/
/*convert(smalldatetime,pefb_done_date,121) as pefb_date,*/
/*pefb_status,*/
peb_date,
peb_time,
peb_meal_time,
peb_fast_time ,
peb_status,
/*psfstatus as psf_status,*/
/*psf_date,*/
/*last_psf_status,*/
/*last_psf_date,*/
/*psfurt,*/
psfurt_date as urtpos_psf,
/*ga_at_psfurt as ga_psf,*/
/*psflmp as lmp_psf, -- excluded 20250604*/
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
/*convert(smalldatetime,last_safdate,121) as saf_date,*/
/*safstatus as saf_status,*/
/*uvf_done_date as uvf_date,*/
/* excluded these 20250604 below*/
/*uvf_status,*/
/*uvf_ga,*/
/*uvf_lmp_date,*/
/*lmp_us,*/
/*ga_us,*/
bglmp,
bglmpru,
/*bgga_dy,*/
bgga,
bgoutc as outc,
/*bgoutcru as outcru,*/
bgoutcsrc as outcsrc,
/*bgwoutc as woutc,*/
bgdoutc as outcd,
parity,
gravidity,
lsi,
/*supp_status,*/
saf_flow_status as ever_supp,
/*convert(smalldatetime,ses_done_date,121) as ses_date,*/
/*ses_status,*/
convert(smalldatetime,mpf_done_date,121) as mp_date,
mpf_status as mp_status,
mpb_date,
mpb_time,
mpb_meal_time,
mpb_fast_time,
mpb_status,
mid_preg_status,
lpfdate as lp_date,
lpfstatus as lp_status,
lpb_date,
lpb_time,
lpb_meal_time,
lpb_fast_time,
lpb_status,
late_preg_status,
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
m1b_date,
m1b_time,
m1b_meal_time,
m1b_fast_time,
m1b_status
/*convert(smalldatetime,mopb_done_date,121) as mopb_date,*/
/*mopb_status,*/
/*convert(smalldatetime,outcome_date,121) as outcome_date,*/
/*outcome_status,*/
/*mpf_ga,*/
/*lmp_status,*/
/*chld1vitsts,*/
/*chld2vitsts,*/
/*chld3vitsts,*/
/*bgdoutcru as doutcru*/
/*fdose_date,*/
/*edose_date,*/
/*totdose_days,*/
/*totdose_mns,*/
/*totdose_bep,*/
/*pcomp_mns,*/
/*pcomp_bep*/
FROM [mindr-live].dbo.wtrak_pw") dsn("rammps");

fixdate wom_dob bnf_date lp_date lpb_date m1mop_date mp_date mpb_date pef_date peb_date urtpos_psf mbaf_date outcd m1b_date bglmp;

#delimit cr

/* Convert all %tc variables to SAS-friendly seconds and add a readable format*/
quietly ds, has(format %tc*)
local tcvars `r(varlist)'

foreach v of local tcvars {
    gen double `v'_sasdt = floor(`v'/1000)
    label var `v'_sasdt "SAS datetime seconds from `v'"
        order `v'_sasdt ,after(`v')
        drop `v'
        rename `v'_sasdt `v'
    * Keep original as-is; recipient will apply DATETIME20. format in SAS
}


save "..\datasets\stata\pregtrak_times.dta", replace
saveold "..\datasets\stata\pregtrak_times.dta",replace version(12) 

log close
