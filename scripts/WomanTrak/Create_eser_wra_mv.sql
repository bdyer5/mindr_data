use [mindr-live] 
go 


if exists(select o.name from sysobjects o where o.name='eser_wra_mv')
begin 
drop view eser_wra_mv
end 
go 

create view eser_wra_mv as
select
sr.uid,
tlpin,
sector,
hhid,
womname,
husbname,
convert(smalldatetime,sr.eserdate,121) as eserdate,
workerid,
rpasnt,
rpdesc,
version,
today,
start,
[end],
hhchange,
newhhid,
idenconf,
/*pebfoodc, -- not in the dataset */
pebheighta,
/*form_order as formorder,-- not in the dataset */
schedule_id as scheduleid,
hours_of_fasting,
/*pebfood,*/
alt,
ast,
creatinine,
blood_urea_nitrogen,
total_carbon_dioxide,
calcium,
sodium,
potassium,
chloride,
glucose,
glu,
chol,
hdl,
trig,
ldl,
vldl,
/*pebhemo, -- not in the dataset */ 
bmp_hemolysis,
bmp_lipemia, /*bmp_lipemia_*/
bmp_icterus,
lp_hemolysis,
lp_lipemia, /*lp_lipemia_*/
lp_icterus,
/*pebsysto1, -- not in the dataset */ 
/*pebdiast1, -- not in the dataset */ 
/*pebsysto2, -- not in the dataset */ 
/*pebdiast2, -- not in the dataset */ 
/*pebweight, -- not in the dataset */ 
/*pebheight1, -- not in the dataset */ 
/*pebheight2, -- not in the dataset */ 
/*pebheight3, -- not in the dataset */ 
bmi,
/*pecgh7, -- not in the dataset */ 
/*pebrth7, -- not in the dataset */ 
/*peappt7, -- not in the dataset */ 
/*penaus7, -- not in the dataset */ 
/*pevmt7, -- not in the dataset */ 
/*peconv7, -- not in the dataset */ 
/*peswlh7, -- not in the dataset */ 
/*peswlf7, -- not in the dataset */ 
/*pehach7, -- not in the dataset */ 
/*pehfvr7, -- not in the dataset */ 
/*pelfvr7, -- not in the dataset */ 
/*pediar7, -- not in the dataset */ 
/*pedys7, -- not in the dataset */ 
/*pewdys7, -- not in the dataset */ 
/*pelabd7, -- not in the dataset */ 
/*peurin7, -- not in the dataset */ 
/*pevagd7, -- not in the dataset */ 
/*pespot7, -- not in the dataset */ 
/*pevbld7, -- not in the dataset */ 
/*pexn7, -- not in the dataset */ 
biomerker_name_bp,
biomerker_name_hb,
biomerker_name_alt,
biomerker_name_ast,
biomerker_name_calcium,
biomerker_name_sodium,
biomerker_name_potassium,
biomerker_name_creatinine,
biomerker_name_bun,
biomerker_name_total_co2,
specimentid,
_date_modified,
_duration,
_id,
_media_all_received,
_media_count,
_notes,
sr._submission_time,
_submitted_by,
_tags,
_total_media,
_uuid,
_version,
_xform_id,
biomerker_name_rbs,
duplicate,
id,
insert_time,
inserted_by,
instance_id,
update_time,
updateed_by,
webdiast1,
webdiast2,
webfood,
webfoodc,
webheight1,
webheight2,
webheight3,
webhemo,
websysto1,
websysto2,
webweight,
wvappt7,
wvbrth7,
wvcgh7,
wvconv7,
wvdiar7,
wvdys7,
wvhach7,
wvhfvr7,
wvlabd7,
wvlfvr7,
wvnaus7,
wvspot7,
wvswlf7,
wvswlh7,
wvurin7,
wvvagd7,
wvvbld7,
wvvmt7,
wvwdys7,
wvxn7

from all_eser_wra sr

left join 
----
(select b.uid,b.eserdate,max(b._submission_time) _submission_time
from (select sr1.uid,sr1.eserdate,_submission_time from [mindr-live].dbo.all_eser_wra sr1
left join (select sr2.uid, sr2.eserdate 
from [mindr-live].dbo.all_eser_wra sr2
where duplicate is null
group by sr2.uid,sr2.eserdate) a on a.uid = sr1.uid and sr1.eserdate =a.eserdate where a.eserdate is not null
and sr1.duplicate is null ) b group by b.uid,b.eserdate) c on c.uid = sr.uid  and c.eserdate = sr.eserdate and c._submission_time = sr._submission_time 
where sr.duplicate is null and c.uid is not null                  

-- select * from eser_wra_mv

-- select * from all_eser_wra --146
-- select distinct uid from all_eser_wra

-- select sr2.uid, sr2.eserdate 
-- from [mindr-live].dbo.all_eser_wra sr2
-- where duplicate is not null
-- group by sr2.uid,sr2.eserdate -- 145 
-- -- 042926 is flagged for a duplicate 
-- having count(*)>1