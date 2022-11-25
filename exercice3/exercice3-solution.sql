/* Select all warehouses. */

SELECT * FROM warehouses;

/* Select all boxes with a value larger than $150. */

SELECT * FROM boxes WHERE value>150;

/* Select all distinct contents in all the boxes. */

SELECT DISTINCT contents FROM boxes;

/* Select the average value of all the boxes. */

SELECT AVG(value) FROM boxes;

/* Select the warehouse code and the average value of the boxes in each warehouse. */

SELECT w.code, AVG(b.value) FROM boxes AS b
INNER JOIN warehouses AS w ON b.warehouse=w.code
GROUP BY w.code;

/* Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150. */

SELECT w.code, AVG(b.value) FROM boxes AS b
INNER JOIN warehouses AS w ON b.warehouse=w.code
GROUP BY w.code
HAVING AVG(b.value)>150;

/* Select the code of each box, along with the name of the city the box is located in. */

SELECT b.code, w.location FROM boxes AS b
INNER JOIN warehouses AS w ON b.warehouse=w.code;

/* Select the warehouse codes, along with the number of boxes in each warehouse. Optionnaly, take into account that some warehouses are empty (i.e., the bow count should show up as zero, instead of omitting the warehouse from the result). */

SELECT w.code, 
CASE
    WHEN COUNT(b.code) IS NULL THEN 0
    ELSE COUNT(b.code)
END AS number_of_boxes
FROM warehouses AS w
LEFT JOIN boxes AS b ON w.code=b.warehouse
GROUP BY w.code
ORDER BY w.code ASC;


/* Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity). */

SELECT w.code FROM warehouses AS w
JOIN boxes AS b ON w.code=b.warehouse
GROUP BY w.code 
HAVING w.capacity<COUNT(b.code);

/* Select the codes of all the boxes located in Chicago. */

SELECT b.code FROM boxes AS b
JOIN warehouses AS w ON b.warehouse=w.code
WHERE w.location='Chicago';

/* Create a new warehouse in New York with a capacity for 3 boxes. */

INSERT INTO warehouses (code, location, capacity) VALUES ((SELECT MAX(code) + 1 FROM warehouses), 'New York', 3);

/* Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2. */

INSERT INTO boxes (code, contents, value, warehouse) VALUES ('H5RT', 'Papers', 200, 2);

/* Reduce the value of all boxes by 15%. */

UPDATE boxes SET value=(value * 0.85);

/* Remove all boxes with a value lower than $100. */

DELETE FROM boxes WHERE value<100;

/* Remove all boxes from saturated warehouses. */

DELETE FROM boxes WHERE warehouse IN (
    SELECT w.code FROM warehouses AS w
    JOIN boxes AS b ON w.code=b.warehouse
    GROUP BY w.code 
    HAVING w.capacity<COUNT(b.code)
);

/* Add Index for column "Warehouse" in table "boxes" */

CREATE INDEX index_warehouse ON boxes (warehouse);

/* Print all the existing indexes */

SELECT * FROM pg_indexes;

/* Remove (drop) the index you just added */

DROP INDEX index_warehouse;