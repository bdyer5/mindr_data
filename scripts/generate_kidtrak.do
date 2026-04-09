 cd "./"
#delimit ;
clear;
/*kidtrak*/
set more off;
/*set memory 700m;   removed 2024.05.14  */

capture log close;
log using "..\datasets\logs\kidtrak.log", replace;
odbc load,exec("SELECT
childuid,
RIGHT('000000' + CAST(uid as varchar), 6) as uid,
RIGHT('00' + CAST(tlpin as varchar), 2) as tlpin,
RIGHT('000' + CAST(sector as varchar), 3) as sector,
RIGHT('0000' + CAST(hhid as varchar), 4) as hhid,
pef_consent,
CAST(arm_pw as varchar) as arm_pw,
sex,
bggady,
bggawk,
dob,
tob,
sibling,
sibling_twin,
agehrsanth,
agefd_anthro,
anthro_date,
anthro_location,
anthro72,
dod,
tod,
todsrc,
deadaged,
dodru,
censrvital,
censrdate,
censraged,
aged_ibaf,
aged_fbaf,
aged_birth,
wt_birth,
len_birth,
muac_birth,
hc_birth,
cc_birth,
wazig_birth,
lazig_birth,
hczig_birth,
wlzig_birth,
wapig_birth,
lapig_birth,
hcpig_birth,
sga3_ig,
sga10_ig,
i1date,
i1status,
aged1,
agem1,
wt1,
len1,
muac1,
hc1,
cc1,
waz1,
laz1,
wlz1,
hcz1,
i3date,
i3status,
aged3,
agem3,
wt3,
len3,
muac3,
hc3,
cc3,
i6date,
i6status,
aged6,
agem6,
wt6,
len6,
muac6,
hc6,
cc6,
vstatus,
vstatus_date
FROM [mindr-live].dbo.kidtrak_t2") dsn("rammps");

fixdate censrdate dob anthro_date dod i1date i3date i6date ;

fixdatetime tob tod;

#delimit cr

destring agehrsanth, force replace
destring agefd_anthro, force replace
destring wt_birth, force replace
destring len_birth, force replace
destring muac_birth, force replace
destring hc_birth, force replace
destring cc_birth, force replace
destring wt1, force replace
destring len1, force replace
destring muac1, force replace
destring hc1, force replace
destring cc1, force replace
destring aged_ibaf, force replace
destring aged_fbaf, force replace
destring aged1, force replace
destring wt3, force replace
destring len3, force replace
destring muac3, force replace
destring hc3, force replace
destring cc3, force replace
destring wt6, force replace
destring len6, force replace
destring muac6, force replace
destring hc6, force replace
destring cc6, force replace

/*destring len_birth_imp, force replace*/
/*destring cc_birth_imp, force replace*/
/*destring hc_birth_imp, force replace*/
/*destring muac_birth_imp, force replace*/
/**/
/*destring sga_centile, force replace */
/*destring sga_10, force replace */
/*destring sga_3, force replace */
destring wazig_birth, force replace
destring lazig_birth, force replace
destring hczig_birth, force replace
destring wlzig_birth, force replace
/*destring waz1, force replace */
/*destring laz1, force replace */
/*destring wlz1, force replace */
/*destring hcz1, force replace */
destring wapig_birth, force replace
destring lapig_birth, force replace
destring hcpig_birth, force replace


save "..\datasets\stata\kidtrak.dta", replace
saveold "..\datasets\stata\kidtrak.dta",replace version(12) 

log close
