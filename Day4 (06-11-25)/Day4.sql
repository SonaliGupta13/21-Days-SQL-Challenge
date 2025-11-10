### Practice Questions:

-- 1. Display the first 5 patients from the patients table.
	select name
    from patients
    limit 5;
    
-- 2. Show patients 11-20 using OFFSET.
	select name
    from patients
    order by name
    limit 10 offset 11;

-- 3. Get the 10 most recent patient admissions based on arrival_date.
	select *
    from patients
    order by arrival_date desc
    limit 10;
    
### Daily Challenge:

/* Question: Find the 3rd to 7th highest patient satisfaction scores from the patients table, 
showing patient_id, name, service, and satisfaction. Display only these 5 records. */
SELECT patient_id, name, service, satisfaction
FROM patients
ORDER BY satisfaction DESC   -- highest scores first
LIMIT 5 OFFSET 2;            -- skip top 2 → show 3rd to 7th


