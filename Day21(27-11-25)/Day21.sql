### Practice Questions:

-- 1. Create a CTE to calculate service statistics, then query from it.
WITH service_stats AS (
    SELECT service, AVG(satisfaction) AS avg_sat
    FROM patients
    GROUP BY service
)
SELECT p.patient_id, p.name, p.service, p.satisfaction, ss.avg_sat
FROM patients AS p
JOIN service_stats AS ss
    ON p.service = ss.service;

-- 2. Use multiple CTEs to break down a complex query into logical steps.
WITH admitted_cte AS (
			SELECT service, SUM(patients_admitted) AS total_admitted
    FROM services_weekly
    GROUP BY service ),
satisfaction_cte AS (
			SELECT service, AVG(patient_satisfaction) AS avg_satisfaction
    FROM services_weekly
    GROUP BY service),
refusal_cte AS (
			SELECT service, SUM(patients_refused) AS total_refused
    FROM services_weekly
    GROUP BY service)
SELECT a.service, a.total_admitted, s.avg_satisfaction, r.total_refused
FROM admitted_cte a
JOIN satisfaction_cte s ON a.service = s.service
JOIN refusal_cte r ON a.service = r.service
ORDER BY a.total_admitted DESC;

-- 3. Build a CTE for staff utilization and join it with patient data.
WITH staff_util AS (
    SELECT staff_id, service, SUM(present) AS weeks_present
    FROM staff_schedule
    GROUP BY staff_id, service)
SELECT p.patient_id, p.name AS patient_name,
	p.service, st.staff_id, st.staff_name, st.role,
    su.weeks_present
FROM patients p
LEFT JOIN staff_util su 
    ON p.service = su.service
LEFT JOIN staff st
    ON st.staff_id = su.staff_id
ORDER BY p.service, su.weeks_present DESC;

### Daily Challenge:

/* Question: Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level metrics
(total admissions, refusals, avg satisfaction), 2) Staff metrics per service (total staff, avg weeks present), 3)
 Patient demographics per service (avg age, count). Then combine all three CTEs to create a final report showing 
 service name, all calculated metrics, and an overall performance score (weighted average of admission rate and
 satisfaction). Order by performance score descending. */
 
WITH service_level_metrics AS (
    SELECT service, SUM(patients_admitted) AS total_admissions,
        SUM(patients_refused) AS total_refusals, AVG(patient_satisfaction) AS avg_satisfaction
    FROM services_weekly
    GROUP BY service   ),
staff_metrics AS (
    SELECT service, COUNT(DISTINCT staff_id) AS total_staff, AVG(present) AS avg_weeks_present
    FROM staff_schedule
    GROUP BY service  ),
patient_demographics AS (
    SELECT service, AVG(age) AS avg_age, COUNT(patient_id) AS total_patients
    FROM patients
    GROUP BY service  )
SELECT s.service, s.total_admissions, s.total_refusals, s.avg_satisfaction,
	   st.total_staff, st.avg_weeks_present, p.avg_age, p.total_patients,
    (s.avg_satisfaction * 2) + s.total_admissions AS performance_score
FROM service_level_metrics s
LEFT JOIN staff_metrics st ON s.service = st.service
LEFT JOIN patient_demographics p ON s.service = p.service
ORDER BY performance_score DESC;

 
 