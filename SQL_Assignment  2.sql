CREATE DATABASE jalaj;
USE jalaj;

-- 1. Create Salespeople Table
CREATE TABLE SALESPEOPLE (
    SNUM INT PRIMARY KEY,
    SNAME VARCHAR(30),
    CITY VARCHAR(30),
    COMM DECIMAL(4,2)
);

-- 2. Create Customer Table
CREATE TABLE CUST (
    CNUM INT PRIMARY KEY,
    CNAME VARCHAR(30),
    CITY VARCHAR(30),
    RATING INT,
    SNUM INT
);

-- 3. Create Orders Table
CREATE TABLE ORDERS (
    ONUM INT PRIMARY KEY,
    AMT DECIMAL(7,2),
    ODATE VARCHAR(15),
    CNUM INT,
    SNUM INT
);

-- 4. Insert Salespeople Data
INSERT INTO SALESPEOPLE (SNUM, SNAME, CITY, COMM) VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rafkin', 'Barcelona', 0.15),
(1003, 'Axelrod', 'New york', 0.10);

-- 5. Insert Customer Data
INSERT INTO CUST (CNUM, CNAME, CITY, RATING, SNUM) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Brelin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);

-- 6. Insert Orders Data
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES
(3001, 18.69, '03-OCT-94', 2008, 1007),
(3003, 767.19, '03-OCT-94', 2001, 1001),
(3002, 1900.10, '03-OCT-94', 2007, 1004),
(3005, 5160.45, '03-OCT-94', 2003, 1002),
(3006, 1098.16, '04-OCT-94', 2008, 1007),
(3009, 1713.23, '04-OCT-94', 2002, 1003),
(3007, 75.75, '05-OCT-94', 2004, 1002),
(3008, 4723.00, '05-OCT-94', 2006, 1001),
(3010, 1309.95, '06-OCT-94', 2004, 1002),
(3011, 9891.88, '06-OCT-94', 2006, 1001);
-- 1. Display snum, sname, city and comm of all salespeople
SELECT SNUM, SNAME, CITY, COMM 
FROM SALESPEOPLE;

-- 2. Display all snum without duplicates from all orders
SELECT DISTINCT SNUM 
FROM ORDERS;

-- 3. Display names and commissions of all salespeople in London
SELECT SNAME, COMM 
FROM SALESPEOPLE 
WHERE CITY = 'London';

-- 4. All customers with rating of 100
SELECT * 
FROM CUST 
WHERE RATING = 100;

-- 5. Produce orderno, amount and date from all rows in the order table
SELECT ONUM, AMT, ODATE 
FROM ORDERS;

-- 6. All customers in San Jose, who have rating more than 200
SELECT * 
FROM CUST 
WHERE CITY = 'San Jose' AND RATING > 200;

-- 7. All customers who were either located in San Jose or had a rating above 200
SELECT * 
FROM CUST 
WHERE CITY = 'San Jose' OR RATING > 200;

-- 8. All orders for more than $1000
SELECT * 
FROM ORDERS 
WHERE AMT > 1000;

-- 9. Names and cities of all salespeople in london with commission above 0.10
SELECT SNAME, CITY 
FROM SALESPEOPLE 
WHERE CITY = 'London' AND COMM > 0.10;

-- 10. All customers excluding those with rating <= 100 unless they are located in Rome
SELECT * 
FROM CUST 
WHERE RATING > 100 OR CITY = 'Rome';

-- 11. All salespeople either in Barcelona or in london
SELECT * 
FROM SALESPEOPLE 
WHERE CITY IN ('Barcelona', 'London');

-- 12. All salespeople with commission between 0.10 and 0.12 (Boundary values excluded)
SELECT * 
FROM SALESPEOPLE 
WHERE COMM > 0.10 AND COMM < 0.12;

-- 13. All customers with NULL values in city column
SELECT * 
FROM CUST 
WHERE CITY IS NULL;

-- 14. All orders taken on Oct 3rd and Oct 4th 1994
SELECT * 
FROM ORDERS 
WHERE ODATE IN ('03-OCT-94', '04-OCT-94');

-- 15. All customers serviced by Peel or Motika
SELECT * 
FROM CUST 
WHERE SNUM IN (SELECT SNUM FROM SALESPEOPLE WHERE SNAME IN ('Peel', 'Motika'));

-- 16. All customers whose names begin with a letter from A to B
SELECT * 
FROM CUST 
WHERE CNAME REGEXP '^[A-B]';

-- 17. All orders except those with 0 or NULL value in amt field
SELECT * 
FROM ORDERS 
WHERE AMT > 0 AND AMT IS NOT NULL;

-- 18. Count the number of salespeople currently listing orders in the order table
SELECT COUNT(DISTINCT SNUM) 
FROM ORDERS;

-- 19. Largest order taken by each salesperson, datewise
SELECT SNUM, ODATE, MAX(AMT) 
FROM ORDERS 
GROUP BY SNUM, ODATE;

-- 20. Largest order taken by each salesperson with order value more than $3000
SELECT SNUM, MAX(AMT) 
FROM ORDERS 
GROUP BY SNUM 
HAVING MAX(AMT) > 3000;

-- 21. Which day had the highest total amount ordered
SELECT ODATE, SUM(AMT) 
FROM ORDERS 
GROUP BY ODATE 
ORDER BY SUM(AMT) DESC 
LIMIT 1;

-- 22. Count all orders for Oct 3rd
SELECT COUNT(*) 
FROM ORDERS 
WHERE ODATE = '03-OCT-94';

-- 23. Count the number of different non NULL city values in customers table
SELECT COUNT(DISTINCT CITY) 
FROM CUST 
WHERE CITY IS NOT NULL;

-- 24. Select each customer’s smallest order
SELECT CNUM, MIN(AMT) 
FROM ORDERS 
GROUP BY CNUM;

-- 25. First customer in alphabetical order whose name begins with G
SELECT * FROM CUST 
WHERE CNAME LIKE 'G%' 
ORDER BY CNAME ASC 
LIMIT 1;

-- 26. Get the output like “ For dd/mm/yy there are ___ orders."
SELECT CONCAT('For ', ODATE, ' there are ', COUNT(*), ' orders.') AS Output
FROM ORDERS 
GROUP BY ODATE;

-- 27. Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order
SELECT ONUM, SNUM, (AMT * 0.12) AS COMMISSION_AMT 
FROM ORDERS;

-- 28. Find highest rating in each city. Put the output in this form. For the city (city), the highest rating is : (rating)
SELECT CONCAT('For the city ', CITY, ', the highest rating is : ', MAX(RATING)) AS Output
FROM CUST 
GROUP BY CITY;

-- 29. Display the totals of orders for each day and place the results in descending order
SELECT ODATE, SUM(AMT) 
FROM ORDERS 
GROUP BY ODATE 
ORDER BY SUM(AMT) DESC;

-- 30. All combinations of salespeople and customers who shared a city (i.e. same city)
SELECT S.SNAME, C.CNAME, S.CITY 
FROM SALESPEOPLE S 
JOIN CUST C ON S.CITY = C.CITY;

-- 31. Name of all customers matched with the salespeople serving them
SELECT C.CNAME, S.SNAME 
FROM CUST C 
JOIN SALESPEOPLE S ON C.SNUM = S.SNUM;

-- 32. List each order number followed by the name of the customer who made the order
SELECT O.ONUM, C.CNAME 
FROM ORDERS O 
JOIN CUST C ON O.CNUM = C.CNUM;

-- 33. Names of salesperson and customer for each order after the order number
SELECT O.ONUM, S.SNAME, C.CNAME 
FROM ORDERS O 
JOIN SALESPEOPLE S ON O.SNUM = S.SNUM 
JOIN CUST C ON O.CNUM = C.CNUM;

-- 34. Produce all customer serviced by salespeople with a commission above 12%
SELECT C.* 
FROM CUST C 
JOIN SALESPEOPLE S ON C.SNUM = S.SNUM 
WHERE S.COMM > 0.12;

-- 35. Calculate the amount of the salesperson’s commission on each order with a rating above 100
SELECT O.ONUM, (O.AMT * S.COMM) AS COMMISSION_AMT 
FROM ORDERS O 
JOIN SALESPEOPLE S ON O.SNUM = S.SNUM 
JOIN CUST C ON O.CNUM = C.CNUM 
WHERE C.RATING > 100;

-- 36. Find all pairs of customers having the same rating
SELECT C1.CNAME AS Customer1, C2.CNAME AS Customer2, C1.RATING 
FROM CUST C1 
JOIN CUST C2 ON C1.RATING = C2.RATING;

-- 37. Find all pairs of customers having the same rating, each pair coming once only
SELECT C1.CNAME AS Customer1, C2.CNAME AS Customer2, C1.RATING 
FROM CUST C1 
JOIN CUST C2 ON C1.RATING = C2.RATING 
WHERE C1.CNUM < C2.CNUM;

-- 38. Policy is to assign three salesperson to each customer. Display all such combinations
SELECT C.CNAME, S1.SNAME, S2.SNAME, S3.SNAME 
FROM CUST C 
CROSS JOIN SALESPEOPLE S1 
CROSS JOIN SALESPEOPLE S2 
CROSS JOIN SALESPEOPLE S3 
WHERE S1.SNUM < S2.SNUM AND S2.SNUM < S3.SNUM;

-- 39. Display all customers located in cities where salesman Serres has customers
SELECT * FROM CUST 
WHERE CITY IN (SELECT DISTINCT CITY FROM CUST WHERE SNUM = (SELECT SNUM FROM SALESPEOPLE WHERE SNAME = 'Serres'));

-- 40. Find all pairs of customers served by a single salesperson
SELECT C1.CNAME AS Customer1, C2.CNAME AS Customer2, C1.SNUM 
FROM CUST C1 
JOIN CUST C2 ON C1.SNUM = C2.SNUM 
WHERE C1.CNUM < C2.CNUM;

-- 41. Produce all pairs of salespeople which are living in the same city. Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.
SELECT S1.SNAME AS Salesperson1, S2.SNAME AS Salesperson2, S1.CITY 
FROM SALESPEOPLE S1 
JOIN SALESPEOPLE S2 ON S1.CITY = S2.CITY 
WHERE S1.SNUM < S2.SNUM;

-- 42. Produce all pairs of orders by given customer, names that customers and eliminates duplicates.
SELECT C.CNAME, O1.ONUM AS Order1, O2.ONUM AS Order2 
FROM ORDERS O1 
JOIN ORDERS O2 ON O1.CNUM = O2.CNUM 
JOIN CUST C ON O1.CNUM = C.CNUM 
WHERE O1.ONUM < O2.ONUM;

-- 43. Produce names and cities of all customers with the same rating as Hoffman.
SELECT CNAME, CITY 
FROM CUST 
WHERE RATING = (SELECT RATING FROM CUST WHERE CNAME = 'Hoffman') 
AND CNAME <> 'Hoffman';

-- 44. Extract all the orders of Motika.
SELECT * FROM ORDERS 
WHERE SNUM = (SELECT SNUM FROM SALESPEOPLE WHERE SNAME = 'Motika');

-- 45. All orders credited to the same salesperson who services Hoffman.
SELECT * FROM ORDERS 
WHERE SNUM = (SELECT SNUM FROM CUST WHERE CNAME = 'Hoffman');

-- 46. All orders that are greater than the average for Oct 4.
SELECT * FROM ORDERS 
WHERE AMT > (SELECT AVG(AMT) FROM ORDERS WHERE ODATE = '04-OCT-94');

-- 47. Find average commission of salespeople in london.
SELECT AVG(COMM) 
FROM SALESPEOPLE 
WHERE CITY = 'London';

-- 48. Find all orders attributed to salespeople servicing customers in london.
SELECT * FROM ORDERS 
WHERE SNUM IN (SELECT DISTINCT SNUM FROM CUST WHERE CITY = 'London');

-- 49. Extract commissions of all salespeople servicing customers in London.
SELECT COMM 
FROM SALESPEOPLE 
WHERE SNUM IN (SELECT DISTINCT SNUM FROM CUST WHERE CITY = 'London');

-- 50. Find all customers whose cnum is 1000 above the snum of serres.
SELECT * FROM CUST 
WHERE CNUM = (SELECT SNUM FROM SALESPEOPLE WHERE SNAME = 'Serres') + 1000;

-- 51. Count the customers with rating above San Jose’s average.
SELECT COUNT(*) 
FROM CUST 
WHERE RATING > (SELECT AVG(RATING) FROM CUST WHERE CITY = 'San Jose');

-- 52. Obtain all orders for the customer named Cisnerous. (Assume you don’t know his customer no. (cnum)).
SELECT * FROM ORDERS 
WHERE CNUM = (SELECT CNUM FROM CUST WHERE CNAME = 'Cisnerous');

-- 53. Produce the names and rating of all customers who have above average orders.
SELECT CNAME, RATING 
FROM CUST 
WHERE CNUM IN (SELECT CNUM FROM ORDERS WHERE AMT > (SELECT AVG(AMT) FROM ORDERS));

-- 54. Find total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table.
SELECT SNUM, SUM(AMT) 
FROM ORDERS 
GROUP BY SNUM 
HAVING SUM(AMT) > (SELECT MAX(AMT) FROM ORDERS);

-- 55. Find all customers with order on 3rd Oct.
SELECT * FROM CUST 
WHERE CNUM IN (SELECT CNUM FROM ORDERS WHERE ODATE = '03-OCT-94');

-- 56. Find names and numbers of all salesperson who have more than one customer.
SELECT SNUM, SNAME 
FROM SALESPEOPLE 
WHERE SNUM IN (SELECT SNUM FROM CUST GROUP BY SNUM HAVING COUNT(*) > 1);

-- 57. Check if the correct salesperson was credited with each sale.
SELECT O.ONUM, O.SNUM AS Order_Snum, C.SNUM AS Customer_Snum,
       CASE WHEN O.SNUM = C.SNUM THEN 'Correct' ELSE 'Incorrect' END AS Verification
FROM ORDERS O
JOIN CUST C ON O.CNUM = C.CNUM;

-- 58. Find all orders with above average amounts for their customers.
SELECT O1.* 
FROM ORDERS O1 
WHERE O1.AMT > (SELECT AVG(O2.AMT) FROM ORDERS O2 WHERE O2.CNUM = O1.CNUM);

-- 59. Find the sums of the amounts from order table grouped by date, eliminating all those dates where the sum was not at least 2000 above the maximum amount.
SELECT ODATE, SUM(AMT) 
FROM ORDERS 
GROUP BY ODATE 
HAVING SUM(AMT) > (SELECT MAX(AMT) FROM ORDERS) + 2000;

-- 60. Find names and numbers of all customers with ratings equal to the maximum for their city.
SELECT CNUM, CNAME, CITY, RATING 
FROM CUST C1 
WHERE RATING = (SELECT MAX(RATING) FROM CUST C2 WHERE C2.CITY = C1.CITY);

-- 61a. Find all salespeople who have customers in their cities who they don’t service. (Using Join)
SELECT DISTINCT S.SNUM, S.SNAME, S.CITY
FROM SALESPEOPLE S
JOIN CUST C ON S.CITY = C.CITY
WHERE S.SNUM <> C.SNUM;

-- 61b. Find all salespeople who have customers in their cities who they don’t service. (Using Correlated subquery)
SELECT SNUM, SNAME, CITY 
FROM SALESPEOPLE S
WHERE EXISTS (
    SELECT * FROM CUST C 
    WHERE C.CITY = S.CITY AND C.SNUM <> S.SNUM
);

-- 62. Extract cnum,cname and city from customer table if and only if one or more of the customers in the table are located in San Jose.
SELECT CNUM, CNAME, CITY 
FROM CUST 
WHERE EXISTS (SELECT * FROM CUST WHERE CITY = 'San Jose');

-- 63. Find salespeople no. who have multiple customers.
SELECT SNUM 
FROM CUST 
GROUP BY SNUM 
HAVING COUNT(*) > 1;

-- 64. Find salespeople number, name and city who have multiple customers.
SELECT SNUM, SNAME, CITY 
FROM SALESPEOPLE 
WHERE SNUM IN (SELECT SNUM FROM CUST GROUP BY SNUM HAVING COUNT(*) > 1);

-- 65. Find salespeople who serve only one customer.
SELECT SNUM, SNAME, CITY 
FROM SALESPEOPLE 
WHERE SNUM IN (SELECT SNUM FROM CUST GROUP BY SNUM HAVING COUNT(*) = 1);

-- 66. Extract rows of all salespeople with more than one current order.
SELECT * FROM SALESPEOPLE 
WHERE SNUM IN (SELECT SNUM FROM ORDERS GROUP BY SNUM HAVING COUNT(*) > 1);

-- 67. Find all salespeople who have customers with a rating of 300. (use EXISTS)
SELECT * FROM SALESPEOPLE S 
WHERE EXISTS (SELECT * FROM CUST C WHERE C.SNUM = S.SNUM AND C.RATING = 300);

-- 68. Find all salespeople who have customers with a rating of 300. (use Join).
SELECT DISTINCT S.* 
FROM SALESPEOPLE S 
JOIN CUST C ON S.SNUM = C.SNUM 
WHERE C.RATING = 300;

-- 69. Select all salespeople with customers located in their cities who are not assigned to them. (use EXISTS).
SELECT * FROM SALESPEOPLE S 
WHERE EXISTS (SELECT * FROM CUST C WHERE C.CITY = S.CITY AND C.SNUM <> S.SNUM);

-- 70. Extract from customers table every customer assigned the a salesperson who currently has at least one other customer ( besides the customer being selected) with orders in order table.
SELECT * FROM CUST C1 
WHERE SNUM IN (
    SELECT SNUM FROM ORDERS 
    GROUP BY SNUM 
    HAVING COUNT(DISTINCT CNUM) > 1
);

-- 71a. Find salespeople with customers located in their cities (using IN).
SELECT * FROM SALESPEOPLE WHERE SNUM IN (SELECT SNUM FROM CUST C WHERE C.CITY = SALESPEOPLE.CITY);

-- 71b. Find salespeople with customers located in their cities (using ANY).
SELECT * FROM SALESPEOPLE WHERE SNUM = ANY (SELECT SNUM FROM CUST C WHERE C.CITY = SALESPEOPLE.CITY);

-- 72a. Find all salespeople for whom there are customers that follow them in alphabetical order. (Using ANY)
SELECT * FROM SALESPEOPLE S WHERE S.SNAME < ANY (SELECT CNAME FROM CUST);

-- 72b. Find all salespeople for whom there are customers that follow them in alphabetical order. (Using EXISTS)
SELECT * FROM SALESPEOPLE S WHERE EXISTS (SELECT * FROM CUST C WHERE C.CNAME > S.SNAME);

-- 73. Select customers who have a greater rating than any customer in rome.
SELECT * FROM CUST 
WHERE RATING > ANY (SELECT RATING FROM CUST WHERE CITY = 'Rome');

-- 74. Select all orders that had amounts that were greater that atleast one of the orders from Oct 6th.
SELECT * FROM ORDERS 
WHERE AMT > ANY (SELECT AMT FROM ORDERS WHERE ODATE = '06-OCT-94');

-- 75a. Find all orders with amounts smaller than any amount for a customer in San Jose. (Using ANY)
SELECT * FROM ORDERS 
WHERE AMT < ANY (SELECT O.AMT FROM ORDERS O JOIN CUST C ON O.CNUM = C.CNUM WHERE C.CITY = 'San Jose');

-- 75b. Find all orders with amounts smaller than any amount for a customer in San Jose. (Without ANY)
SELECT * FROM ORDERS 
WHERE AMT < (SELECT MAX(O.AMT) FROM ORDERS O JOIN CUST C ON O.CNUM = C.CNUM WHERE C.CITY = 'San Jose');

-- 76a. Select those customers whose ratings are higher than every customer in Paris. (Using ALL)
SELECT * FROM CUST 
WHERE RATING > ALL (SELECT RATING FROM CUST WHERE CITY = 'Paris');

-- 76b. Select those customers whose ratings are higher than every customer in Paris. (Using NOT EXISTS)
SELECT * FROM CUST C1 
WHERE NOT EXISTS (SELECT * FROM CUST C2 WHERE C2.CITY = 'Paris' AND C1.RATING <= C2.RATING);

-- 77. Select all customers whose ratings are equal to or greater than ANY of the Serres.
SELECT * FROM CUST 
WHERE RATING >= ANY (SELECT RATING FROM CUST WHERE SNUM = (SELECT SNUM FROM SALESPEOPLE WHERE SNAME = 'Serres'));

-- 78a. Find all salespeople who have no customers located in their city. (Using ANY)
SELECT * FROM SALESPEOPLE 
WHERE NOT (CITY = ANY (SELECT CITY FROM CUST));

-- 78b. Find all salespeople who have no customers located in their city. (Using ALL)
SELECT * FROM SALESPEOPLE 
WHERE CITY <> ALL (SELECT CITY FROM CUST WHERE CITY IS NOT NULL);

-- 79. Find all orders for amounts greater than any for the customers in London.
SELECT * FROM ORDERS 
WHERE AMT > ANY (SELECT O.AMT FROM ORDERS O JOIN CUST C ON O.CNUM = C.CNUM WHERE C.CITY = 'London');

-- 80. Find all salespeople and customers located in london.
SELECT SNAME AS Name, CITY, 'Salesperson' AS Role FROM SALESPEOPLE WHERE CITY = 'London'
UNION
SELECT CNAME AS Name, CITY, 'Customer' AS Role FROM CUST WHERE CITY = 'London';

-- 81. For every salesperson, dates on which highest and lowest orders were brought.
SELECT SNUM, 
       (SELECT ODATE FROM ORDERS O2 WHERE O2.SNUM = O1.SNUM ORDER BY AMT DESC LIMIT 1) AS Date_Highest,
       (SELECT ODATE FROM ORDERS O3 WHERE O3.SNUM = O1.SNUM ORDER BY AMT ASC LIMIT 1) AS Date_Lowest
FROM ORDERS O1
GROUP BY SNUM;

-- 82. List all of the salespeople and indicate those who don’t have customers in their cities as well as those who do have.
SELECT SNAME, CITY,
       CASE WHEN CITY IN (SELECT DISTINCT CITY FROM CUST) THEN 'Has Customers in City'
            ELSE 'No Customers in City' END AS Customer_Status
FROM SALESPEOPLE;

-- 83. Append strings to the selected fields, indicating weather or not a given salesperson was matched to a customer in his city.
SELECT CONCAT(SNAME, ' - ', CASE WHEN CITY IN (SELECT DISTINCT CITY FROM CUST) THEN 'Matched' ELSE 'Not Matched' END) AS Salesperson_Status
FROM SALESPEOPLE;

-- 84. Create a union of two queries that shows the names, cities and ratings of all customers. Those with a rating of 200 or greater will also have the words ‘High Rating’, while the others will have the words ‘Low Rating’.
SELECT CNAME, CITY, RATING, 'High Rating' AS Status FROM CUST WHERE RATING >= 200
UNION
SELECT CNAME, CITY, RATING, 'Low Rating' AS Status FROM CUST WHERE RATING < 200;

-- 85. Write command that produces the name and number of each salesperson and each customer with more than one current order. Put the result in alphabetical order.
SELECT SNAME AS Name, SNUM AS Number FROM SALESPEOPLE WHERE SNUM IN (SELECT SNUM FROM ORDERS GROUP BY SNUM HAVING COUNT(*) > 1)
UNION
SELECT CNAME AS Name, CNUM AS Number FROM CUST WHERE CNUM IN (SELECT CNUM FROM ORDERS GROUP BY CNUM HAVING COUNT(*) > 1)
ORDER BY Name;

-- 86. Form a union of three queries. Have the first select the snums of all salespeople in San Jose, then second the cnums of all customers in San Jose and the third the onums of all orders on Oct. 3. Retain duplicates between the last two queries, but eliminates any redundancies between either of them and the first.
SELECT SNUM AS ID FROM SALESPEOPLE WHERE CITY = 'San Jose'
UNION
(SELECT CNUM AS ID FROM CUST WHERE CITY = 'San Jose'
 UNION ALL
 SELECT ONUM AS ID FROM ORDERS WHERE ODATE = '03-OCT-94');

-- 87. Produce all the salespeople in London who had at least one customer there.
SELECT * FROM SALESPEOPLE 
WHERE CITY = 'London' AND SNUM IN (SELECT DISTINCT SNUM FROM CUST WHERE CITY = 'London');

-- 88. Produce all the salespeople in London who did not have customers there.
SELECT * FROM SALESPEOPLE 
WHERE CITY = 'London' AND SNUM NOT IN (SELECT DISTINCT SNUM FROM CUST WHERE CITY = 'London');

-- 89. We want to see salespeople matched to their customers without excluding those salespeople who were not currently assigned to any customers. (Using OUTER JOIN and UNION)
SELECT S.SNAME, C.CNAME 
FROM SALESPEOPLE S 
LEFT JOIN CUST C ON S.SNUM = C.SNUM
UNION
SELECT S.SNAME, C.CNAME 
FROM SALESPEOPLE S 
RIGHT JOIN CUST C ON S.SNUM = C.SNUM;