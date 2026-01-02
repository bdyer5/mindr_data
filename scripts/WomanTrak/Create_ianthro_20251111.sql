use [mindr-live]
go


-- CREATE infant Anthropometry table
if exists(select * from sysobjects where name='ianthro_prep')
drop table ianthro_prep
go 

print ''
print '1. Insert all child records into ianthro_prep'
print ''
select distinct c1.uid as childuid,
c1.w_uid as momuid,
w.arm_pw as arm,
null as wt_birth,
null as len_birth,
null as muac_birth,
null as hc_birth,
null as cc_birth,
null as i1status,
null as wt1,
null as len1,
null as muac1,
null as hc1,
null as cc1,
null as i3status,
null as wt3,
null as len3,
null as muac3,
null as hc3,
null as cc3, 
null as i6status,
null as wt6,
null as len6,
null as muac6,
null as hc6,
null as cc6,
null as ib_ht,
null as fb_ht,
null as ib_muac,
null as fb_muac,
null as ib_hc,
null as fb_hc,
null as ib_cc,
null as fb_cc,
null as anthsrc

into ianthro_prep
from  [mindr-live].dbo.child c1
join pregtrak w on w.uid=c1.w_uid
where c1.w_uid in (select uid from [mindr-live].dbo.pregtrak where pef_consent='1')
--and c1.w_uid not in (select uid from wtrak where pdroutc ='4' )
go



alter table ianthro_prep
alter column ib_ht decimal (10,1)
go 
alter table ianthro_prep
alter column fb_ht decimal (10,1)
go 
alter table ianthro_prep
alter column len_birth decimal (10,1)
go
alter table ianthro_prep
alter column muac_birth decimal (10,1)
go
alter table ianthro_prep
alter column hc_birth decimal (10,1)
go
alter table ianthro_prep
alter column cc_birth decimal (10,1)
go
alter table ianthro_prep
alter column ib_muac decimal (10,1)
go 
alter table ianthro_prep
alter column fb_muac decimal (10,1)
go 
go 
alter table ianthro_prep
alter column wt_birth decimal (10,3)
go 
alter table ianthro_prep
alter column anthsrc char(10)
go 
alter table ianthro_prep
alter column wt1  decimal(10,3)
go 
alter table ianthro_prep
alter column len1 decimal(10,1)
go 
alter table ianthro_prep
alter column muac1 decimal(10,1)
go 
alter table ianthro_prep
alter column hc1 decimal(10,1)
go 
alter table ianthro_prep
alter column cc1 decimal(10,1) 
go 
alter table ianthro_prep
alter column wt3  decimal(10,3)
go 
alter table ianthro_prep
alter column len3 decimal(10,1)
go 
alter table ianthro_prep
alter column muac3 decimal(10,1)
go 
alter table ianthro_prep
alter column hc3 decimal(10,1)
go 
alter table ianthro_prep
alter column cc3 decimal(10,1) 
go 
alter table ianthro_prep
alter column wt6 decimal(10,3)
go 
alter table ianthro_prep
alter column len6 decimal(10,1)
go 
alter table ianthro_prep
alter column muac6 decimal(10,1)
go 
alter table ianthro_prep
alter column hc6 decimal(10,1)
go 
alter table ianthro_prep
alter column cc6 decimal(10,1) 


;WITH u AS (
    SELECT childuid, height
    FROM ibaf_mv
    CROSS APPLY (VALUES
        (CAST(ibheight1 AS decimal(10,1))),
        (CAST(ibheight2 AS decimal(10,1))),
        (CAST(ibheight3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set ib_ht = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 



;WITH u AS (
    SELECT childuid, height
    FROM fbaf_mv
    CROSS APPLY (VALUES
        (CAST(fbheight1 AS decimal(10,1))),
        (CAST(fbheight2 AS decimal(10,1))),
        (CAST(fbheight3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set fb_ht = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 


;WITH u AS (
    SELECT childuid, height
    FROM ibaf_mv
    CROSS APPLY (VALUES
        (CAST(ibmuac1 AS decimal(10,1))),
        (CAST(ibmuac2 AS decimal(10,1))),
        (CAST(ibmuac3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set ib_muac = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 



;WITH u AS (
    SELECT childuid, height
    FROM fbaf_mv
    CROSS APPLY (VALUES
        (CAST(fbmuac1 AS decimal(10,1))),
        (CAST(fbmuac2 AS decimal(10,1))),
        (CAST(fbmuac3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set fb_muac = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 




;WITH u AS (
    SELECT childuid, height
    FROM ibaf_mv
    CROSS APPLY (VALUES
        (CAST(ibhc1 AS decimal(10,1))),
        (CAST(ibhc2 AS decimal(10,1))),
        (CAST(ibhc3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set ib_hc = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 



;WITH u AS (
    SELECT childuid, height
    FROM fbaf_mv
    CROSS APPLY (VALUES
        (CAST(fbhc1 AS decimal(10,1))),
        (CAST(fbhc2 AS decimal(10,1))),
        (CAST(fbhc3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set fb_hc = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 





;WITH u AS (
    SELECT childuid, height
    FROM ibaf_mv
    CROSS APPLY (VALUES
        (CAST(ibcc1 AS decimal(10,1))),
        (CAST(ibcc2 AS decimal(10,1))),
        (CAST(ibcc3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set ib_cc = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 



;WITH u AS (
    SELECT childuid, height
    FROM fbaf_mv
    CROSS APPLY (VALUES
        (CAST(fbcc1 AS decimal(10,1))),
        (CAST(fbcc2 AS decimal(10,1))),
        (CAST(fbcc3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set fb_cc = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 




update ianthro_prep 
set wt_birth = coalesce(fbweight,ibweight),
len_birth = coalesce(k.fb_ht,k.ib_ht),
muac_birth = coalesce(k.fb_muac,k.ib_muac),
hc_birth = coalesce(k.fb_hc,k.ib_hc),
cc_birth = coalesce(k.fb_cc,k.ib_cc),
anthsrc = case when fbbtimehr<>'' and fbbtimemn<>'' and fbbtimeap<>''
then 'fbaf'
when ibbtimehr<>'' and ibbtimemn<>'' and ibbtimeap<>''
then 'ibaf' end 
from ianthro_prep k 
left join [mindr-live].dbo.ibaf_mv  i on k.childuid=i.CHILDUID
left join [mindr-live].dbo.fbaf_mv  f on f.childuid = k.childuid 
where wt_birth is null 





;WITH u AS (
    SELECT childuid, height
    FROM i1mop_mv
    CROSS APPLY (VALUES
        (CAST(i1height1 AS decimal(10,1))),
        (CAST(i1height2 AS decimal(10,1))),
        (CAST(i1height3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set len1 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 



;WITH u AS (
    SELECT childuid, height
    FROM i1mop_mv
    CROSS APPLY (VALUES
        (CAST(i1muac1 AS decimal(10,1))),
        (CAST(i1muac2 AS decimal(10,1))),
        (CAST(i1muac3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set muac1 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 





;WITH u AS (
    SELECT childuid, height
    FROM i1mop_mv
    CROSS APPLY (VALUES
        (CAST(i1hc1 AS decimal(10,1))),
        (CAST(i1hc2 AS decimal(10,1))),
        (CAST(i1hc3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set hc1 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 




;WITH u AS (
    SELECT childuid, height
    FROM i1mop_mv
    CROSS APPLY (VALUES
        (CAST(i1cc1 AS decimal(10,1))),
        (CAST(i1cc2 AS decimal(10,1))),
        (CAST(i1cc3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set cc1 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 



update ianthro_prep 
set i1status = i1.i1status,
wt1 = i1.i1weight
from ianthro_prep k 
left join [mindr-live].dbo.i1mop_mv  i1 on k.childuid=i1.CHILDUID




;WITH u AS (
    SELECT childuid, height
    FROM i36mop_mv
    CROSS APPLY (VALUES
        (CAST(i3height1 AS decimal(10,1))),
        (CAST(i3height2 AS decimal(10,1))),
        (CAST(i3height3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set len3 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 




;WITH u AS (
    SELECT childuid, height
    FROM i36mop_mv
    CROSS APPLY (VALUES
        (CAST(i3muac1 AS decimal(10,1))),
        (CAST(i3muac2 AS decimal(10,1))),
        (CAST(i3muac3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set muac3 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 





;WITH u AS (
    SELECT childuid, height
    FROM i36mop_mv
    CROSS APPLY (VALUES
        (CAST(i3hc1 AS decimal(10,1))),
        (CAST(i3hc2 AS decimal(10,1))),
        (CAST(i3hc3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set hc3 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 




;WITH u AS (
    SELECT childuid, height
    FROM i36mop_mv
    CROSS APPLY (VALUES
        (CAST(i3cc1 AS decimal(10,1))),
        (CAST(i3cc2 AS decimal(10,1))),
        (CAST(i3cc3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set cc3 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 



update ianthro_prep 
set i3status = i3.i3status,
wt3 = i3.i3weight
from ianthro_prep k 
left join [mindr-live].dbo.i36mop_mv  i3 on k.childuid=i3.CHILDUID






;WITH u AS (
    SELECT childuid, height
    FROM i69mop_mv
    CROSS APPLY (VALUES
        (CAST(i6height1 AS decimal(10,1))),
        (CAST(i6height2 AS decimal(10,1))),
        (CAST(i6height3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set len6 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 



;WITH u AS (
    SELECT childuid, height
    FROM i69mop_mv
    CROSS APPLY (VALUES
        (CAST(i6muac1 AS decimal(10,1))),
        (CAST(i6muac2 AS decimal(10,1))),
        (CAST(i6muac3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set muac6 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 





;WITH u AS (
    SELECT childuid, height
    FROM i69mop_mv
    CROSS APPLY (VALUES
        (CAST(i6hc1 AS decimal(10,1))),
        (CAST(i6hc2 AS decimal(10,1))),
        (CAST(i6hc3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set hc6 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 




;WITH u AS (
    SELECT childuid, height
    FROM i69mop_mv
    CROSS APPLY (VALUES
        (CAST(i6cc1 AS decimal(10,1))),
        (CAST(i6cc2 AS decimal(10,1))),
        (CAST(i6cc3 AS decimal(10,1)))
    ) v(height)
    WHERE height IS NOT NULL
),
ranked AS (
    SELECT
        childuid,
        height,
        ROW_NUMBER() OVER (PARTITION BY childuid ORDER BY height) AS rn,
        COUNT(*)    OVER (PARTITION BY childuid)                 AS cnt
    FROM u
),
c AS (
    SELECT
        childuid,
        CASE
            WHEN cnt % 2 = 1
                THEN CAST(MAX(CASE WHEN rn = (cnt + 1) / 2 THEN height END) AS decimal(10,1))
            ELSE
                CAST(AVG(CASE WHEN rn IN (cnt / 2, cnt / 2 + 1) THEN height END) AS decimal(10,1))
        END AS median_height
    FROM ranked
    GROUP BY childuid, cnt
)
update ianthro_prep
set cc6 = c.median_height from 
ianthro_prep ip 
right join 
c on c.childuid = ip.childuid 



update ianthro_prep 
set i6status = i6.i6status,
wt6 = i6.i6weight
from ianthro_prep k 
left join [mindr-live].dbo.i69mop_mv  i6 on k.childuid=i6.CHILDUID
