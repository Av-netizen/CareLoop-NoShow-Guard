
-- ==========================================
-- CARELOOP CLINICS - NO-SHOW GUARD
-- TASK 2.1 - PRIMARY KEY VALIDATION
-- ==========================================

-- Duplicate Primary Key Test
-- Attempted to insert an existing appointment
-- with appointment_id = 'A0001'.

-- MySQL Error Code: 1062
-- Duplicate entry 'A0001'
-- for key 'appointments.PRIMARY'

-- Result:
-- MySQL successfully rejected the duplicate.
-- Primary key constraint validated.


-- ==========================================
-- CARELOOP CLINICS - NO-SHOW GUARD
-- PART 2 - TASK 2.2
-- CLINIC-WISE NO-SHOW ANALYSIS
-- ==========================================

USE noshowguard;

SELECT
    c.clinic_name,
    c.city,
    COUNT(*) AS appointments,
    SUM(a.no_show) AS no_shows,
    ROUND(
        100.0 * SUM(a.no_show) / COUNT(*),
        1
    ) AS no_show_pct

FROM appointments a

JOIN clinics c
    ON a.clinic_id = c.clinic_id

GROUP BY
    c.clinic_id,
    c.clinic_name,
    c.city

HAVING COUNT(*) >= 95

ORDER BY no_show_pct DESC;


-- ==========================================
-- CARELOOP CLINICS - NO-SHOW GUARD
-- TASK 2.3 - BOOKING LEAD TIME ANALYSIS
-- ==========================================

USE noshowguard;

SELECT
    CASE
        WHEN lead_days BETWEEN 1 AND 7 THEN '1-7'
        WHEN lead_days BETWEEN 8 AND 14 THEN '8-14'
        WHEN lead_days BETWEEN 15 AND 30 THEN '15-30'
        ELSE '31+'
    END AS lead_time_band,

    COUNT(*) AS appointments,

    SUM(no_show) AS no_shows,

    ROUND(
        100.0 * SUM(no_show) / COUNT(*),
        1
    ) AS no_show_pct

FROM appointments

GROUP BY lead_time_band

ORDER BY MIN(lead_days);



-- ==========================================
-- CARELOOP CLINICS - NO-SHOW GUARD
-- TASK 2.4 - MONTHLY NO-SHOW TREND
-- ==========================================

USE noshowguard;

WITH monthly AS (
    SELECT
        SUBSTR(appt_date, 1, 7) AS month,
        COUNT(*) AS appointments,
        ROUND(
            100.0 * SUM(no_show) / COUNT(*),
            1
        ) AS no_show_pct
    FROM appointments
    GROUP BY SUBSTR(appt_date, 1, 7)
)

SELECT
    month,
    appointments,
    no_show_pct,
    ROUND(
        no_show_pct -
        LAG(no_show_pct) OVER (ORDER BY month),
        1
    ) AS change_pp

FROM monthly

ORDER BY month;




-- ==========================================
-- CARELOOP CLINICS - NO-SHOW GUARD
-- TASK 2.5 - CITY-WISE CLINIC RANKING
-- ==========================================

USE noshowguard;

WITH clinic_rates AS (
    SELECT
        c.clinic_id,
        c.clinic_name,
        c.city,
        ROUND(
            100.0 * SUM(a.no_show) / COUNT(*),
            1
        ) AS no_show_pct

    FROM appointments a

    JOIN clinics c
        ON a.clinic_id = c.clinic_id

    GROUP BY
        c.clinic_id,
        c.clinic_name,
        c.city
)

SELECT
    clinic_name,
    city,
    no_show_pct,

    RANK() OVER (
        PARTITION BY city
        ORDER BY no_show_pct DESC
    ) AS rank_in_city,

    CASE
        WHEN no_show_pct > (
            SELECT 100.0 * SUM(no_show) / COUNT(*)
            FROM appointments
        ) THEN 'above'

        WHEN no_show_pct < (
            SELECT 100.0 * SUM(no_show) / COUNT(*)
            FROM appointments
        ) THEN 'below'

        ELSE 'equal'
    END AS vs_overall

FROM clinic_rates

ORDER BY city, rank_in_city;



-- ==========================================
-- TASK 2.1 - DATA INTEGRITY VERIFICATION
-- ==========================================

-- Duplicate appointment ID tested: A0001
-- Expected MySQL Error Code: 1062
-- Result: Duplicate entry rejected successfully.
-- Conclusion: The PRIMARY KEY constraint
-- protects appointment records from duplicates.
