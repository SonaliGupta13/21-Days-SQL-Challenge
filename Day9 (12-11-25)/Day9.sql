### Practice Questions:

-- 1. Extract the year from all patient arrival dates.
	select arrival_date, year(arrival_date) as arrival_year
    from patients;
    
-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
	SELECT
  name,
  datediff( STR_TO_DATE(departure_date, '%Y-%m-%d'),
           STR_TO_DATE(arrival_date, '%Y-%m-%d')) AS length_of_stay
FROM patients
WHERE departure_date IS NOT NULL;

-- 3. Find all patients who arrived in a specific month.
select monthname(arrival_date) as month, count(*) as total_patients 
from patients
group by monthname(arrival_date);

### Daily Challenge:

/* Question: Calculate the average length of stay (in days) for each service, showing only services where the 
average stay is more than 7 days. Also show the count of patients and order by average stay descending. */
SELECT
    service,
    AVG(
        DATEDIFF(
            STR_TO_DATE(departure_date, '%Y-%m-%d'),
            STR_TO_DATE(arrival_date, '%Y-%m-%d')
        )
    ) AS avg_stay,
    COUNT(patient_id) AS patient_count
FROM patients
GROUP BY service
HAVING avg_stay > 7
ORDER BY avg_stay DESC;


