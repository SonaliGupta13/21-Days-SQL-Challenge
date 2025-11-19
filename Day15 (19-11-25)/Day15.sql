### Practice Questions:

-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
	SELECT *
    FROM patients AS P
    LEFT JOIN staff AS S
    ON P.service = S.service
	LEFT JOIN staff_schedule AS SS
    ON S.staff_id = SS.staff_id;

-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
	SELECT *
    FROM services_weekly AS SW
    LEFT JOIN staff AS S
    ON SW.service = S.service
    LEFT JOIN staff_schedule AS SS
    ON S.staff_id = SS.staff_id;

-- 3. Create a multi-table report showing patient admissions with staff information.
	SELECT *
FROM patients AS p
LEFT JOIN staff AS s
    ON p.service = s.service
LEFT JOIN staff_schedule AS ss
    ON s.staff_id = ss.staff_id
LEFT JOIN services_weekly AS sw
    ON s.service = sw.service;
    
### Daily Challenge:

/* Question: Create a comprehensive service analysis report for week 20 showing: service name, total patients
 admitted that week, total patients refused, average patient satisfaction, count of staff assigned to service,
 and count of staff present that week. Order by patients admitted descending. */
 SELECT 
	SW.service AS service_name,
	SUM(SW.patients_admitted) AS total_patient_admitted,
	SUM(SW.patients_refused) AS total_patient_refused,
	Avg(patient_satisfaction) AS avg_patient_satisfaction,
	COUNT(DISTINCT S.staff_id) AS staff_assigned_count,
	SUM(CASE WHEN SS.present =1 THEN 1 ELSE 0 END) AS staff_present_count
 FROM services_weekly AS SW
	LEFT JOIN staff AS S
	 ON SW.service = S.service
	LEFT JOIN staff_schedule AS SS
	 ON S.staff_id = SS.staff_id
	 AND SS.WEEK = 20
 WHERE SW.week = 20
 GROUP BY SW.service
 ORDER BY total_patient_admitted DESC;


 
 