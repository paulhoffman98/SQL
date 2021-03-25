use glassesshipping;

/* Question 1*/
SELECT ShopName, EmployeeNum, AnnualRevenue
FROM shops
ORDER BY ShopName asc;

/*Question 2*/
SELECT Location, count(ShopName), sum(AnnualRevenue)
FROM shops
GROUP BY Location
ORDER  BY sum(AnnualRevenue) desc;

/*Question 3*/
SELECT ShopName, Format, Location, AnnualRevenue
FROM shops
WHERE Format = 'Booth' AND AnnualRevenue > 1000000;

/*Question 4*/
SELECT ZipCode, count(OrderID), sum(PricePaid)
FROM orders
WHERE ZipCode is NOT NULL
GROUP BY ZipCode
ORDER BY count(OrderID) desc; 

/*Question 5*/
SELECT DISTINCT ShopID, ProductID, PricePaid
FROM orders
ORDER BY ShopID desc, PricePaid asc;

/*Question 6*/
SELECT ZipCode, count(OrderID)
FROM orders
WHERE Hour(OrderDate) > 17
GROUP BY ZipCode
ORDER BY count(OrderID) desc;

/*Question 7*/
SELECT Month(Founded), count(Month(Founded))
FROM shops
GROUP BY Month(Founded)
ORDER BY count(Month(Founded)) desc;

/*Question 8*/
SELECT OrderDate, time_to_sec(OrderDate)
FROM orders
WHERE OrderDate is NOT NULL;

/*Question 9*/
SELECT ProductName, ProductLine, ListPrice, Month(OrderDate)
FROM products
INNER  JOIN orders ON products.ProductID = orders.ProductID
WHERE ProductLine = 'Bi Focal' AND Month(OrderDate) = 3;

/*Question 10*/
SELECT EmployeeNum, AVG(AnnualRevenue)
FROM shops
WHERE EmployeeNum is NOT NULL
GROUP BY EmployeeNum
ORDER BY AVG(AnnualRevenue) desc;

/*Question 11*/
SELECT OriginCountry, AVG(PricePaid)
FROM products
INNER JOIN orders ON products.ProductID = orders.ProductID
WHERE OriginCountry is NOT NULL
GROUP BY OriginCountry
ORDER BY AVG(PricePaid);

/*Question 12*/
SELECT ProductName, (ListPrice - PricePaid)
FROM orders
INNER JOIN products ON orders.ProductID = products.ProductID;

/*Question 13*/
SELECT YEAR(OrderDate), count(OrderID), AVG(PricePaid)
FROM orders
WHERE YEAR(OrderDate) is NOT NULL
GROUP BY YEAR(OrderDate);

/*Question 14*/
/*2 Hours*/
