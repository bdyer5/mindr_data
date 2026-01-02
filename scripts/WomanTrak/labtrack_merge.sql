use [mindr-live]
go 

-- lab_store
-- lab_recv
-- lab_process

select ls.box_id,
ls.cell_number,
ls.sample_type,
ls.specimenid,
ls.aliquot_id,
lr.uid, 
lr.visit_type,
lr.sample_type,
case when lr.study_type =1 and  lr.visit_type =1 and lr.sample_type=1 then 'urine'
when lr.study_type =1 and lr.visit_type =1 and lr.sample_type=2 then 'stool' 
when lr.study_type =1 and lr.visit_type =1 and lr.sample_type=3 then 'serum'
when lr.study_type =1 and lr.visit_type =1 and lr.sample_type=4 then 'heparin'
when lr.visit_type =2 and lr.sample_type=1 then 'urine'
when lr.study_type =1 and lr.visit_type =2 and lr.sample_type=3 then 'serum'
when lr.study_type =1 and lr.visit_type =2 and lr.sample_type=4 then 'heparin' 
when lr.study_type =1 and lr.visit_type =3 and lr.sample_type=1 then 'urine'
when lr.study_type =1 and lr.visit_type =3 and lr.sample_type=2 then 'stool' 
when lr.study_type =1 and lr.visit_type =3 and lr.sample_type=3 then 'serum'
when lr.study_type =1 and lr.visit_type =3 and lr.sample_type=4 then 'heparin' end as sample_desc,
case when ls.study_type =2 then 'PW' when ls.study_type =1 then 'WRA' end as study 
from lab_store ls
left join lab_recv lr on lr.specimenid = ls.specimenid
