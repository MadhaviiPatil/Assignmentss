USE cityyy;
SELECT * FROM data;

-- 1. Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
SELECT *FROM data WHERE population > 100000 AND countrycode = 'USA';
        
-- 2. Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.

SELECT name FROM data WHERE population > 120000 AND countrycode = 'USA';

-- 3. Query all columns (attributes) for every row in the CITY table

select * from data;

-- 4. Query all columns for a city in CITY with the ID 1661.
select * from data where id = 1661; 

-- 5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN 
select* from data where countrycode="JPN";

-- 6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
select name from data where countrycode = "JPN";

-- 7. Query a list of CITY and STATE from the STATION table.

 select id, city, state from station;

-- 8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

select distinct(city) from station where id%2 = 0;

-- 9. Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
select count(city)-count(distinct(city)) from station;

-- 10. Query the two cities in STATION with the shortest and longest CITY names, as well as their 
-- respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
-- largest city, choose the one that comes first when ordered alphabetically.

select* from station;
SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY), CITY
LIMIT 1;

SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY
LIMIT 1;

-- 11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.

SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[aeiouAEIOU]';


-- 12. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates

SELECT DISTINCT CITY
FROM STATION
WHERE CITY not REGEXP '^[aeiouAEIOU]';

-- 13. Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates

SELECT DISTINCT CITY
FROM STATION
WHERE CITY not REGEXP '[aeiouAEIOU]$';

-- 14. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[aeiouAEIOU]';

-- 15. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.

SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '^[aeiouAEIOU]' OR CITY NOT REGEXP '[aeiouAEIOU]$';

-- 16. Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.

SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '^[aeiouAEIOU]' and CITY NOT REGEXP '[aeiouAEIOU]$';


-- 17. Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
-- between 2019-01-01 and 2019-03-31 inclusive.
-- Return the result table in any order.
select p.product_id, p.product_name from product p join sales s on p.product_id=s.product_id where sale_date between 2019-01-01 and 2019-03-31;

-- 18. Write an SQL query to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.
-- The query result format is in the following example.
Select author_id as id from views where author_id = viewer_id;

-- 19. If the customer's preferred delivery date is the same as the order date, then the order is called
-- immediately; otherwise, it is called scheduled.
-- Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.
select delivery_id  immediate_percentage from delivery table where order_date = customer_pref_delivery_date 

Select ROUND((SUM(Case When order_date = preferred_delivery_date Then 1 else 0 end) / COUNT(*)) * 100,
        2
    ) AS immediate_order_percentage From delivery;
    
    
-- 20. Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
-- Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.

SELECT
    AdID,
    COUNT(CASE WHEN Action = 'Clicked' THEN 1 ELSE NULL END) AS Clicks
FROM
    AdInteractions
GROUP BY
    AdID;

-- Calculate the number of impressions (views) for each ad
SELECT
    AdID,
    COUNT(CASE WHEN Action = 'Viewed' THEN 1 ELSE NULL END) AS Impressions
FROM
    AdInteractions
GROUP BY
    AdID;

-- 21 Write an SQL query to find the team size of each of the employees.
-- Return result table in any order.

SELECT
    E.employee_id,
    E.team_id,
    T.team_size
FROM
    Employees E
LEFT JOIN
    Teams T
ON
    E.team_id = T.team_id;
    
-- 22. Write an SQL query to find the type of weather in each country for November 2019.
-- The type of weather is:
-- ● Cold if the average weather_state is less than or equal 15,
-- ● Hot if the average weather_state is greater than or equal to 25, and
-- ● Warm otherwise.
 
 WITH NovemberWeather AS (
    SELECT
        W.country_id,
        AVG(weather_state) AS avg_weather_state
    FROM
        Weather W
    WHERE
        EXTRACT(MONTH FROM day) = 11 -- Filter for November
        AND EXTRACT(YEAR FROM day) = 2019 -- Filter for the year 2019
    GROUP BY
        W.country_id
)

SELECT
    C.country_id,
    C.country_name,
    CASE
        WHEN NW.avg_weather_state <= 15 THEN 'Cold'
        WHEN NW.avg_weather_state >= 25 THEN 'Hot'
        ELSE 'Warm'
    END AS weather_type
FROM
    Countries C
LEFT JOIN
    NovemberWeather NW
ON
    C.country_id = NW.country_id;


-- 23. Write an SQL query to find the average selling price for each product. average_price should be
-- rounded to 2 decimal places.
-- Return the result table in any order.

SELECT
    us.product_id,
    ROUND(SUM(price * units) / SUM(units), 2) AS average_price
FROM
    UnitsSold us
JOIN
    Prices p
ON
    us.product_id = p.product_id
    AND us.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY
    us.product_id;
    
-- 24 Write an SQL query to report the first login date for each player.
-- Return the result table in any order.
SELECT
    player_id,
    MIN(login_date) AS first_login_date
FROM
    PlayerActivity
GROUP BY
    player_id;
    
    
 -- 25 Write an SQL query to report the device that is first logged in for each player. Return the result table in any order
 
 SELECT
    a.player_id,
    a.device_id AS first_logged_in_device
FROM
    Activity a
JOIN (
    SELECT
        player_id,
        MIN(event_date) AS first_login_date
    FROM
        Activity
    GROUP BY
        player_id
) AS sub
ON
    a.player_id = sub.player_id
    AND a.event_date = sub.first_login_date;

-- 26 Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount. Return result table in any order.

select product_name, unit from products p join orders o on p.product_id = o.product_id where unit>100 group by product_id

-- 27 Write an SQL query to find the users who have valid emails. A valid e-mail has a prefix name and a domain where:
-- ● The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
-- ● The domain is '@leetcode.com'.
select user_id,name,mail from users where mail regex "^[a-z]*@leetcode.com$";


-- 29 Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020. Return the result table in any order
select title from content c join TVprogeam tv on c.content_id=tv.content_id where program_date < 2020-07-01 and program_date>2020-05-31 and kids_content = "Y"

-- 30 Write an SQL query to report the distance travelled by each user. Return the result table ordered by travelled_distance in descending order, if two or more users
-- travelled the same distance, order them by their name in ascending order. The query result format is in the following example.

select name,sum(distance) travelled_distance from users u join rides r on u.id = r.user_id group by user_id, name order by travelled_distance desc, u.name asc


-- 31.Write an SQL query to find the npv of each query of the Queries table.
-- Return the result table in any order.
-- The query result format is in the following example.
select q.id ,q.year ,npv from queries q join NPV n on q.id = n.id and q.year = n.year;


-- 32 Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null. Return the result table in any order
select unique_id and name from employees e join employeeuni u on e.id = u.id;




-- 33 Write an SQL query to report the distance travelled by each user. Return the result table ordered by travelled_distance in descending order, if two or more users
-- travelled the same distance, order them by their name in ascending order.

  
  
-- 34 	Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount. Return result table in any order

-- 35 Write an SQL query to: ● Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
--  Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name


-- 36 Write an SQL query to report the distance travelled by each user. Return the result table ordered by travelled_distance in descending order, if two or more users
-- travelled the same distance, order them by their name in ascending order

-- 37 Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.

select unique_id , name from empyoyeeUNI EU join emplyoees E on  EU.id = E.id;


-- 38 Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exist. Return the result table in any order

select s.id, s.name from students s join departments d on s.department_id = d.id;

-- 39 Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.
-- Return the result table in any order


SELECT
    LEAST(from_id, to_id) AS person1,
    GREATEST(from_id, to_id) AS person2,
    COUNT(*) AS call_count,
    SUM(duration) AS total_duration
FROM
    Calls
GROUP BY
    person1,
    person2
HAVING
    person1 < person2;



-- 40 Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.

SELECT
    u.product_id,
    ROUND(SUM(p.price * u.units) / SUM(u.units), 2) AS average_price
FROM
    UnitsSold u
JOIN
    Prices p ON u.product_id = p.product_id
           AND u.purchase_date >= p.start_date
           AND u.purchase_date <= p.end_date
GROUP BY
    u.product_id;



