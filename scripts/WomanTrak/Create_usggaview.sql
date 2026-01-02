

use [mindr-live] 
go 

if exists(select o.name from sysobjects o where o.name='usggaview')
begin 
drop view usggaview
end 
go 


create view [dbo].[usggaview]
as


WITH UnpivotedData AS (
    -- Unpivot the first set of columns
    SELECT UID, uvfetus, value, 'Set1' AS set_type
    FROM uvf_mv
    UNPIVOT (
        value FOR metric IN (uvcrl11, uvcrl21, uvcrl31)
    ) AS unpvt1

    UNION ALL

    -- Unpivot the second set of columns
    SELECT UID, uvfetus, value, 'Set2' AS set_type
    FROM uvf_mv
    UNPIVOT (
        value FOR metric IN (uvhc11, uvhc21, uvhc31)
    ) AS unpvt2

    UNION ALL

    -- Unpivot the third set of columns
    SELECT UID, uvfetus, value, 'Set3' AS set_type
    FROM uvf_mv
    UNPIVOT (
        value FOR metric IN (uvfl11, uvfl21, uvfl31)
    ) AS unpvt3
    UNION ALL

    -- Unpivot the third set of columns
    SELECT UID, uvfetus, value, 'Set4' AS set_type
    FROM uvf_mv
    UNPIVOT (
        value FOR metric IN (uvcrl12, uvcrl22, uvcrl32)
    ) AS unpvt4
    UNION ALL
    -- Unpivot the third set of columns
    SELECT UID, uvfetus, value, 'Set5' AS set_type
    FROM uvf_mv
    UNPIVOT (
        value FOR metric IN (uvhc12, uvhc22, uvhc32)
    ) AS unpvt5
    UNION ALL
    -- Unpivot the third set of columns
    SELECT UID, uvfetus, value, 'Set6' AS set_type
    FROM uvf_mv
    UNPIVOT (
        value FOR metric IN (uvfl12,uvfl22, uvfl32)
    ) AS unpvt6
),
RankedData AS (
    -- Rank the values within each UID and set_type and get the total count
    SELECT uid, uvfetus, value, set_type,
           ROW_NUMBER() OVER (PARTITION BY [uid], set_type ORDER BY value) AS rn,
           COUNT(value) OVER (PARTITION BY [uid], set_type) AS cnt
    FROM UnpivotedData
),
MedianData AS (
    -- Handle the case for odd and even counts
    SELECT uid, uvfetus, set_type, value,
           -- Get the middle row(s) based on the count (even or odd)
           CASE 
               -- If the count is odd, return the exact middle row
               WHEN cnt % 2 = 1 AND rn = (cnt + 1) / 2 THEN 1
               -- If the count is even, return both middle rows
               WHEN cnt % 2 = 0 AND (rn = cnt / 2 OR rn = cnt / 2 + 1) THEN 1
               ELSE 0
           END AS is_median
    FROM RankedData
)
SELECT [uid], uvfetus,
       -- Median for Set1 (crl)
       AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,4)) END) AS crl_median,
       
       -- Median for Set2 (hc)
       AVG(CASE WHEN set_type = 'Set2' THEN cast(value as decimal(10,4)) END) AS hc_median,

       -- Median for Set3 (fl)
       AVG(CASE WHEN set_type = 'Set3' THEN cast(value as decimal(10,4)) END) AS fl_median,
       -- Median for Set3 (fl)
       AVG(CASE WHEN set_type = 'Set4' THEN cast(value as decimal(10,4)) END) AS crl_median2,

       -- First formula using the median from Set1
       (40.9041 + (3.21585 * (POWER(AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,4)) * 10 END), 0.5))) + 
        (0.348956 * AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,4)) * 10 END))) / 7 AS uvf2_ga_1,
       -- First formula using the median from Set1
       (40.9041 + (3.21585 * (POWER(AVG(CASE WHEN set_type = 'Set4' THEN cast(value as decimal(10,4)) * 10 END), 0.5))) + 
        (0.348956 * AVG(CASE WHEN set_type = 'Set4' THEN cast(value as decimal(10,4)) * 10 END))) / 7 AS uvf2_ga_1b,
       -- Second formula using Set2 (hc) and Set3 (fl)
       EXP(0.03243 * POWER(LOG(AVG(CASE WHEN set_type = 'Set2' THEN cast(value as decimal(10,4)) *10 END)), 2) + 0.001644 * AVG(CASE WHEN set_type = 'Set3' THEN cast(value as decimal(10,4))  * 10 END) * LOG(AVG(CASE WHEN set_type = 'Set2' THEN cast(value as decimal(10,4))  * 10  END)) + 
           3.813)/7.0 AS uvf2_ga_2,
       -- Second formula using Set2 (hc) and Set3 (fl)
       EXP(0.03243 * POWER(LOG(AVG(CASE WHEN set_type = 'Set5' THEN cast(value as decimal(10,4)) *10 END)), 2) + 0.001644 * AVG(CASE WHEN set_type = 'Set6' THEN cast(value as decimal(10,4))  * 10 END) * LOG(AVG(CASE WHEN set_type = 'Set5' THEN cast(value as decimal(10,4))  * 10  END)) + 
           3.813)/7.0 AS uvf2_ga_2b,
		   		   case when  
         AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,4)) *10 END) <=95 and uvfetus is null
         then 
        (40.9041 + (3.21585 * (POWER(AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,4)) * 10 END), 0.5))) + 
        (0.348956 * AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,4)) * 10 END))) / 7 
			when  AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,4)) *10 END) >95  and uvfetus is null
         then 
        EXP(0.03243 * POWER(LOG(AVG(CASE WHEN set_type = 'Set2' THEN cast(value as decimal(10,4)) *10 END)), 2) + 0.001644 * AVG(CASE WHEN set_type = 'Set3' THEN cast(value as decimal(10,4))  * 10 END) * LOG(AVG(CASE WHEN set_type = 'Set2' THEN cast(value as decimal(10,4)) * 10  END)) + 
           3.813)/7.0 
           		   when uvfetus = 2  
		   then ((case when 
                     AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,4)) *10 END) <=95 
         then 
        (40.9041 + (3.21585 * (POWER(AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,4)) * 10 END), 0.5))) + 
        (0.348956 * AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,4)) * 10 END))) / 7 
			when  AVG(CASE WHEN set_type = 'Set1' THEN cast(value as decimal(10,4)) *10 END) >95 
         then 
        EXP(0.03243 * POWER(LOG(AVG(CASE WHEN set_type = 'Set2' THEN cast(value as decimal(10,4)) *10 END)), 2) + 0.001644 * AVG(CASE WHEN set_type = 'Set3' THEN cast(value as decimal(10,4))  * 10 END) * LOG(AVG(CASE WHEN set_type = 'Set2' THEN cast(value as decimal(10,4)) * 10  END)) + 
           3.813)/7.0 end) + (  
           case when AVG(CASE WHEN set_type = 'Set4' THEN cast(value as decimal(10,4)) *10 END) <=95 
         then 
        (40.9041 + (3.21585 * (POWER(AVG(CASE WHEN set_type = 'Set4' THEN cast(value as decimal(10,4)) * 10 END), 0.5))) + 
        (0.348956 * AVG(CASE WHEN set_type = 'Set4' THEN cast(value as decimal(10,4)) * 10 END))) / 7 
			when  AVG(CASE WHEN set_type = 'Set4' THEN cast(value as decimal(10,4)) *10 END) >95 
         then 
        EXP(0.03243 * POWER(LOG(AVG(CASE WHEN set_type = 'Set5' THEN cast(value as decimal(10,4)) *10 END)), 2) + 0.001644 * AVG(CASE WHEN set_type = 'Set6' THEN cast(value as decimal(10,4))  * 10 END) * LOG(AVG(CASE WHEN set_type = 'Set5' THEN cast(value as decimal(10,4)) * 10  END)) + 
           3.813)/7.0 end) ) /2.0 
            end
             as uvf_ga_bd
			

	  -- loge(GA)= 0.03243 × (loge(HC))2+ 0.001644 × FL × loge(HC) + 3.813

FROM RankedData
WHERE rn IN (FLOOR((cnt + 1) / 2.0), CEILING((cnt + 1) / 2.0))
--AND uid IN ('220418', '365094', '937332', '040044', '418767', '774299')
GROUP BY [uid], uvfetus;
go 


