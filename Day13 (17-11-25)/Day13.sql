### Practice Questions:

-- 1. Join patients and staff based on their common service field (show patient and staff who work in same service).
SELECT 
    p.name AS patient_name, 
    s.staff_name AS staff_name,
    p.service AS service
FROM patients AS p
JOIN staff AS s
    ON p.service = s.service;

-- 2. Join services_weekly with staff to show weekly service data with staff information.
SELECT * FROM staff AS s
	JOIN services_weekly AS sw
    ON s.service = sw.service;
    
-- 3. Create a report showing patient information along with staff assigned to their service.
SELECT p.patient_id, p.name, p.age, p.arrival_date, p.departure_date,
	p.satisfaction, p.service, s.staff_name 
    FROM patients AS p
	LEFT JOIN staff AS s
	ON p.service = s.service;
 

### Daily Challenge:

/* Question: Create a comprehensive report showing patient_id, patient name, age, service, and the total number of
staff members available in their service. Only include patients from services that have more than 5 staff members.
 Order by number of staff descending, then by patient name. */
SELECT 
   p.patient_id, p.name AS patient_name, p.age, p.service, sc.total_staff_members
   FROM patients AS p
	JOIN 
    ( SELECT service, count(staff_id) AS total_staff_members
		FROM staff
        GROUP BY service
    HAVING count(staff_id)>5) AS sc
	ON p.service = sc.service
    ORDER BY sc.total_staff_members DESC,p.name