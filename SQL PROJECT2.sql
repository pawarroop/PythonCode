/*
A.	To get data from all the rows and columns in the employees table:
B.	select data from the employee id, first name, last name, and hire date of all rows in the employees table:
C.	to get the first name, last name, salary, and new salary:
D.	Increase the salary two times and named as New_SALARY from employees table */

SELECT * FROM EMPLOYEES
SELECT employee_id, first_name, last_name, hire_DATE FROM EMPLOYEES
SELECT FIRST_NAME,LAST_NAME,(SALARY*SALARY) AS NEW_SALARY FROM EMPLOYEES
--------------------------------------------------------------------------------------
/*
A.	returns the data from the employee id, first name, last name, hire date, and salary column of the employees table:
B.	to sort employees by first names in alphabetical order:
C.	to sort the employees by the first name in ascending order and the last name in descending order:
D.	to sort employees by salary from high to low:
E.	to sort the employees by values in the hire_date column from:
F.	sort the employees by the hire dates in descending order: */


select employee_id, first_name, last_name, hire_date, salary
FROM
    EMPLOYEES
ORDER BY 
    --FIRST_NAME ASC,
	--LAST_NAME DESC
	--SALARY DESC
	HIRE_DATE DESC
-------------------------------------------------------------------------------
/*
A.	selects the salary data from the salary column of the employees table and sorts them from high to low:
B.	select unique values from the salary column of the employees table:
C.	selects the job id and salary from the employees table:
D.	to remove the duplicate values in job id and salary:
E.	returns the distinct phone numbers of employees:*/
SELECT * FROM EMPLOYEES
SELECT DISTINCT SALARY FROM EMPLOYEES ORDER BY SALARY DESC
SELECT DISTINCT JOB_ID,SALARY FROM EMPLOYEES 
SELECT DISTINCT JOB_ID,SALARY FROM EMPLOYEES GROUP BY JOB_ID, SALARY HAVING COUNT(JOB_ID)>1
SELECT DISTINCT PHONE_NUMBER FROM EMPLOYEES
-------------------------------------------------------------------
/*
A.	returns all rows in the employees table sorted by the first_name column.
B.	to return the first 5 rows in the result set returned by the SELECT clause:
C.	to return five rows starting from the 4th row:
D.	gets the top five employees with the highest salaries.
E.	to get employees who have the 2nd highest salary in the company */

SELECT * FROM EMPLOYEES ORDER BY FIRST_NAME

SELECT TOP 5 * FROM EMPLOYEES ORDER BY FIRST_NAME 

SELECT  * FROM EMPLOYEES ORDER BY FIRST_NAME OFFSET 3 ROWS
FETCH NEXT 5 ROWS ONLY

SELECT TOP 5 FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC

SELECT TOP 1 * FROM EMPLOYEES WHERE SALARY IN 
(SELECT TOP 2 SALARY FROM EMPLOYEES ORDER BY SALARY DESC)
ORDER BY SALARY ASC
--------------------------------------------------
SELECT * FROM EMPLOYEES WHERE YEAR(HIRE_DATE) = 1999
-----------------------------------
CREATE TABLE COURSES (
COURSE_ID INT,
COURSE_NAME VARCHAR(50))
SELECT * FROM COURSES
ALTER TABLE COURSES ADD COLUMN CREDIT_HOURS INT
ALTER TABLE COURSES DROP COLUMN COURSE_NAME
ALTER TABLE COURSES ADD COLUMN FEE
-------------------------------------------
CREATE  TABLE  projects (
    project_id  INT  PRIMARY KEY,
    project_name  VARCHAR(255),
    start_date  DATE  NOT NULL,
    end_date  DATE  NOT NULL
);

CREATE  TABLE  project_milestones(
    milestone_id  INT  PRIMARY KEY,
    project_id   INT,
    milestone_name VARCHAR(100)
);

SELECT * FROM project_milestones
SELECT * FROM projects


ALTER TABLE PROJECT_MILESTONES ADD CONSTRAINT FK_PROJECTMILESTONE_PROJECT
FOREIGN KEY (PROJECT_ID) REFERENCES PROJECTS (PROJECT_ID)
------------------------------------------------------------------
/*
A.	finds all employees whose salaries are greater than the average salary of every department:
B.	finds all employees who have dependents: */

SELECT * FROM EMPLOYEES
SELECT * FROM dependents

SELECT * FROM employees WHERE SALARY > (SELECT AVG(SALARY) FROM employees GROUP BY department_id)
SELECT DISTINCT E.*,D.* FROM EMPLOYEES E,DEPENDENTS D WHERE E.employee_id = D.employee_id


SELECT  E.* FROM EMPLOYEES E LEFT JOIN DEPENDENTS D ON E.employee_id = D.employee_id WHERE D.EMPLOYEE_ID IS NULL

SELECT D.* FROM EMPLOYEES E JOIN departments D ON E.department_id = D.department_id WHERE D.department_id IN (1,2,3)

SELECT E.first_name,E.last_name,D.department_name,J.JOB_TITLE 
FROM EMPLOYEES E, 
departments D ,
JOBS J WHERE E.department_id = D.department_id AND E.JOB_ID = J.job_id
AND D.department_id IN (1,2,3)

SELECT * FROM countries
SELECT * FROM locations

SELECT L.COUNTRY_ID,C.COUNTRY_NAME 
FROM countries C JOIN locations L 
ON L.country_id = C.country_id 
WHERE C.country_id IN ('US','UK','CN')

SELECT * FROM countries C LEFT JOIN locations L 
ON L.country_id = C.country_id 
WHERE L.country_id IS NULL

SELECT A.employee_id,A.first_name AS EMP_NAME,B.first_name AS MANAGER_NAME FROM 
EMPLOYEES A
INNER JOIN 
EMPLOYEES B 
ON B.employee_id = A.manager_id
WHERE B.manager_id IS NULL
---------------------------------------------------------------
CREATE  TABLE  fruits (
	fruit_id  INT PRIMARY KEY,
	fruit_name  VARCHAR (255) NOT NULL,
	basket_id  INTEGER
);
CREATE TABLE baskets (
	basket_id  INT PRIMARY KEY,
	basket_name  VARCHAR (255) NOT NULL
);
---------------
INSERT  INTO  baskets  (basket_id, basket_name)
VALUES
	(1, 'A'),
	(2, 'B'),
	(3, 'C');

INSERT  INTO  fruits (
	fruit_id,
	fruit_name,
	basket_id
)
VALUES
	(1, 'Apple', 1),
	(2, 'Orange', 1),
	(3, 'Banana', 2),
	(4, 'Strawberry', NULL);
----------------------
SELECT * FROM baskets
SELECT * FROM fruits

--SELECT * FROM baskets B FULL OUTER JOIN fruits F ON B.basket_id= F.basket_id
--SELECT * FROM baskets B LEFT JOIN fruits F ON B.basket_id= F.basket_id
SELECT * FROM baskets B RIGHT JOIN fruits F ON B.basket_id= F.basket_id
-------------------------------------
CREATE  TABLE  sales_organization (
	sales_org_id  INT PRIMARY KEY,
	sales_org  VARCHAR (255)
);

 CREATE  TABLE  sales_channel (
	channel_id  INT PRIMARY KEY,
	channel  VARCHAR (255)
);
INSERT INTO sales_organization (sales_org_id, sales_org)
VALUES
	(1, 'Domestic'),
	(2, 'Export');
INSERT INTO sales_channel (channel_id, channel)
VALUES
	(1, 'Wholesale'),
	(2, 'Retail'),
	(3, 'eCommerce'),
	(4, 'TV Shopping');

SELECT * FROM sales_channel CROSS JOIN sales_organization

SELECT * FROM EMPLOYEES

SELECT DEPARTMENT_ID,COUNT(*) AS NUMBER_OF_EMPLOYEE FROM employees
GROUP BY department_id ORDER BY NUMBER_OF_EMPLOYEE

SELECT DEPARTMENT_ID,COUNT(*) AS NUMBER_OF_EMPLOYEE FROM employees
GROUP BY department_id HAVING COUNT(employee_id) > 5 ORDER BY NUMBER_OF_EMPLOYEE

SELECT DEPARTMENT_ID,
MIN(SALARY) AS MIN_SAL,
MAX(SALARY) AS MAX_SAL,
AVG(SALARY) AS AVG_SAL
FROM employees GROUP BY department_id

SELECT DEPARTMENT_ID,
SUM(SALARY) AS TOTAL_SAL
FROM employees GROUP BY department_id
---------------------------------------------
/*
A.	To get the managers and their direct reports, and  to group employees by the managers and to count the direct reports.
B.	To find the managers who have at least five direct reports
C.	calculates the sum of salary that the company pays for each department and selects only the departments with the sum of salary between 20000 and 30000.
D.	To find the department that has employees with the lowest salary greater than 10000
E.	To find the departments that have the average salaries of employees between 5000 and 7000 */

SELECT * FROM employeeS
SELECT * FROM dependents

SELECT department_ID, AVG(SALARY) AS DEPART_WISE_AVG_SALARY FROM employees
GROUP BY DEPARTMENT_ID HAVING AVG(SALARY) BETWEEN 5000 AND 7000

SELECT FIRST_NAME, LAST_NAME FROM employees 
UNION
SELECT FIRST_NAME, LAST_NAME FROM dependents

SELECT * FROM employees E WHERE EXISTS (SELECT 1 FROM dependents D WHERE E.employee_id = D.employee_id)
SELECT * FROM employees E WHERE NOT EXISTS (SELECT 1 FROM dependents D WHERE E.employee_id = D.employee_id)

SELECT * FROM EMPLOYEES
SELECT 
employee_id,
first_name,
last_name,
hire_date,
CASE 
WHEN YEAR(HIRE_DATE) =2000 THEN
'NEW EMPLOYEE'
ELSE 'WORK ANNIVERSARY: ' + CAST(YEAR(GETDATE())-YEAR(HIRE_DATE) AS VARCHAR) + 'YEARS'
END AS WORK_ANNIVERSARY FROM EMPLOYEES

SELECT 
employee_id,
first_name,
last_name,
hire_date,
CASE 
WHEN YEAR(HIRE_DATE) =2000 THEN
'NEW EMPLOYEE'
ELSE 'WORK ANNIVERSARY'
END AS WORK_ANNIVERSARY FROM employees

SELECT FIRST_NAME, SALARY,
CASE
WHEN SALARY < 3000 THEN 'LOW'
WHEN SALARY BETWEEN 3000 AND 5000 THEN 'AVERAGE'
WHEN SALARY > 5000 THEN 'HIGH'
END FROM employees

SELECT * FROM employees
SELECT * FROM dependents

UPDATE EMPLOYEES SET LAST_NAME = 'LOPEZ' WHERE employee_id = 192

--How to  make sure that the last names of children are always matched with the last name of parents in the  employees table, 
---- NEED TO UNDERSTAND THIS


SELECT FIRST_NAME, LAST_NAME,department_id FROM EMPLOYEES WHERE department_id IN
( SELECT department_id FROM departments WHERE location_id = 1700)

SELECT department_id FROM EMPLOYEES GROUP BY DEPARTMENT_ID HAVING department_id IN
( SELECT department_id FROM departments WHERE location_id = 1700)

SELECT FIRST_NAME, LAST_NAME,department_id FROM EMPLOYEES WHERE department_id NOT IN
( SELECT department_id FROM departments WHERE location_id = 1700)

SELECT * FROM EMPLOYEES WHERE SALARY = (SELECT MAX(SALARY) FROM employees)

SELECT FIRST_NAME FROM EMPLOYEES WHERE SALARY < (SELECT AVG(SALARY) FROM employees)

SELECT department_id, DEPARTMENT_NAME FROM departments WHERE DEPARTMENT_ID IN 
(SELECT department_id FROM employees WHERE SALARY > 10000)

SELECT department_id, DEPARTMENT_NAME FROM departments WHERE DEPARTMENT_ID NOT IN 
(SELECT department_id FROM employees WHERE SALARY > 10000)


SELECT department_id,SALARY FROM EMPLOYEES WHERE SALARY = 
(SELECT MIN(SALARY) FROM employees)

SELECT department_ID, MIN(SALARY) AS LOWEST_SALARY FROM employees GROUP BY department_id

SELECT FIRST_NAME,SALARY,department_id FROM employees WHERE SALARY > (SELECT MIN(SALARY) FROM employees)

SELECT FIRST_NAME,SALARY,department_id FROM employees WHERE SALARY < (SELECT MAX(SALARY) FROM employees)

SELECT AVG(SALARY), department_ID FROM employees GROUP BY department_id

SELECT AVG(AVG_SALARY) AS OVERALL_AVG FROM 
(SELECT AVG(SALARY) AS AVG_SALARY, department_ID 
FROM employees GROUP BY department_id) AS DEPT_AVG

SELECT 
employee_ID,
SALARY,
DEPARTMENT_ID,
(SELECT AVG(SALARY) FROM employees E2 WHERE E.DEPARTMENT_ID = E2.department_id) AS DEPT_AVG_SALARY,
SALARY - (SELECT AVG(SALARY) FROM EMPLOYEES E2 WHERE E.DEPARTMENT_ID = E2.department_id) AS SALARY_DIFFERENCE
FROM employees E























































