use glassesshipping;

/*Q1*/
SELECT ShopID, ShopName, count(OrderID)
FROM orders
left join shops using(shopid)
GROUP BY ShopID
ORDER BY count(OrderID) desc;

/*Q2*/
SELECT ProductName, Retirement
FROM products
Left join orders using(ProductID)
WHERE Retirement < "2020-01-01" or Retirement > "2020-12-31" and Retirement is not null
;

/*Q3*/
SELECT ProductName, avg(ListPrice-PricePaid) as DiscountAvg
FROM orders
LEFT JOIN products using(ProductID)    
GROUP BY ProductName
Order BY DiscountAvg;

/*Q4*/
SELECT ProductName, count(OrderID)
FROM orders
LEFT JOIN products using(ProductID)
WHERE Quantity > 700
GROUP BY ProductName
Having count(OrderID) > 2;

/*Q5*/
SELECT ProductName, count(OrderID)
FROM orders
LEFT JOIN products using(ProductID)
GROUP BY ProductName;

/*Q6*/
SELECT ShopName, OrderDate, Founded
FROM shops
LEFT JOIN orders using(ShopID)
WHERE OrderDate >= "2012-08-01" and OrderDate <= "2012-08-31"
ORDER BY Founded;

/*Q7*/
SELECT OrderID, ZipCode, ProductName, ProductLine
FROM orders
LEFT JOIN products using(ProductID);

/*Q8*/
SELECT ProductName, count(OrderID) as AmountOrdered
FROM orders
LEFT JOIN products USING(ProductID)
WHERE unix_timestamp(OrderDate) > 12
GROUP BY ProductName;

/*Q9*/
SELECT ShopName, sum(PricePaid) as TotalRevenue, count(OrderID) as Orders
FROM  shops
LEFT JOIN orders using(ShopID)
GROUP BY ShopName
ORDER BY count(OrderID) desc;

/*Q10*/
SELECT ShopName, avg(ListPrice-PricePaid) as DiscountAvg
FROM shops
LEFT JOIN orders using(ShopID)
JOIN products using(ProductID)
GROUP BY ShopName
HAVING DiscountAvg > 40
Order BY DiscountAvg;

/*Q11*/
SELECT DISTINCT s1.Format, s2.Format, s1.ShopName, s2.ShopName, s1.Founded, s2.Founded
FROM shops as s1
JOIN shops as s2 using(Format)
WHERE s1.ShopName < s2.ShopName and s1.Founded > "1985-01-01" and s2.Founded > "1985-01-01"
ORDER BY s1.ShopName, s2.ShopName;

/*Q12*/
SELECT ShopName, Min(Format) as StoreFormat, avg(ListPrice-PricePaid) as DiscountAvg
FROM shops
LEFT JOIN orders using(ShopID)
JOIN products using(ProductID)
GROUP BY ShopName
ORDER BY DiscountAvg desc
Limit 1;

/*Q13*/
SELECT ProductID, ProductName, Introduced, Retirement, datediff(Retirement,Introduced) as Lifetime
FROM products
WHERE Introduced is NOT NULL 
AND Retirement is NOT NULL
Order BY Lifetime desc
Limit 1;

