-- Show All Data
select * from students_grading_dataset sgd ;

--Count
--1. Gender
select "Gender",count("Gender") as total_gender 
from students_grading_dataset sgd 
group by "Gender" 
order by 2 desc;

--2. Age
select "Age",count("Gender") as total_age
from students_grading_dataset sgd 
group by "Age" 
order by 2 desc;

--3. Family economic
select "Family_Income_Level" ,count("Family_Income_Level") as total_family_level
from students_grading_dataset sgd 
group by "Family_Income_Level" 
order by 2 desc;

--4. Department
select "Department" ,count("Department") as total_department
from students_grading_dataset sgd 
group by "Department" 
order by 2 desc;

--5. Grade
select "Grade" ,count("Grade") as total_grade
from students_grading_dataset sgd 
group by "Grade" 
order by 2 desc;

--6. Extracurricular
select "Extracurricular_Activities" ,count("Extracurricular_Activities") as total_act
from students_grading_dataset sgd 
group by "Extracurricular_Activities" 
order by 2 desc;

--7. Internet Access
select "Internet_Access_at_Home" ,count("Internet_Access_at_Home") as total_act
from students_grading_dataset sgd 
group by "Internet_Access_at_Home" 
order by 2 desc;


--rank
--Department
with rankin as(
select concat("First_Name" ,' ',"Last_Name") as Full_name,
"Department" ,"Total_Score" ,rank() over(partition by "Department" order by "Total_Score" desc) as Rank_Student
from students_grading_dataset sgd) 
select * from rankin
where Rank_Student =1;

-- Average
with sleep_hour as
(select "Stress_Level (1-10)", ROUND(AVG("Sleep_Hours_per_Night")::numeric, 2) AS avg_sleep_time
from students_grading_dataset sgd 
group by "Stress_Level (1-10)" 
order by 2 desc)
select * from sleep_hour;

--Rank 1
with rnk as 
(select concat("First_Name",' ',"Last_Name") as Full_Name,
"Department","Stress_Level (1-10)","Sleep_Hours_per_Night",rank() over(partition by "Department" order by "Total_Score" desc) as rank_student
from students_grading_dataset sgd)
select * from rnk
where rank_student =1;

--
with rk as
(select concat("First_Name",' ',"Last_Name") as Full_name,
"Department" ,"Stress_Level (1-10)" ,"Sleep_Hours_per_Night"
,"Total_Score" ,rank() over(partition by "Department" order by "Total_Score" desc) as rnk
from students_grading_dataset sgd)
select * from rk
where rnk in(1,2,3) ;

--no internet
with int as
(select concat("First_Name",' ',"Last_Name") as full_name,
"Department","Internet_Access_at_Home" , "Total_Score" , rank() over(partition by "Department" order by "Total_Score" desc) as rank
from students_grading_dataset sgd)
SELECT *,
    RANK() OVER (PARTITION BY "Department" ORDER BY "Total_Score" DESC) AS rk
  FROM int
  where "Internet_Access_at_Home" = 'No'
 ;


WITH filtered_data AS (
  SELECT 
    CONCAT("First_Name", ' ', "Last_Name") AS full_name,
    "Department",
    "Internet_Access_at_Home",
    "Total_Score"
  FROM students_grading_dataset
  WHERE "Internet_Access_at_Home" = 'No'
),
ranked_data AS (
  SELECT *,
    RANK() OVER (PARTITION BY "Department" ORDER BY "Total_Score" DESC) AS rk
  FROM filtered_data
)
SELECT *
FROM ranked_data
WHERE rk <= 5
ORDER BY "Department", rk;


