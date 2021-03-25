use lyft;

/*1) Identify all customer that haven’t had any requests so far? 
How many customers haven’t had any requests?*/

SELECT CustomerName, RequestID
FROM customers 
LEFT JOIN requests USING(CustomerName)
WHERE RequestID is NULL;

/*2) How many trips from St. Louis in the current week have been made? (Numeric answer)*/

SELECT sum(pasttrips)
from customers
where address = "St. Louis";

/*3) Among St. Louis residents, one customer made more trips on Fridays this week than 
all other customers (considering only current trips). Who is he/she?*/

SELECT CustomerName, DayOfWeek, address, count((customerName)) 
FROM requests RIGHT JOIN customers using(customerName)
Where DayOfWeek = "Friday" and address = "St. Louis"
Group by CustomerName
ORDER  BY CustomerName;

/*4) List all trips to the Zoo. Looking at the results, on which day of the 
week did people make more trips to the Zoo? Also, it seems that people from 
one area are more interested than people from other areas to go to the Zoo. 
What is the area?*/

SELECT Destination, DayOfWeek, address
FROM  requests 
RIGHT JOIN customers using(CustomerName)
WHERE Destination = "Zoo";

/*5) What is the farthest distance that a Lyft customer traveled in a 
single trip? What was the origin? What was the destination? 
(Please split answers by “,”, For example: “a, b, c”)*/

SELECT Distance, customerName, address, destination
from requests 
RIGHT join customers using(CustomerName)
order by distance desc;

/*6) Which driver travelled farthest, in a single trip, to reach the ‘Arch’?*/

SELECT Distance, DriverName, Destination
FROM requests
WHERE Destination = 'Arch'
Order BY Distance desc;

/*7) Find all destinations that have more than 2 requests in evenings.*/

SELECT Destination, count(RequestID)
FROM requests
WHERE TimeOfDay = 'evening' 
Group By Destination
having count(RequestID) > 2;

/*8) Find a table that contains customer name, customer age, driver name, 
destination, and the model of the car. Do not report rows with null values.*/

SELECT CustomerName, Age, DriverName, Destination, Model
FROM customers
join requests using (customerName)
	join drivers using (driverName)
where customerName is not null
and age is not null
and driverName is not null
and destination is not null
and model is not null;

/*9) Find the average of distances for each time of the day.*/

SELECT TimeOfDay, avg(Distance)
FROM requests
Group  BY TimeOfDay
Order  by avg(Distance) desc;

/*10) Find all pairs of customer that have the same address. 
Include the address in your answer.*/
 
 SELECT DISTINCT c1.CustomerName, c2.CustomerName, address
 FROM Customers as c1 
 join customers as c2 using (address)
 where c1.customername < c2.customerName
 Order By c1.customerName, c2.customerName, Address;