--First Table
CREATE TABLE abc (
dept_id int,
dept_name varchar(20)
)
insert into abc values (1,'mech'),(2,'civil'),(3,'eee'),(4,'ece'),(5,'cse')
SELECT * from abc
--Second Table
Create table student_bvc (
St_name varchar(20),
st_rn int,
st_dept_id int
)
alter table student_bvc 
add constraint uq_key unique(st_rn)
insert into student_bvc values ('kiran',1,5),('Naidu',2,5),('Sai',3,4),('Sidhu',4,4),('Ganesh',5,3),('Bunga',6,3),('Ramesh',7,1),('Charan',8,2),('Ravi',9,5)
select * from student_bvc

--Creating view
alter view vi_std as
SELECT st_rn,st_name,dept_name
from abc a
join student_bvc s
on a.dept_id  = s.st_dept_id 

select * from vi_std
order by st_rn

insert into vi_std values('12','Prabhu','cse')


CREATE TRIGGER TR_vi_std
ON vi_std
INSTEAD OF INSERT
AS
BEGIN
    -- Declare variables to hold the values from the inserted row
    DECLARE @st_rn INT, @st_name NVARCHAR(50), @dept_name NVARCHAR(50), @dept_id INT;

    -- Select the values from the inserted row
    SELECT 
        @st_rn = st_rn,
        @st_name = st_name,
        @dept_name = dept_name
    FROM 
        inserted;

    -- Get the department ID based on the department name
    SELECT 
        @dept_id = dept_id
    FROM 
        abc
    WHERE 
        dept_name = @dept_name;

    -- Insert the values into the student_bvc table
    INSERT INTO student_bvc (st_rn, st_name, st_dept_id)
    VALUES (@st_rn, @st_name, @dept_id);
END;
GO



	

