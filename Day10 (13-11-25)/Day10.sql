### Practice Questions:

-- 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
select name, 
case when satisfaction >= 85 then 'High'
	 when satisfaction<=75 then 'Low'
     else 'Medium' end as patients_category
from patients;

-- 2. Label staff roles as 'Medical' or 'Support' based on role type.
select distinct role, 
case when role='doctor' then 'Medical'
when role in ('nursing_assistant','nurse') then 'Support' else 'Nothing'
end as staff_roles
from staff;

-- 3. Create age groups for patients (0-18, 19-40, 41-65, 65+).
select age,case when age <=18 then '0-18'
	    when age >=19 and age<=40 then '19-40'
        when age>=41 and age<=65 then '41-65'
        else '65+' end as age_group
	from patients;
    
### Daily Challenge:

/* Question: Create a service performance report showing service name, total patients admitted, and a 
performance category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair'
 if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending. */
 
 SELECT 
    service,
    COUNT(patients_admitted) AS total_patients_admitted,
    AVG(patient_satisfaction) AS avg_satisfaction,
    CASE
        WHEN AVG(patient_satisfaction) >= 85 THEN 'Excellent'
        WHEN AVG(patient_satisfaction) >= 75 THEN 'Good'
        WHEN AVG(patient_satisfaction) >= 65 THEN 'Fair'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM services_weekly
GROUP BY service
ORDER BY avg_satisfaction DESC;
