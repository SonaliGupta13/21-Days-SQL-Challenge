### Practice Questions:

-- 1. Count the total number of patients in the hospital.
	select count(patient_id) AS total_patients from patients;

-- 2. Calculate the average satisfaction score of all patients.
	select avg(satisfaction) AS avg_score from patients;

-- 3. Find the minimum and maximum age of patients.
	select max(age) AS oldest, 
		   min(age) AS youngest
	from patients;
    
### Daily Challenge:

/* Question: Calculate the total number of patients admitted, total patients refused, and the average patient 
satisfaction across all services and weeks. Round the average satisfaction to 2 decimal places. */
	SELECT 
    SUM(patients_admitted) AS total_number_of_patients_admitted,
    SUM(patients_refused) AS total_patients_refused,
    ROUND(AVG(patient_satisfaction), 2) AS average_patient_satisfaction
	FROM services_weekly;
