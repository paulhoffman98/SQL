use lyft;

/*Q1*/
SELECT (DriverName), count((RequestID))
FROM drivers
Left JOIN requests using(DriverName)
GROUP BY DriverName
HAVING count((RequestID)) = 0;

/*Q2*/
SELECT DayOfWeek, count(requestID)
from requests
group by dayofweek
order by count(requestID);

/*Q3*/
SELECT CustomerName, Gender, Color
from customers
left join requests using(CustomerName)
	right join drivers using(DriverName)
WHERE Color = "Black"
group by customerName;

/*Q4*/
SELECT TimeOfDay, Destination, avg(Distance)
FROM requests
WHERE TimeOfDay = "Evening"
GROUP By destination
HAving avg(distance) > 8
order by avg(Distance) desc;

/*Q5*/
select drivername
from drivers
	where year = 
    (select min(year)
    from drivers);
    
/*Q6*/
SELECT driverName, count(requestID) from requests
RIGHT JOIN 
	(select drivername
	from drivers
	where year = 
		(select min(year)
		from drivers) ) as OldCar
USING(driverName)
Group BY driverName;

/*Q7*/
SELECT Color, count(RequestID), count(Color), avg(RequestID), avg(distance)
from drivers
join requests using(driverName)
GROUP by color
order by count(color) desc;


/*Q8*/
SELECT customerName, PastTrips, 
count(RequestID), count(RequestID) + IF(PastTrips is Null, 0, PastTrips) as TotalTrips
from customers
left join requests using(customerName)
Group by CustomerName
Order BY TotalTrips Limit 12;

/*Q9*/
SELECT DISTINCT customerName, Destination
FROM requests 
JOIN
	(SELECT customerName, age
	FROM customers
	WHERE  age >
		(SELECT avg(Age) FROM customers)) as OldCust
using(customerName);


/*Q10*/
SELECT DayOfWeek, TimeOfDay, count(RequestID)
FROM requests
GROUP BY DayOfWeek, TimeOfDay
HAVING count(RequestID) > 5;

/*Q11*/
SELECT Destination, avg(Age)
FROM requests
JOIN customers using(CustomerName)
GROUP BY Destination
Order By avg(Age) desc;

/*Q12*/
SELECT Destination, count(RequestID)
FROM requests
GROUP BY Destination
HAVING count(RequestID) > 4
ORDER BY count(RequestID) desc;

/*Q13*/
SELECT RequestID, DriverName, CustomerName, Distance,  Destination
FROM requests
WHERE Distance >
	(SELECT avg(Distance)
    from requests )
order By distance limit 12;


/*Q14*/

	