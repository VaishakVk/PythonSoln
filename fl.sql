
-- Select all data from table
SELECT * 
FROM employees;

-- Select particular fields from table
SELECT employee_id,
       first_name,
       last_name
  FROM employees;

-- Filter records based on a parameter
SELECT * 
  FROM employees
 WHERE salary > :salary;
 
-- Number of records in a particular department 
SELECT department
     , count(*) employees_in_dept
  FROM employees
GROUP BY department

-- Update all records in a table
UPDATE employees
   SET salary = 10000
   
-- Update all records in a table based on a filter
UPDATE employees
   SET salary = 20000
 WHERE department = :dept
 
 -- Delete records from table
DELETE FROM employees
WHERE department = :dept
