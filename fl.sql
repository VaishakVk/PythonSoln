Select rows with maximum value

/*Consider a database with following columns
Table: Revs
ID Revision Value
1  1 		10
2  1		20
1  2        10
1  3        50
2  2        30

Firstly, derive the maximum revision, use GROUP BY on ID with MAX on Revision.
Then, this is joint with the table for the max revision and ID.
*/

SELECT a.*
 FROM Revs a 
     , (SELECT b.ID
			 , max(b.Revision) Revision_max
		 FROM revs b
		GROUP BY b.ID) rev
WHERE a.ID = rev.ID
  AND a.Revision = rev.Revision_max ;

----------
Remove duplicate columns in table with primary key 

/* This program will determine how to remove duplicate columns in a table with primary key
Table: Employee
ID  Emp_Num Name   Salary
1   1000    John   1000
2   1000    John   1000
3   1001    Craig  11000

Since ID is the primary key here, group the column based on any column other than the primary key - preferably Emp_Num since they differ for each employee
Pick the max or min ID for each employee number and delete all other columns other than the selected row for the Emp_Num
*/

DELETE FROM employee a
  WHERE a.id NOT IN (SELECT del.ID 
					   FROM (SELECT min(b.id)
                                  , b.emp_num					   
							   FROM employee b
							  GROUP BY b.emp_num) del) ;

----------							  
Remove duplicate columns in table without primary key 

/* This program will determine how to remove duplicate columns in a table without primary key
Table: Employee
Emp_Num Name   Salary
1000    John   1000
1000    John   1000
1001    Craig  11000

Since we do not have the primary key, group the column based on any column other than the primary key - preferably Emp_Num since they differ for each employee
Pick the max or min ROWID for each employee number and delete all other columns other than the selected row for the Emp_Num
*/

DELETE FROM employee a
  WHERE a.ROWID NOT IN (SELECT del.ROWID 
						FROM (SELECT min(b.ROWID)
                                   , b.emp_num					   
								FROM employee b
							  GROUP BY b.emp_num) del) ;

-----------							  
Count number of specific characters in a column

/* Determine the number of specific characters in a column 
eg. Count number of 'A' in the column name
Emp_Num Name     Salary
1000    John     1000
1002    Mathew   1000
1001    Craig    11000

Replace the A's with blank. Now subtract the length of the column initially and the length of the column after replacing. 
*/

SELECT LENGTH(NAME) - LENGTH(REPLACE(NAME, 'A', '')) Char_Count
  FROM employee ;

-----------
Nth salary in a database

/* Determine the n th salary in a database
eg. Determine the third highest salary
Emp_Num Name     Salary
1000    John     1000
1002    Mathew   1000
1001    Craig    11000

Make a subquery taking all the required data from employee table along with the rownum sorted in descending order. 
Use this data to get the required salary
*/

SELECT name
     , salary 
 FROM (
    SELECT Name
	     , Salary
		 , RN = ROW_NUMBER() OVER (ORDER BY Salary DESC)
    FROM employee
		) sal
WHERE RN = :nth_salary;

-------------
Extract duplicate rows present in a DB

/* This program will extract all the duplicate columns present in a DB 
Table: Employee
Emp_Num Name   Salary
1000    John   1000
1000    John   1000
1001    Craig  11000

Group the column based on any column that should stay unique for a row and take all the records that have a count greater than 1 for that particular value.
To get the number of duplicate rows, use count function and subtract it by 1 so that only the duplicate row count is listed
*/

SELECT name
     , emp_num
	 , count(*) - 1 Number of duplicate rows 					   
 FROM employee b
GROUP BY name  
      , emp_num
HAVING count(*) > 1;

------------
Calculate running total

/*Program to generate running total for every day.
Table: Sales

id     date    	   value
--     --------    ---------
45     01/Jan/17   3
23     08/Jan/17   5
12     02/Feb/17   0
77     14/Feb/17   7
39     20/Feb/17   34
33     02/Mar/17   6

The idea is to have a fourth column that will generate the total of value till date 

id     date    	   value  	  runningtotal
--     --------    ---------  ------------
45     01/Jan/09   3          3
23     08/Jan/09   5          8
12     02/Feb/09   0          8
77     14/Feb/09   7          15  
39     20/Feb/09   34         49
33     02/Mar/09   6          55

This is possible using OVER function and defining the limits to current row.
This way only the rows till current row will be considered.
*/

SELECT date, value,
  SUM(value) OVER(ORDER BY date 
     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
          AS RunningTotal
FROM sales ;

---------
Update using a SELECT statement

/* Program to update a table using SELECT statement

The SELECT query can be placed after the SET statement in UPDATE.
Use FROM to incorporate the SELECT condition
*/
UPDATE table 
SET Col1 = i.Col1, 
    Col2 = i.Col2 
FROM (
    SELECT ID, Col1, Col2 
    FROM other_table) i
WHERE 
    i.ID = table.ID ;
	
-------
Top n records from each group

/* Program to extract top n records from each group of a table.

Table: Fruits
  type   | variety  | price |
+--------+----------+-------+
| apple  | gala     |  2.79 | 
| apple  | fuji     |  0.24 | 
| orange | valencia |  3.59 | 
| orange | navel    |  9.36 | 
| pear   | bradford |  6.05 | 
| pear   | bartlett |  2.14 | 
| cherry | bing     |  2.55 | 
| cherry | chelan   |  6.33 | 

Go through the table. For each record check if the fruit's price is less than the n th cheapest price for the type.
*/

select type, variety, price
from fruits
where (
   select count(*) from fruits as f
   where f.type = fruits.type and f.price <= fruits.price
) <= :n ;

------
Select a random row from a table

/* Program to generate a random row from a table
Use the function dbms_random.value in the ORDER BY clause.
This will reorder all the rows in the table in a random fashion.
Now take out the first row to get the random row
*/

SELECT a.column 
FROM ( SELECT column 
        FROM table
	ORDER BY dbms_random.value ) a
WHERE rownum = 1 ;

-------
Concatenate values to a single row from multiple rows

/* Program to concatenate values to a single row from multiple rows
PID   SEQ    Desc
A     1      Have
A     2      a nice
A     3      day.
B     1      Nice Work.
C     1      Yes
C     2      we can 
C     3      do 
C     4      this work!

A very common one is to use LISTAGG. 
Then join to A to pick out the pids you want.
Point to Note: LISTAGG only works correctly with VARCHAR2 columns.
*/

SELECT pid
     , LISTAGG(Desc, ' ') WITHIN GROUP (ORDER BY seq) AS desc
FROM B 
GROUP BY pid;

-------
Table name as variable

/*Program to use Table Name as variable
Dynamically pass table name during run time using EXECUTE IMMEDIATE.
Store the table name in a variable
Refer the variable during run time.
The table will be directly used.
*/

DECLARE

 l_tblnam   varchar2(20) := 'emp';
 l_cnt      number;

BEGIN
 EXECUTE IMMEDIATE 'SELECT count(*) FROM :a ;'
   INTO l_cnt
   USING in l_tblnam;

 IF l_cnt == 0 then
    dbms_output.put_line('No Data');
 END IF;
END;

-----
Split comma separated values to columns

/* Program to convert Comma separated values in a column to multiple columns

Table: dummy
ROW  | VAL
----------- 
1    | 1.25, 3.87, 2
2    | 5, 4, 3.3

Create a Regex statement that will parse after every ','.
Match the occurrence of ',' and split it accordingly.
Limitation of using the above method - There should not be any NULL values in the middle.
The number of values separated should be constant
*/

SELECT regexp_substr(val, '[^,]+', 1, 1) as val1, 
       regexp_substr(val, '[^,]+', 1, 2) as val2, 
       regexp_substr(val, '[^,]+', 1, 3) as val3
FROM dummy;	   

-------
Upsert (Update or Insert based on the condition) a table

/* Program to update or insert a table based on a condition
Usual method to achieve this is using MERGE.
Based on a condition, either of the conditions will be evaluated. 
This statement is a convenient way to combine multiple operations. 
It lets you avoid multiple INSERT, UPDATE, and DELETE DML statements.
*/

MERGE INTO bonuses D
   USING (SELECT employee_id, salary, department_id FROM employees
   WHERE department_id = 80) S
   ON (D.employee_id = S.employee_id)
   WHEN MATCHED THEN UPDATE SET D.bonus = D.bonus + S.salary*.01
     DELETE WHERE (S.salary > 8000)
   WHEN NOT MATCHED THEN INSERT (D.employee_id, D.bonus)
     VALUES (S.employee_id, S.salary*.01)
     WHERE (S.salary <= 8000);
	 
--------
Generating Factorial Series using SQL

/* Program to generate a Factorial series
Using Recursion,we can generate the Factorial Series through SQL
Pass the number whose factorial is required. 
The recursion starts at 1 and the program keeps looping till the number is reached.
*/

;with fact as (
    select 1 as fac, 1 as num
    union all
    select fac*(num+1), num+1
    from fact
    where num<12)
select fac
from fact
where num=5

--------
Generating Fibonacci Series using SQL

/* Program to generate a Fibonacci series
Using Recursion,we can generate the Factorial Series through SQL
Pass the nth term 
The recursion starts at 1 and the program keeps looping till the number is reached.
*/

;with fibo as (
    select 0 as fibA, 0 as fibB, 1 as seed, 1 as  num
    union all
    select seed+fibA, fibA+fibB, fibA, num+1
    from fibo
    where num<12)
select fibA
from fibo
where num = 5

-------
Last SQL fired by the User on Database

/* Program to get the last SQL fired by a user on a DB.
v$sqltext_with_newlines contains the SQL that was fired by the user
This is joined with the session and user tables to get the SQL 
*/

SELECT S.USERNAME || '(' || s.sid || ')-' || s.osuser UNAME,
         s.program || '-' || s.terminal || '(' || s.machine || ')' PROG,
         s.sid || '/' || s.serial# sid,
         s.status "Status",
         p.spid,
         sql_text sqltext
    FROM v$sqltext_with_newlines t, V$SESSION s, v$process p
   WHERE     t.address = s.sql_address
         AND p.addr = s.paddr(+)
         AND t.hash_value = s.sql_hash_value
ORDER BY s.sid, t.piece;

-----------
