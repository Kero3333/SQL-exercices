/* Select the names of all the products in the store. */
SELECT name FROM products;

/*Select the names and the prices of all the products in the store.*/
SELECT name, price FROM products;

/* Select the name of the products with a price less than or equal to $200.*/
SELECT name, price FROM products WHERE price<=200;

/*Select all the products with a price between $60 and $120.*/
SELECT name, price FROM products WHERE price>60 AND price<120;
SELECT name, price FROM products WHERE price BETWEEN 61 AND 119;

/*Select the name and price in cents (i.e., the price must be multiplied by 100).*/
SELECT name, (price * 100) FROM products;

/*Compute the average price of all the products.*/
SELECT AVG(price) FROM products;

/*Compute the average price of all products with manufacturer code equal to 2.*/
SELECT manufacturer, AVG(price) FROM products
WHERE manufacturer=2 
GROUP BY manufacturer;

/*Compute the number of products with a price larger than or equal to $180.*/
SELECT COUNT(code) FROM products WHERE price>=180;

/* Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).*/
SELECT name, price FROM products WHERE price>=180 ORDER BY price DESC, name ASC;

/*Select all the data from the products, including all the data for each product's manufacturer.*/
SELECT * FROM products AS p
INNER JOIN manufacturers AS m ON p.manufacturer=m.code;

/*Select the product name, price, and manufacturer name of all the products.*/
SELECT p.name, p.price, m.name FROM products AS p
INNER JOIN manufacturers AS m ON p.manufacturer=m.code;

/* Select the average price of each manufacturer's products, showing only the manufacturer's code.*/
SELECT m.code, AVG(p.price) FROM products AS p
INNER JOIN manufacturers AS m ON p.manufacturer=m.code
GROUP BY m.code;

/*Select the average price of each manufacturer's products, showing the manufacturer's name. */
SELECT m.name, AVG(p.price) FROM products AS p
INNER JOIN manufacturers AS m ON p.manufacturer=m.code
GROUP BY m.code;

/*Select the names of manufacturer whose products have an average price larger than or equal to $150.*/
SELECT m.name FROM products AS p
INNER JOIN manufacturers AS m ON p.manufacturer=m.code
WHERE (
    SELECT AVG(p1.price) FROM products AS p1
    WHERE p1.code=p.code
    GROUP BY p1.manufacturer
    )>=150
GROUP BY m.code;

SELECT m.name FROM products AS p
INNER JOIN manufacturers AS m ON p.manufacturer=m.code
GROUP BY m.name
HAVING AVG(p.price)>=150;

/*Select the name and price of the cheapest product.*/
SELECT name, price FROM products ORDER BY price ASC LIMIT 1;
SELECT name, price FROM products WHERE (SELECT MIN(price) FROM products)=price;

/*Select the name of each manufacturer along with the name and price of its most expensive product.*/
SELECT m.name AS manufacturer_name, p.name AS product_name, p.price FROM products AS p
INNER JOIN manufacturers AS m ON p.manufacturer=m.code
WHERE p.price=(
    SELECT p1.price FROM products AS p1 
    WHERE p1.manufacturer=m.code 
    ORDER BY p1.price DESC
    LIMIT 1
);

SELECT m.name AS manufacturer_name, p.name AS product_name, p.price FROM products AS p
INNER JOIN manufacturers AS m ON p.manufacturer=m.code 
WHERE (SELECT MAX(price) FROM products WHERE products.manufacturer=m.code)=price;

/*Add a new product: Loudspeakers, $70, manufacturer 2.*/
INSERT INTO products (code, name, price, manufacturer) VALUES ((SELECT MAX(code) + 1 FROM products),'Loudspeakers', 70, 2);

/*Update the name of product 8 to "Laser Printer".*/
UPDATE products SET name='Laser Printer' WHERE code=8;

/*Apply a 10% discount to all products.*/
UPDATE products SET price=(price * 0.9);

/*Apply a 10% discount to all products with a price larger than or equal to $120.*/
UPDATE products SET price=(price * 0.9) WHERE price>=120;