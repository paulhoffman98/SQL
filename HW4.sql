use glassesshipping;

/*1) From orders table, list orderid, shopid, productid, and 
price paid for each order. Please consider the list price of 
products for orders with no price paid.*/

SELECT OrderID, ShopID, ProductID, PricePaid, ListPrice
FROM orders
JOIN products using(ProductID)
WHERE PricePaid is Null;

/*2) Find the shops with more than 3 not-local orders 
(orders where zipcode is not equal to store location).*/

SELECT ShopName, count(OrderID)
FROM shops
JOIN orders using(ShopID)
WHERE Location != ZipCode
GROUP BY ShopName
HAVING count(OrderID) >= 3
Order BY ShopName;

/*3) Find the booth shops that have received more than 4 orders. 
List the shop name, number of orders, and the average price paid of orders.*/

SELECT ShopName, count(OrderID), avg(PricePaid)
From Shops
Join  Orders using(ShopID)
where Format = "Booth"
Group By ShopName
Having count(OrderID) > 4;

/*4) There are a few records in the shops table where we do not have the 
employee number. To fill them up, we would like to use the average of employee number 
for each shop format. For example, to fill the null employee numbers in booths, 
we use the average of employee number of all booths. 
Please list the average employee number, and total nulls in employee number column for
each store type. Hint: You may use ROUND() function to round the average result.*/

SELECT Format, ROUND(avg(EmployeeNum)), count(EmployeeNum)
from shops
GROUP by Format; 

/*5) List the store format, total number of orders, and average annual revenue per store except
department stores.*/

SELECT Format, count(OrderId), avg(AnnualRevenue)
from Shops
Join orders using(ShopID)
WHERE format != "Department Store"
Group By Format;

/*6) Find the number of unique product types that have been purchased from each store. Please
consider only booth and standalone stores.*/

SELECT ShopName, count(distinct(ProductID))
From products
Left Join orders using(ProductID)
RIGHT JOIN shops using(ShopID)
WHERE Format = "Booth" or "Stand Alone"
GROUP BY ShopName;

/*7) Find the average price paid for each product that has been purchased from stores 
with less than (not including) 3 orders. List the product id, product name, 
average price paid, and list price of product. 
Note: Consider the price paid as 0 for not available price paid entries.*/

SELECT ProductID, ProductName, ListPrice, avg(PricePaid)
	From Products Left Join Orders using(ProductId)
		Right Join
		(SELECT ShopID
		from shops
		Join orders using(ShopID)
		Group By ShopID
		Having count(orderId) < 3) as Shop
    Using(ShopID)
    Group By ProductID;

    

/*8) Among the products with more than average quantity 
(if quantity is not available, consider it as 50), find those 
that have been purchased from stores in location 93000. 
List the product name, and location of the store.*/
SELECT ProductName, Location
FROM Products
LEFT JOIN orders using(ProductID)
Right JOIN shops using(ShopID)
Where Quantity >
    (SELECT avg(if(Quantity  is Null, 50, Quantity))
	From products) 
AND Location = "93000"; 
    
/*9) Find the products that have been ordered more than the average 
number of orders of all products. List the product name, product id, 
and number of times it has been ordered.*/
SELECT ProductName, ProductID, count(OrderID)
FROM Products
LEFT JOIN orders using(ProductID)
Group By ProductID, ProductName
Having count(OrderID) >
		(SELECT avg(counter) from
		(SELECT count(OrderID) as counter
        FROM orders
        GROUP by ProductID) as countOrder);
        




/*10) Find the products that are priced for more than the average 
price list of all products. How many stores are carrying them?*/
SELECT ProductName, count(ShopID)
FROM Products
Left JOIN Orders using(ProductID)
Right Join Shops using(ShopID)
WHERE ListPrice >
	(SELECT avg(ListPrice)
	FROM products)
GROUP BY ProductID;

/*11) Find the number of unique products that has been purchased 
from shops with more than average annual revenue. Please assume the 
annual revenue with null values as $500,000. List the shopid, shopname, 
and number of unique products that has been purchased.*/

SELECT shopID, ShopName, count(DISTINCT(ProductID))
FROM shops
LEFT JOIN orders using(ShopID)
RIGHT JOIN products using(ProductID)
WHERE AnnualRevenue >
	(SELECT avg(AnnualRevenue)
	FROM shops)
GROUP BY shopID, ShopName;

/*12) Find the products that customers have been paying at least $100 for them.
 How many unique stores are carrying each? List the product name, product id, 
 minimum price paid, and number of unique stores carrying them.*/
 
 SELECT ProductName, ProductID, Min(PricePaid), count(ShopID)
 FROM Products LEFT JOIN Orders using(ProductID)
 RIGHT JOIN Shops using(ShopID)
 GROUP BY ProductName, ProductID
 HAVING Min(PricePaid) >= 100;
 
 /*13) List the average list price, average price paid, and number of 
 orders per introduced year of products. If a product is not ordered, 
 report the average price paid as 0.*/
 
 SELECT Year(Introduced), avg(ListPrice), avg(IF(PricePaid is NULL, 0, PricePaid)) , count(OrderID)
 FROM  orders
 Join products using(ProductID)
 GROUP BY Year(Introduced);
 
 /*14) How much time did you spend on this homework?*/
 /* 2 hours and half*/
 