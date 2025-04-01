SELECT * FROM Payment 
WHERE tip > 20.00;

SELECT experience_years, AVG(rating) as avg_rating
FROM Driver
GROUP BY experience_years
ORDER BY experience_years;

SELECT driver_id, full_name, rating, experience_years
FROM Driver
GROUP BY driver_id
HAVING rating > 4.5 AND experience_years >= 5;

SELECT d.drive_id, p.fare, p.tip, 
       (p.fare + COALESCE(p.tip, 0)) as total_cost
FROM Payment p
JOIN Drive d ON p.drive_id = d.drive_id
ORDER BY total_cost DESC
LIMIT 10;

SELECT d.drive_id, 
       dr.full_name as driver_name,
       p.full_name as passenger_name,
       d.start_location, d.final_location
FROM Drive d
INNER JOIN Driver dr ON d.driver_id = dr.driver_id
INNER JOIN Person p ON d.person_id = p.person_id;

SELECT dr.full_name, COUNT(d.drive_id) as rides_count
FROM Driver dr
LEFT JOIN Drive d ON dr.driver_id = d.driver_id
GROUP BY dr.driver_id;

SELECT * FROM Person p
WHERE EXISTS (
    SELECT pm.drive_id FROM Payment pm
    JOIN Drive d ON pm.drive_id = d.drive_id
    WHERE d.person_id = p.person_id AND pm.tip > 0
);

SELECT * FROM Drive
WHERE person_id IN (
    SELECT person_id FROM Person WHERE have_premium = TRUE
);

SELECT * FROM Person
ORDER BY full_name
LIMIT 10 OFFSET 5;

SELECT payment_id, drive_id, fare,
    SUM(fare) OVER (ORDER BY payment_id) AS cumulative_income
FROM Payment;

SELECT 
    driver_id, rating,
    AVG(rating) OVER (PARTITION BY driver_id) AS avg_rating_per_driver,
    date
FROM Driver_Rating_History;