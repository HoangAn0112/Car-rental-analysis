-- CREATE DATABASE car;

USE car;

-- CREATE TABLE car_admin (
-- 	car_id char(6) primary key,
--     fuel_type varchar(8),
--     owner_id varchar(15),
--     vehicle_make varchar(20),
--     vehicle_model varchar(20),
--     vehicle_type varchar(7),
--     vehicle_year int
-- 	);

-- CREATE TABLE car_performance (
-- 	car_id char(6) primary key,	
--     rating int,
--     renterTripsTaken int,
--     reviewCount int,
-- 	fee numeric(6,2)
--     );

-- CREATE TABLE car_location (
-- 	car_id char(6) primary key,	
--     location_country CHAR(2),
--     location_state CHAR(2),
--     location_city VARCHAR(40),
--     location_latitude numeric(9,6),
--     location_longitude numeric(9,6)
--     );

-- DROP TABLE car_performance;

-- alter table car.car_location
-- Modify COLUMN location_latitude numeric(9,6), 
-- Modify COLUMN location_longitude numeric(9,6);

-- LOAD DATA INFILE 'C:/Users/Admin/Documents/Porfolio/SQL Tableau/admin.csv' 
-- INTO TABLE car.car_admin
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY 'n'
-- IGNORE 1 ROWS;

-- FOREIGN KEYS

-- ALTER TABLE car_location
-- ADD CONSTRAINT location_fk
-- FOREIGN KEY (car_id)
-- REFERENCES car_admin(car_id);

-- ALTER TABLE car_performance
-- ADD CONSTRAINT performance_fk
-- FOREIGN KEY (car_id)
-- REFERENCES car_admin(car_id);

-- -- import csv by wizard -- --

-- CREATE INDEXS for Lookup --------------------------------------------------------------

-- CREATE INDEX fuel_idx
-- ON car_admin(fuel_type);

-- CREATE INDEX brand_idx
-- ON car_admin(vehicle_make);

-- CREATE INDEX model_idx
-- ON car_admin(vehicle_model);

-- CREATE INDEX state_idx
-- ON car_location(location_state);

-- CREATE INDEX city_idx
-- ON car_location(location_city);

-- CREATE INDEX rating_idx
-- ON car_performance(rating);

-- PRIMARY ANALYSES --------------------------------------------------------------------
-- 1. Which car type, brands and models are popular and in which cities?
-- 1.1. CAR TYPE UNKNOWN
-- SELECT
--     fuel_type,
--     COUNT(*) AS "num_cars"
-- FROM car_admin
-- GROUP BY fuel_type;

-- SELECT 
-- 	vehicle_make,
--     vehicle_model,
--      COUNT(*) AS "no_per_model"
--  FROM car_admin WHERE fuel_type = "nan"
--  GROUP BY vehicle_make, vehicle_model;

-- there's 75 cars has no type, 41 models include

-- SELECT fuel_type, vehicle_model, vehicle_make
-- FROM car_admin
-- WHERE vehicle_model = "Odyssey";

-- UPDATE car_admin
-- SET fuel_type = "GASOLINE"
-- WHERE fuel_type = "nan";
-- AND vehicle_make = "Tesla"
-- AND vehicle_model = "Model S"
-- LIMIT 1;

-- 1.2. MOST 10 MOST POPULAR BRAND/MODEL
-- SELECT COUNT(vehicle_model) as "no_car", 
-- 	vehicle_model
--  FROM car_admin
--  GROUP BY vehicle_model
--  ORDER BY no_car DESC
--  LIMIT 10;

-- 2. What is the typical fare of car rental in various major cities?
-- SELECT 
-- 	car_location.location_state,
-- 	AVG(car_performance.fee) AS average
-- FROM car.car_location JOIN car.car_performance
--       ON car_location.car_id = car_performance.car_id
-- GROUP By car_location.location_state
-- ORDER BY average DESC
-- LIMIT 10;

SELECT AVG(car_performance.fee*car_performance.renterTripsTaken) AS average
FROM car.car_location JOIN car.car_performance
ON car_location.car_id = car_performance.car_id
WHERE car_location.location_city = "Beverly Hills";

-- 3. The ratings on the sites have any co-relation?
-- SELECT *
-- FROM car_performance
-- WHERE renterTripsTaken < reviewCount

-- ANSWER: 2 supicious cars that have more reviews than booked trips










