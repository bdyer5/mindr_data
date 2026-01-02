USE [mindr-live]
GO

WITH UnpivotedData AS (
    -- Unpivot the first set of columns
    SELECT UID, value, 'Set1' AS set_type
    FROM uvf_2
    UNPIVOT (
        value FOR metric IN (uvcrl11, uvcrl21, uvcrl31)
    ) AS unpvt1

    UNION ALL

    -- Unpivot the second set of columns
    SELECT UID, value, 'Set2' AS set_type
    FROM uvf_2
    UNPIVOT (
        value FOR metric IN (uvhc11, uvhc21, uvhc31)
    ) AS unpvt2

    UNION ALL

    -- Unpivot the third set of columns
    SELECT UID, value, 'Set3' AS set_type
    FROM uvf_2
    UNPIVOT (
        value FOR metric IN (uvfl11, uvfl21, uvfl31)
    ) AS unpvt3
),
RankedData AS (
    SELECT uid, value, set_type,
           ROW_NUMBER() OVER (PARTITION BY [uid], set_type ORDER BY value) AS rn,
           COUNT(value) OVER (PARTITION BY [uid], set_type) AS cnt
    FROM UnpivotedData
)
SELECT [uid], 
       -- Median for Set1 (crl)
       Round(AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,2)) END),4) AS crl_median,
       
       -- Median for Set2 (hc)
       Round(AVG(CASE WHEN set_type = 'Set2' THEN value END),4) AS hc_median,

       -- Median for Set3 (fl)
       round(AVG(CASE WHEN set_type = 'Set3' THEN value END),4) AS fl_median,

       -- First formula using the median from Set1
       (40.9041 + (3.21585 * (POWER(AVG(CASE WHEN set_type = 'Set1' THEN value * 10 END), 0.5))) + 
        (0.348956 * AVG(CASE WHEN set_type = 'Set1' THEN value * 10 END))) / 7 AS uvf2_ga_1,

       -- Second formula using Set2 (hc) and Set3 (fl)
       EXP(0.03243 * POWER(LOG(AVG(CASE WHEN set_type = 'Set2' THEN value END)), 2) + 0.001644 * (AVG(CASE WHEN set_type = 'Set3' THEN value  END)) * LOG(AVG(CASE WHEN set_type = 'Set2' THEN value  END)) + 
           3.813) AS uvf2_ga_2
       
	  -- loge(GA)= 0.03243 × (loge(HC))2+ 0.001644 × FL × loge(HC) + 3.813

FROM RankedData
WHERE rn IN (FLOOR((cnt + 1) / 2.0), CEILING((cnt + 1) / 2.0))
AND uid IN ('220418', '365094', '937332', '040044', '418767', '774299')
GROUP BY [uid];



select uid,uvf_ga,uvf_lmp_date,psf_lmp_date,psflmp from wtrak_pw 
where uid in ('220418',
'365094',
'937332',
'040044',
'418767',
'774299')
order by uid asc


select * from all_uvf
where uid in ('220418',
'365094',
'937332',
'040044',
'418767',
'774299')
order by uid asc



select * from uvf_2
where uid in ('220418',
'365094',
'937332',
'040044',
'418767',
'774299')
order by uid asc

