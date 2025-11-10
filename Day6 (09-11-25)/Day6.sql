### Practice Questions:

-- 1. Count the number of patients by each service.
	select service, count(*) as no_of_patients
    from patients
    group by service;

-- 2. Calculate the average age of patients grouped by service
	select service, round(avg(age),2) as avg_age
    from patients
    group by service;
    
-- 3. Find the total number of staff members per role.
	select role, count(*) as total_staff
    from staff
    group by role;
    
    ### Daily Challenge:

/* Question: For each hospital service, calculate the total number of patients admitted, total patients refused,
 and the admission rate (percentage of requests that were admitted). Order by admission rate descending. */
	SELECT 
		service, 
		SUM(patients_admitted) AS patients_admitted,
		SUM(patients_refused) AS patients_refused,
		ROUND(SUM(patients_admitted) / SUM(patients_request) * 100, 2) AS admission_rate
	FROM 
		services_weekly
	GROUP BY 
		service
	ORDER BY 
		admission_rate DESC;
