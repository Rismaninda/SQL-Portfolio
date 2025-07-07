--1. Show first name, last name, and gender of patients whose gender is 'M'
select first_name,last_name,gender
from patients
where gender='M';

--2. Show first name and last name of patients who does not have allergies. (null)
select first_name,last_name from patients
where allergies is null;

--3. Show first name of patients that start with the letter 'C'
select first_name from patients
where first_name like 'C%';

--4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select first_name,last_name from patients
where weight between 100 and 120;

--5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
update patients 
set allergies='NKA'
where allergies is null;

--6. Show first name and last name concatinated into one column to show their full name.
select concat(first_name," ",last_name) as full_name
from patients;

--7. Show first name, last name, and the full province name of each patient.
--Example: 'Ontario' instead of 'ON'
select p.first_name,p.last_name,pn.province_name 
from patients p join province_names pn
on p.province_id=pn.province_id;

--8. Show how many patients have a birth_date with 2010 as the birth year.
select count(patient_id) from patients
where year(birth_date)=2010;

--9. Show the first_name, last_name, and height of the patient with the greatest height.
select first_name,last_name,max(height) 
from patients;

--10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
select * from patients
where patient_id in(1,45,534,879,1000);

--11. Show the total number of admissions
select count(*) from admissions;

--12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * from admissions
where admission_date=discharge_date;

--13. Show the patient id and the total number of admissions for patient_id 579.
select patient_id, count(*) as total_admissions
from admissions
where patient_id=579;

--14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'.
select distinct(city) from patients
where province_id='NS';

--15. Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
select first_name,last_name,birth_date
from patients
where height>160 and weight>70;

--16. Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
select first_name,last_name,allergies
from patients
where allergies is not null and
city='Hamilton';

--17. Show unique birth years from patients and order them by ascending.
select distinct(year(birth_date)) as years
from patients 
order by years asc;

--18. Show unique first names from the patients table which only occurs once in the list.
select first_name from patients
group by first_name
having count(first_name)=1;

--19. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id,first_name from patients
where first_name like 'S%____%S';

--20. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
select p.patient_id,p.first_name,p.last_name FROM patients p
JOIN admissions a ON 
p.patient_id=a.patient_id
where diagnosis='Dementia';

--21. Display every patient's first_name.Order the list by the length of each name and then by alphabetically.
select first_name from patients
order by len(first_name),first_name asc;

--22. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select
(select count(gender) from patients where gender='M') as Male,
(select count(gender) from patients where gender='F') as Female;

--23. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
select first_name,last_name,allergies
FROM patients
WHERE
allergies='Penicillin' OR 
allergies='Morphine'
order by 3,1,2 asc;

--24. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select patient_id,diagnosis from admissions
group by diagnosis
having count(patient_id)>1;

--25.Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select patient_id,diagnosis from admissions
group by 1,2
having count(patient_id)>1
order by patient_id;

--26. Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
select city, count(*) as total 
from patients
group by city
order by count(*) desc, city asc;

--27. Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
select first_name,last_name, 'Patient' as role from patients
union all 
select first_name,last_name,'Doctor' as role from doctors;

--28. Show all allergies ordered by popularity. Remove NULL values from query.
select allergies, count(*) as total_diagnosis
from patients
where allergies is not null
group by allergies 
order by count(*)desc;

--29. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name,last_name,birth_date 
from patients
where year(birth_date) between 1970 and 1979
order by birth_date;

--30. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
select concat(upper(last_name),",",lower(first_name)) as new_name_format
from patients
order by first_name desc;

--31. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select province_id, sum(height) as sum_height
from patients
group by province_id
having sum(height) >= 7000;

--32. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select max(weight)-min(weight) as weight_delta 
from patients
where last_name='Maroni';

--33. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select day(admission_date) as day_number, count(*) as number_of_addmissions
from admissions
group by 1
order by 2 desc;

--34. Show all columns for patient_id 542's most recent admission_date.
select * from admissions
where patient_id=542
order by admission_date desc
limit 1;

--35. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
--1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
--2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
select patient_id,attending_doctor_id,diagnosis from admissions
where (patient_id % 2 =1 and attending_doctor_id in (1,5,19)) 
OR
(attending_doctor_id like '%2%' AND LENGTH(patient_id)=3);

--36. Show first_name, last_name, and the total number of admissions attended for each doctor.Every admission has been attended by a doctor.
select first_name,last_name,count(*) AS ADMISSIONS_TOTAL
FROM doctors join admissions ON
doctors.doctor_id=admissions.attending_doctor_id
group by attending_doctor_id;

--37. For each doctor, display their id, full name, and the first and last admission date they attended.
select doctor_id,concat(first_name," ",last_name) as full_name, min(admission_date) as first_admission, max(admission_date) as last_admission
from doctors join admissions
on doctors.doctor_id=admissions.attending_doctor_id
group by doctor_id,full_name;

--38. Display the total amount of patients for each province. Order by descending.
select n.province_name,count(p.province_id) as total
from province_names n join patients p on
p.province_id=n.province_id
group by 1
order by 2 desc;

--39. display the first name, last name and number of duplicate patients based on their first name and last name.
select first_name, last_name, count(*) as num_of_duplicates
from patients
group by first_name,last_name
having count(first_name) >1 and count(last_name)>1
order by 3;

--40. Display patient's full name,height in the units feet rounded to 1 decimal,weight in the unit pounds rounded to 0 decimals,birth_date,gender non abbreviated.
select concat(first_name," ",last_name) as patient_name, round((height/30.48),1) as height ,
round((weight*2.205),0) as weight, birth_date,
CASE 
		    	WHEN gender = 'M' THEN 'Male'
		        WHEN gender = 'F' THEN 'Female'
		    END AS gender
from patients;

--41. Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)
select p.patient_id,p.first_name,p.last_name from patients p left join
admissions a on
p.patient_id=a.patient_id
where a.patient_id is null;

--42. Show all of the patients grouped into weight groups.
--Show the total amount of patients in each weight group.
--Order the list by the weight group decending.
--For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
select count(*),
case 
wHEN weight <10 THEN 0
when weight between 10 and 19 then 10
when weight between 20 and 29 then 20
when weight between 30 and 39 then 30
when weight between 40 and 49 then 40
when weight between 50 and 59 then 50
when weight between 60 and 69 then 60
when weight between 70 and 79 then 70
when weight between 80 and 89 then 80
when weight between 90 and 99 then 90
when weight between 100 and 109 then 100
when weight between 110 and 119 then 110
when weight between 120 and 129 then 120
when weight between 130 and 139 then 130
when weight between 140 and 149 then 140
end
as weight_group
from patients
group by 2
order by 2 desc;

--43. Show patient_id, weight, height, isObese from the patients table.Display isObese as a boolean 0 or 1.Obese is defined as weight(kg)/(height(m)2) >= 30.weight is in units kg.height is in units cm.
SELECT 
			patient_id,
		    weight,
		    height,
		    CASE
		    	WHEN weight/SQUARE(CAST(height AS float)/100) >= 30 THEN 1
		        ELSE 0
		    END AS isObese
		FROM patients;
		
--44. Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
select p.patient_id, p.first_name,p.last_name,d.specialty from patients p
join admissions a on
p.patient_id=a.patient_id
join doctors d on
a.attending_doctor_id=d.doctor_id
where a.diagnosis ='Epilepsy' 
and d.first_name='Lisa';

--45. All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
--The password must be the following, in order:
--1. patient_id
--2. the numerical length of patient's last_name
--3. year of patient's birth_date
select p.patient_id, concat(p.patient_id,length(p.last_name),year(p.birth_date)) as tempt_password
from patients p
join admissions a on
p.patient_id=a.patient_id
group by p.patient_id;

--46. Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
--Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.
select case
when patient_id%2= 0 then 'Yes'
else 'No'
end as has_insurance,
case
when patient_id %2=0 then count(*) * 10
else count(*) * 50
end as cost_after_insurance
from admissions
group by 1;

--47. Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
select p1.province_name 
from province_names p1
join patients p2 on p1.province_id=p2.province_id
group by p1.province_name
having sum(case when p2.gender='M' then 1 else 0 end) >
sum(case when p2.gender='F' then 1 else 0 end);

-- 48. We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
-- First_name contains an 'r' after the first two letters.
-- Identifies their gender as 'F'
-- Born in February, May, or December
-- Their weight would be between 60kg and 80kg
-- Their patient_id is an odd number
-- They are from the city 'Kingston'
select * from patients
where first_name like '%__r%' and
gender ='F' and 
month(birth_date) in (2,5,12) and
weight between 60 and 80 and
patient_id%2=1 and
city = 'Kingston';

--49. Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
select concat(round(
  (
              cast((select count(*) from patients where gender='M') as float)/
  cast(count(*) as float))*100,2),"%") as percent_of_male_patients
  from patients;
  
--50. For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
 select admission_date, count(*) as admission_day, count(*) - lag(count(*)) over (order by admission_date)
                                                                 from admissions
                                                                 group by admission_date;
        
--51. Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
                              SELECT province_name
FROM province_names
ORDER BY 
    CASE WHEN province_name = 'Ontario' THEN 0 ELSE 1 END,
    province_name ASC;

select province_name
from province_names
order by
  (not province_name = 'Ontario'),
  province_name
  
select province_name
from province_names
order by
  province_name = 'Ontario' desc,
  province_name
  
SELECT province_name
FROM province_names
ORDER BY
  CASE
    WHEN province_name = 'Ontario' THEN 1
    ELSE province_name
  END

--52. We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.
  select d.doctor_id, concat(d.first_name," ",d.last_name) as doctor_name,
d.specialty, (year(a.admission_date)) as year, count(*) as total_admission
from doctors d join admissions a on
d.doctor_id=a.attending_doctor_id
group by 1,4
order by 1 asc;