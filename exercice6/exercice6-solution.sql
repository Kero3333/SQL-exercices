/* 6.1 List all the scientists' names, their projects' names, and the hours worked by that scientist on each project, 
in alphabetical order of project name, then scientist name. */

SELECT s.name AS scientist, p.name AS project, p.hours FROM scientists AS s 
JOIN assignedto AS a ON s.ssn=a.scientist 
JOIN projects AS p ON a.project=p.code 
ORDER BY p.name, s.name ASC;

/* 6.2 Select the project names which are not assigned yet */

SELECT p.name FROM projects AS p 
LEFT JOIN assignedto AS a ON p.code=a.project 
WHERE a.scientist IS NULL;