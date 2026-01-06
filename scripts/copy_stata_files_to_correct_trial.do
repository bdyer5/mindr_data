// Set paths
local source_path "C:/Users/bdyer/OneDrive - Johns Hopkins/CHN/JiVitA/MiNDR/data/datasets/stata"
local wra_path "../datasets/stata/WRA_study/"
local pw_path "../datasets/stata/PW_study/"

// Copy file from source to destination ,replace
copy "`source_path'/aef_pw.dta" "`pw_path'" ,replace
copy "`source_path'/bnf.dta" "`pw_path'" ,replace
copy "`source_path'/drf_pw.dta" "`pw_path'" ,replace
copy "`source_path'/drf_wra.dta" "`wra_path'" ,replace
copy "`source_path'/dvf_pw.dta" "`pw_path'" ,replace
copy "`source_path'/dvf_wra.dta" "`wra_path'" ,replace
copy "`source_path'/fbaf.dta" "`pw_path'" ,replace
copy "`source_path'/i1mop.dta" "`pw_path'" ,replace
copy "`source_path'/ibaf.dta" "`pw_path'" ,replace
copy "`source_path'/lab_proc_pw.dta" "`pw_path'" ,replace
copy "`source_path'/lab_proc_wra.dta" "`wra_path'" ,replace
copy "`source_path'/lab_recv_pw.dta" "`pw_path'" ,replace
copy "`source_path'/lab_recv_wra.dta" "`wra_path'" ,replace
copy "`source_path'/lab_store_pw.dta" "`pw_path'" ,replace
copy "`source_path'/lab_store_wra.dta" "`wra_path'" ,replace
copy "`source_path'/lpf_pw.dta" "`pw_path'" ,replace
copy "`source_path'/lpfb_pw.dta" "`pw_path'" ,replace
copy "`source_path'/m1mop_pw.dta" "`pw_path'" ,replace
copy "`source_path'/m1mopb_pw.dta" "`pw_path'" ,replace
copy "`source_path'/mbaf.dta" "`pw_path'" ,replace
copy "`source_path'/mpf_pw.dta" "`pw_path'" ,replace
copy "`source_path'/mpfb_pw.dta" "`pw_path'" ,replace
//copy "`source_path'/nwef.dta" "`pw_path'" ,replace
copy "`source_path'/pef_pw.dta" "`pw_path'" ,replace
copy "`source_path'/pefb_pw.dta" "`pw_path'" ,replace
copy "`source_path'/psf.dta" "`pw_path'" ,replace
copy "`source_path'/pregtrak.dta" "`pw_path'" ,replace
copy "`source_path'/pregtrak_times.dta" "`pw_path'" ,replace
copy "`source_path'/px_pw.dta" "`pw_path'" ,replace
copy "`source_path'/px_wra.dta" "`wra_path'" ,replace
copy "`source_path'/saf_pw.dta" "`pw_path'" ,replace
copy "`source_path'/saf_wra.dta" "`wra_path'" ,replace
copy "`source_path'/serf_pw.dta" "`pw_path'" ,replace
//copy "`source_path'/serf_wra.dta" "`wra_path'" ,replace
copy "`source_path'/ses_pw.dta" "`pw_path'" ,replace
copy "`source_path'/ses_wra.dta" "`wra_path'" ,replace
copy "`source_path'/sif_pw.dta" "`pw_path'" ,replace
copy "`source_path'/sif_wra.dta" "`wra_path'" ,replace
copy "`source_path'/suf_pw.dta" "`wra_path'" ,replace
copy "`source_path'/suf_wra.dta" "`wra_path'" ,replace
copy "`source_path'/urf.dta" "`pw_path'" ,replace
copy "`source_path'/uvf.dta" "`pw_path'" ,replace
copy "`source_path'/wef_nwef_all.dta" "`pw_path'" ,replace
copy "`source_path'/wef_nwef_all.dta" "`wra_path'" ,replace
copy "`source_path'/wmf_pw.dta" "`pw_path'" ,replace
copy "`source_path'/wmf_wra.dta" "`wra_path'" ,replace
copy "`source_path'/woman_pw.dta" "`pw_path'" ,replace
copy "`source_path'/woman_wra.dta" "`wra_path'" ,replace
copy "`source_path'/wra_1b_wra.dta" "`wra_path'" ,replace
copy "`source_path'/wra_3b_wra.dta" "`wra_path'" ,replace
copy "`source_path'/wra_eb_wra.dta" "`wra_path'" ,replace
copy "`source_path'/wratrak.dta" "`wra_path'" ,replace
copy "`source_path'/wravf_e_wra.dta" "`wra_path'" ,replace
copy "`source_path'/wravf_f_wra.dta" "`wra_path'" ,replace
copy "`source_path'/wravf_m_wra.dta" "`wra_path'" ,replace
//copy "`source_path'/wtrak_pw.dta" "`pw_path'" ,replace
//copy "`source_path'/wtrak_wra.dta" "`wra_path'" ,replace