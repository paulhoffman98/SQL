use lyft;

/*1) Find the number of requests per gender per car year. 
Are men more interested in newer cars than older cars?*/
SELECT Gender, Year, count(requestID)
FROM Requests
JOIN drivers using(DriverName)
Join customers using(CustomerName)
GROUP BY Gender, Year;

/*2) Find the oldest customer/s. List the name and age. Hint: You may use all.*/
SELECT CustomerName, Age
FROM customers
WHERE age >= all
	(select age
    from customers);

/*3) Among the customers who have requested a ride to the Park, how many have a name starting
with character ‘S’?*/
SELECT Destination, count(distinct(CustomerName))
FROM requests
WHERE Destination = "Park" 
and CustomerName LIKE "S%";


/*4) Find all customers except the youngest ones.*/
SELECT CustomerName, Age
FROM customers
WHERE age > any
	(select age
    from customers)
order by age;


/*5) Find the driver who, by average, has driven more than average ride distance of all Clayton
residents.*/

SELECT driverName
from requests
GROUP BY driverName
HAving avg(distance) > 
	(select avg(distance) 
	From requests  join customers  using(customerName)
	where  address = "Clayton");
    
/*6) Find the number of requests per destination per gender. Select only destinations that have the
character ‘t’ in them.*/
SELECT Destination, Gender, count(RequestID)
FROM requests
JOIN customers using(CustomerName)
WHERE customerName LIKE "%t%"
GROUP BY Destination, Gender;

/*7) List the customers who had a ride to WashU in a silver car. 
Among them, who is the youngest? Use a subquery in the WHERE clause in your answer.*/
SELECT CustomerName, Age
FROM customers 
where customerName IN
	(SELECT  CustomerName 
    FROM  drivers join requests
    using(driverName)
    where destination = "WashU" and Color = "Silver");

/*8) List the customers who are younger than the average age. 
Also, list customers who have driven less than average mile of all trips 
in any individual ride. Show all customers in one try.*/
SELECT customerName
FROM customers
where age  < 
	(select avg(age)
    from customers)
UNION  
SELECT customerName
FROM customers JOIN requests
USING(customerName)
GROUP BY customerName
having max(distance) <
	(SELECT avg(Distance)
    FROM requests);



/*9) Find the customers who have more than the average number of requests in the current week. 
List the name and number of current week rides.*/
SELECT customerName, count(RequestID)
FROM customers 
JOIN requests using(customerName)
GROUP BY customerName
HAVING count(requestID) >	
    (SELECT AVG(AvgRequest) FROM  	
		(SELECT customerName, count(requestID) as AvgRequest
		from customers
		JOIN requests using(customerName)
		GROUP BY customerName) as TotalRequestTable);

/*10) Among those customers in the previous query, 
who is not living in ‘St. Louis’? (Hint: Use NOT IN)*/
SELECT customerName, count(RequestID)
FROM requests 
WHERE CustomerName NOT IN
	(SELECT customerName
    FROM customers
	WHERE address = "St. Louis")
GROUP BY customerName
HAVING count(requestID) >	
    (SELECT AVG(AvgRequest) FROM  	
		(SELECT customerName, count(requestID) as AvgRequest
		from customers
		JOIN requests using(customerName)
		GROUP BY customerName) as TotalRequestTable);


/*11) Please add a new column to the requests table in order to identify 
the distance of rides and call it Trip. Please tag rides based on the following condition:
If the distance is larger than 20, tag it as “Long”.
If the distance is between and including 15 and 20, tag it as “Upper Medium”.
If the distance is between and including 10 and 14, tag it as “Medium”.
If the distance is between and including 5 and 9, tag it as “Lower Medium”.
If the distance is less than 5 tag it as “Short”.
if no information is available for distance, please tag it as “No Information”*/
ALTER TABLE requests
ADD Trip varchar(30) AFTER Distance;

UPDATE requests JOIN
	(SELECT requestID,
    CASE
		WHEN Distance > 20 THEN 'Long'
        WHEN Distance <= 20 and Distance >=15 THEN "Upper Medium"
        WHEN Distance <= 14 and Distance >=10 THEN "Medium"
        WHEN Distance <= 9 and Distance >= 9 THEN "Lower Medium"
        WHEN Distance <5 THEN "Short"
	  ELSE 'No Information'
	END AS Trip
    FROM requests)
    AS temp_table
	USING(requestID)
    SET requests.Trip = temp_table.Trip;
    

/*12) Please remove the column that you added recently (Trip).*/
ALTER TABLE requests
DROP column Trip;

select * from requests;

/*13) Find the unique model of the cars that have been requested on Tuesday. Try this with exist
operand.*/

SELECT distinct Model
from drivers
WHERE exists
	(select customerName
    from requests
    where requests.DriverName = drivers.DriverName and DayofWeek = "Tuesday");