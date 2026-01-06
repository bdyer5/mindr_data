To Generate Datasets 
1. restore DB (currently 5_mindr_Wednesday_5P- this is actually mindr-live so don't worry ) 
 -this is a manual backup by Brian from the regular DB backup for ugency of data to UMD 
2. add mindr_wra_compliance_20241015 data from Sujan
3. add mindr_pw_compliance_20241015 data from Sujan
4. add mindr_ga from C:\Users\bdyer\OneDrive - Johns Hopkins\CHN\JiVitA\MiNDR\data\scripts\WomanTrak\ultrasound_ ga_data\20250520\mindr_ga_20250520.csv
5. run Create_psf_mv.sql
6. run Create_wmf_pw.
6. run Create_m1mop_mv.sql
7. run Create_ses_mv.sql 
8. run create flow diagram pw 
9. run create flow diagram wra



-- note: 20250804 
I think I need to repull data , especially for : 
WEF NWEF - lots of nwe marry dates repulled 
SAF - 1 change made in the DB 

-- 20250926 

---To Generate Datasets 
1. restore DB (currently 6_mindr_live_Thursday from 20250925- this is actually mindr-live so don't worry ) 
2. add mindr_wra_compliance_20241015 data from Sujan
3. add mindr_pw_compliance_20241015 data from Sujan
4. add mindr_ga from C:\Users\bdyer\OneDrive - Johns Hopkins\CHN\JiVitA\MiNDR\data\scripts\WomanTrak\ultrasound_ ga_data\20250603\mindr_ga_20250603.csv
5. C:\Users\bdyer\OneDrive - Johns Hopkins\CHN\JiVitA\MiNDR\data\scripts\WomanTrak\LSI\indices_pw 
6. C:\Users\bdyer\OneDrive - Johns Hopkins\CHN\JiVitA\MiNDR\data\scripts\WomanTrak\LSI\indices_wra
7. run Create_psf_mv.sql
8. run Create_m1mop_mv.sql
9. run Create_sespw_mv.sql 
10. run Create_seswra_mv.sql 
11. run Create_wmfpw_mv.sql 
12. run Create_wmfwra_mv.sql 
13. run Create nwef_mv_prep_20250722.sql
14. run Create wef_mv_prep_20250722.sql
15. run Create wef_nwef_mv_prep_20250722.sql
16. run create flow diagram pw 
17. run create flow diagram wra


--20260102 
-- using the most recent data freeze
1. restored mindr_live_20250925_20251028.7z
2. run scripts\run_generatescripts.do
3. now compare with the posted version on Sharepoint. 
    - copy sharepoint dta folders to datasets folder 
    - run files in crosscheck_dta_files against the posted dataset.
    - note: all match except for some woman child husband names that were removed.


-- 20260102 
-- using the most current DB 
1. restore DB
--2. removed mindr_pw_compliance_20241015 reference from flow diagram Create_flow_diagram_pw_Followup__20250925_20260102.sql
3. add mindr_ga from C:\Users\bdyer\OneDrive - Johns Hopkins\CHN\JiVitA\MiNDR\data\scripts\WomanTrak\ultrasound_ ga_data\20250603\mindr_ga_20250603.csv
4. C:\Users\bdyer\OneDrive - Johns Hopkins\CHN\JiVitA\MiNDR\data\scripts\WomanTrak\LSI\indices_pw 
5. C:\Users\bdyer\OneDrive - Johns Hopkins\CHN\JiVitA\MiNDR\data\scripts\WomanTrak\LSI\indices_wra
