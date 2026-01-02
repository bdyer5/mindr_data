use [mindr-live]
go 


if exists(select o.name from sysobjects o where o.name='pw_enrollment_consent')
begin 
drop view pw_enrollment_consent
end 
go 

create view pw_enrollment_consent  as 
select uid, pe_consent 
from pef_mv where pe_consent=1
            
