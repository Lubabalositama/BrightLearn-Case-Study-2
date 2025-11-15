-- Viewing all columns to have full understanding of the dataset
SELECT *
FROM CASESTUDY2.DEALERSHIP.CARSALES;

-- Detailed viewing of the different car makes
SELECT DISTINCT (MAKE) AS CAR_MAKE,
       COUNT (*) NUMBER_OF_CARS
FROM CASESTUDY2.DEALERSHIP.CARSALES
GROUP BY CAR_MAKE;

-- Viewing the different types of transmissions
SELECT DISTINCT (TRANSMISSION)
FROM CASESTUDY2.DEALERSHIP.CARSALES;
-- Note to self: When working out the actual code remember to not include the 'Null' and 'Sedan' transmissions 

-- Viewing the different car body types
SELECT DISTINCT (BODY)
FROM CASESTUDY2.DEALERSHIP.CARSALES;

-- Wanting to find out the best condtion
SELECT MAX(CONDITION)
FROM CASESTUDY2.DEALERSHIP.CARSALES;

-- Wanting to find out the least condition 
SELECT MIN(CONDITION)
FROM CASESTUDY2.DEALERSHIP.CARSALES;

-- Wanting to find the mid-point between best condition and least condition 
SELECT AVG(CONDITION) AS MID_CAR_CONDITION
FROM CASESTUDY2.DEALERSHIP.CARSALES;

-- Viewing the different color cars offered
SELECT DISTINCT (COLOR)
FROM CASESTUDY2.DEALERSHIP.CARSALES;

-- Viewing the different color interiors of the cars sold
SELECT DISTINCT (INTERIOR)
FROM CASESTUDY2.DEALERSHIP.CARSALES;

-- Wanting to find out the highest amount of km's a car has been sold at 
SELECT MAX(ODOMETER)
FROM CASESTUDY2.DEALERSHIP.CARSALES;

-- Wanting to find out the least amount of km's a car has been sold at
SELECT MIN(ODOMETER)
FROM CASESTUDY2.DEALERSHIP.CARSALES;

-- Wanting to find out the differences between the MMR and the Selling Price of each car sold
SELECT MAKE,
       MODEL,
       MMR,
       SELLINGPRICE,
       SUM(MMR-SELLINGPRICE) AS PROFIT_AND_LOSS_MARGINS
FROM CASESTUDY2.DEALERSHIP.CARSALES;
GROUP BY ALL;

-- Viewing the closing time of the dealership
SELECT MAX(SALEDATE)
FROM CASESTUDY2.DEALERSHIP.CARSALES;

-- Viewing the opening time of the dealership 
SELECT MIN(SALEDATE)
FROM CASESTUDY2.DEALERSHIP.CARSALES;
-- Note to self: Rememeber to exclude 'null times' and 'dates' that are not in the YYYY/MM/DD format, as this will cause the data to be skew

-- Viewing the amount od distinct sellers
SELECT DISTINCT (SELLER)
FROM CASESTUDY2.DEALERSHIP.CARSALES;

------------------------------------------------------------------------------------------------
SELECT 
    YEAR,
    MAKE,
    MODEL,
    TRIM,
    BODY,
    TRANSMISSION,
    STATE,
    CONDITION,
    CASE 
    WHEN condition BETWEEN 1 AND 10 THEN 'Poor'
    WHEN condition BETWEEN 11 AND 20 THEN 'Fair'
    WHEN condition BETWEEN 21 AND 30 THEN 'Good'
    WHEN condition BETWEEN 31 AND 50 THEN 'Excellent'
    ELSE 'Not Provided'
    END AS car_state,
    ODOMETER,
    CASE 
    WHEN ODOMETER < 449999 THEN 'Low Mileage'
    WHEN ODOMETER BETWEEN 450000 AND 889999 THEN 'Average Mileage'
    WHEN ODOMETER >= 900000 THEN 'High Mileage'
    ELSE 'Not Provided'
    END AS mileage_status,
    COLOR,
    INTERIOR,
    SELLER,
    MMR,
    SELLINGPRICE,
    (SELLINGPRICE - MMR) AS profit_and_loss_margin,
    ROUND( (SELLINGPRICE - MMR) / NULLIF(SELLINGPRICE,0) * 100 , 2 ) AS profit_and_loss_percentage,
    SUM(profit_and_loss_margin) as revenue,
    -- Convert VARCHAR → TIMESTAMP correctly
    TO_TIMESTAMP(SALEDATE, 'DY MON DD YYYY HH24:MI:SS') AS sale_timestamp,
    -- Extract date
    TO_DATE(sale_timestamp) AS sale_date,
    -- Day name
    DAYNAME(sale_timestamp) AS day_of_week,
    CASE
    WHEN day_of_week IN ('Sat','Sun') THEN 'Weekend'
    ELSE 'Weekday'
    END AS time_of_the_week,
    MONTHNAME(sale_timestamp) AS month_of_year,
    CASE
    WHEN month_of_year IN ('Dec','Jan','Feb') THEN 'Summer'
    WHEN month_of_year IN ('Mar', 'Apr', 'May') THEN 'Autumn'
    WHEN month_of_year IN ('Jun', 'Jul', 'Aug') THEN 'Winter'
    WHEN month_of_year IN ('Sep', 'Oct', 'Nov') THEN 'Spring'
    END AS season_of_the_year,
    -- Hour
    HOUR(sale_timestamp) AS hour_of_the_day,
    CASE 
    WHEN hour_of_the_day BETWEEN 0 AND 11 THEN 'Morning'
    WHEN hour_of_the_day BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
    END AS time_of_day,
FROM CASESTUDY2.DEALERSHIP.CARSALES
GROUP BY ALL;
