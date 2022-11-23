/* Select the last name of all employees. */

SELECT lastname FROM employees;

/* Select the last name of all employees, without duplicates. */

SELECT DISTINCT lastname FROM employees;

/* Select all the data of employees whose last name is "Smith". */

SELECT * FROM employees WHERE lastname='Smith';

/* Select all the data of employees whose last name is "Smith" or "Doe". */

SELECT * FROM employees WHERE lastname IN ('Smith', 'Doe');

/* Select all the data of employees that work in department 14. */

SELECT * FROM employees WHERE department=14;

/* Select all the data of employees that work in department 37 or 77 */

SELECT * FROM employees WHERE department IN (37, 77);

/* Select all the data of employees whose last name begins with an "S" */

SELECT * FROM employees WHERE lastname LIKE 'S%';

/* Select the sum of all the department's budgets */

SELECT SUM(budget) FROM departments;

/* Select the number of employees in each department (you only need to show the department code and the number of employees). */

SELECT department, COUNT(ssn) FROM employees GROUP BY department;

/* Select all the data of employees, including each employee's department's data. */

SELECT * FROM employees AS e
INNER JOIN departments AS d ON e.department=d.code;

/* Select the name and last name of each employee, along with the name and budget of the employee's department.. */

SELECT e.name, e.lastname, d.name as department_name, d.budget FROM employees AS e 
INNER JOIN departments AS d ON e.department=d.code;

/* Select the name and last name of employees working for department with a budget greater than $60,000. */

SELECT e.name, e.lastname FROM employees AS e
INNER JOIN departments AS d ON e.department=d.code 
WHERE d.budget>6 * POW(10, 4);

/* Select the departments with a budget larger than the average budget of all the departments. */

SELECT * FROM departments WHERE budget>(SELECT AVG(budget) FROM departments);

/* Select the names of departments with more than two employees. */

SELECT d.name FROM departments AS d
WHERE (SELECT COUNT(ssn) FROM employees WHERE department=d.code)>2;

SELECT d.name FROM departments AS d 
INNER JOIN employees AS e ON d.code=e.department 
GROUP BY d.name 
HAVING COUNT(ssn)>2;

/* Select the name and last name of employees working for departments with second lowest budget. */

SELECT e.name, e.lastname FROM employees AS e
INNER JOIN departments AS d ON e.department=d.code 
WHERE d.code=(
    SELECT code FROM departments 
    ORDER BY budget ASC LIMIT 1 OFFSET 1 
    );

/* Add a new department called "Quality Assurance", with a budget of $40,000 and department code 11. */

INSERT INTO departments (code, name, budget) VALUES (11, 'Quality Assurance', 40000);

/* Add an employee called "Mary Moore" in that department, with SSN 847-21-9811. */

INSERT INTO employees (ssn, name, lastname, department) VALUES (CAST('847219811' AS INTEGER), 'Mary', 'Moore', 11);

/* Reduce the budget of all departments by 10%. */ 

UPDATE departments SET budget=(budget * 0.9);

/* Reassign all employees from Research department (code 77) to the IT department (code 14). */

UPDATE employees SET department=14 WHERE department=77;

/* Delete from the table all employees in the IT department (code 14). */

DELETE FROM employees WHERE department=14;

/* Delete from the table all employees who work in departments with a budget greater than or equal to $60,000. */

DELETE FROM employees WHERE department IN (SELECT code FROM departments WHERE budget>=60000);

/* Delete from the table all employees. */

DELETE FROM employees;