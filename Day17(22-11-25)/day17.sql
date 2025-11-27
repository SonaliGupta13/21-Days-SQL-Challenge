### Practice Questions:

-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT p.patient_id,p.name,p.service,sw.avg_satisfaction
FROM patients AS p
LEFT JOIN (
        SELECT service,
            AVG(patient_satisfaction) AS avg_satisfaction
        FROM services_weekly
        GROUP BY service
    ) AS sw
ON p.service = sw.service;

-- 2. Create a derived table of service statistics and query from it.
SELECT sw.service, sw.total_admitted, sw.total_refused, sw.avg_satisfaction
FROM (
        SELECT service,
            SUM(patients_admitted) AS total_admitted,
            SUM(patients_refused) AS total_refused,
            AVG(patient_satisfaction) AS avg_satisfaction
        FROM services_weekly
        GROUP BY service
     ) AS sw;

-- 3. Display staff with their service's total patient count as a calculated field.
SELECT s.staff_id,s.staff_name,s.role,s.service,
    COALESCE(sw.total_patients, 0) AS total_patients
FROM staff AS s
LEFT JOIN (
        SELECT 
            service,
            SUM(patients_admitted) AS total_patients
        FROM services_weekly
        GROUP BY service
     ) AS sw
ON s.service = sw.service;

### Daily Challenge:

/* Question: Create a report showing each service with: service name, total patients admitted, the difference
 between their total admissions and the average admissions across all services, and a rank indicator 
 ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending. */

	SELECT s.service, s.total_admitted,
    -- Difference from overall average
    s.total_admitted - avg_table.avg_admitted AS difference_from_average,
    -- Rank indicator
    CASE
        WHEN s.total_admitted > avg_table.avg_admitted THEN 'Above Average'
        WHEN s.total_admitted = avg_table.avg_admitted THEN 'Average'
        ELSE 'Below Average'
    END AS rank_indicator
FROM (  -- Derived table (inline view)
        SELECT service, SUM(patients_admitted) AS total_admitted
        FROM services_weekly
        GROUP BY service
     ) AS s
-- Join with a subquery that calculates the average
JOIN ( SELECT AVG(total_admitted) AS avg_admitted
        FROM ( SELECT service, SUM(patients_admitted) AS total_admitted
                FROM services_weekly
                GROUP BY service) AS x
     ) AS avg_table ON 1 = 1   -- cross join
ORDER BY s.total_admitted DESC;

