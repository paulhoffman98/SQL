USE lyft;

/*Question 1*/
SELECT DriverName, Color, Year
FROM drivers;

/*Question 2*/
SELECT DriverName, CustomerName, DayOfWeek
FROM requests
WHERE DayOfWeek = 'Friday'
ORDER BY CustomerName;

/*Question 3*/
SELECT Destination, DayOfWeek, TimeOfDay
FROM requests
WHERE (DayOfWeek = 'Saturday' OR DayOfWeek = 'Sunday')  AND TimeOfDay = 'evening'
ORDER BY RequestID;
 
/*Question 4*/
SELECT TimeOfDay, DayOfWeek, count(RequestID), sum(Distance)
FROM requests
GROUP BY TimeOfDay, DayOfWeek
Order BY DayOfWeek;

/*Question 5*/
SELECT Color, avg(Year)
FROM drivers
GROUP BY Color
ORDER BY avg(Year) desc;

/*Question 6*/
SELECT DISTINCT Destination
FROM requests
WHERE Destination is NOT NULL
ORDER BY Destination desc;

/*Question 7*/
SELECT Address, CustomerName
FROM customers
WHERE Address IS NULL;

/*Question 8*/
SELECT DayOfWeek, count(requestID)
FROM requests
GROUP BY DayOfWeek;

/*Question 10*/
SELECT Age, count(PastTrips)
FROM customers
WHERE Age BETWEEN '30' AND '35'
GROUP BY Age
ORDER BY Age;

/*Question 11*/
select customername, requestid, color, destination, distance, model
from drivers 
inner join requests on drivers.drivername=requests.drivername
where color='white'
order by customername desc;

/*Question 12*/
SELECT customers.CustomerName, Gender, Address, Destination
FROM customers INNER JOIN requests
USING(customerName)
WHERE Destination = 'Stadium';

/*Question 13*/
SELECT customers.CustomerName, Address, COUNT(requests.RequestID) AS RequestID
FROM Customers JOIN requests
ON Customers.CustomerName = requests.CustomerName
GROUP BY CustomerName
ORDER BY RequestID;

/*Question 14*/


