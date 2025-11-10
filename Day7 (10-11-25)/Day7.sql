### Practice Questions:

-- 1. Find services that have admitted more than 500 patients in total.
	select service,sum(patients_admitted) as total
    from services_weekly
    group by service
    having sum(patients_admitted)>500;
    
-- 2. Show services where average patient satisfaction is below 75.
	select service, avg(satisfaction) as avg_satisfaction
    from patients
    group by service
    having avg(satisfaction)< 75;
   
-- 3. List weeks where total staff presence across all services was less than 50.
	SELECT week,
    SUM(present) AS total_staff_presence
FROM staff_schedule
GROUP BY week
HAVING SUM(present) < 50;


### Daily Challenge:

/* Question: Identify services that refused more than 100 patients in total and had an average patient
 satisfaction below 80. Show service name, total refused, and average satisfaction.*/
 SELECT 
    service,
    SUM(patients_refused) AS total_refused,
    AVG(patient_satisfaction) AS avg_satisfaction
FROM 
    services_weekly
GROUP BY 
    service
HAVING 
    SUM(patients_refused) > 100
    AND AVG(patient_satisfaction) < 80;

 