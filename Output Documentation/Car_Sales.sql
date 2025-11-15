SELECT      YEAR,
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
