/* 7.1 Who received a 1.5kg package? The result is "Al Gore's Head". */

SELECT c.name FROM client AS c 
JOIN package AS p ON c.accountnumber=p.recipient 
WHERE p.weight=15;

/* 7.2 What is the total weight of all the packages that he sent? */

SELECT SUM(p.weight) FROM client AS c 
JOIN package AS p ON c.accountnumber=p.recipient 
WHERE p.sender=(
    SELECT c.accountnumber FROM client AS c 
    JOIN package AS p ON c.accountnumber=p.recipient 
    WHERE p.weight=15
);

