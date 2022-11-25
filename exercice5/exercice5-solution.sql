/* 5.1 Select the name of all the pieces. */

SELECT name FROM pieces;

/* 5.2 Select all the providers' data. */

SELECT * FROM providers;

/* 5.3 Obtain the average price of each piece (show only the piece code and the average price). */

SELECT p.code, AVG(price) FROM pieces AS p
JOIN provides AS pr ON p.code=pr.piece
GROUP BY p.code;

/* 5.4 Obtain the names of all providers who supply piece 1. */

SELECT pro.name FROM providers AS pro 
JOIN provides AS pr ON pro.code=pr.provider
WHERE pr.piece=1;

/* 5.5 Select the name of pieces provided by provider with code "HAL". */

SELECT p.name FROM pieces AS p 
JOIN provides AS pr ON p.code=pr.piece 
JOIN providers AS pro ON pr.provider=pro.code 
WHERE pro.code='HAL';

/* 5.6 Interesting and important one.
For each piece, find the most expensive offering of that piece and include the piece name,
provider name, and price (note that there could be two providers who supply the same piece at the most expensive price). */

SELECT p.name, pro.name, pr.price FROM pieces AS p
JOIN provides AS pr ON p.code=pr.piece 
JOIN providers AS pro ON pr.provider=pro.code 
WHERE (
    SELECT MAX(price) FROM provides
    WHERE piece=p.code
)=pr.price;

/* 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each. */

INSERT INTO provides (piece, provider, price) VALUES (1, 'TNBC', 7);

/* 5.8 Increase all prices by one cent. */

UPDATE provides SET price=(price + 1);

/* 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4). */

DELETE FROM provides WHERE provider='RBT' AND piece=4;

/* 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces (the provider should still remain in the database). */

DELETE FROM provides WHERE provider='RBT';


