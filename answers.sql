
----Display all properties in the database.
SELECT * FROM [Property24DB].[dbo].[property24_raw_data]

---Show only the CITY, PROVINCE, and PROPERTY_PRICE columns.
SELECT CITY,PROVINCE,PROPERTY_PRICE
FROM [Property24DB].[dbo].[property24_raw_data];

---List all distinct provinces in the table.
SELECT DISTINCT (PROVINCE)
FROM  [Property24DB].[dbo].[property24_raw_data];

----Find all properties located in Gauteng.
SELECT *
FROM [Property24DB].[dbo].[property24_raw_data]
WHERE PROVINCE = 'GAUTENG'

--Show properties priced under R1,500,000.
SELECT *
FROM [Property24DB].[dbo].[property24_raw_data]
WHERE PROPERTY_PRICE < 1500000

---- List properties with more than 3 bedrooms.
SELECT *
FROM [Property24DB].[dbo].[property24_raw_data]
WHERE BEDROOMS > 3

---Find properties with parking for at least 2 cars.
SELECT *
FROM [Property24DB].[dbo].[property24_raw_data]
WHERE PARKING >= 2

---Show properties where the monthly repayment is greater than R25,000.
SELECT *
FROM [Property24DB].[dbo].[property24_raw_data]
WHERE Monthly_Repayment > 25000

---Show all properties ordered by property price from highest to lowest.
SELECT *
FROM [Property24DB].[dbo].[property24_raw_data]
ORDER BY PROPERTY_PRICE DESC

---List properties ordered by floor size from smallest to largest.
SELECT *
FROM [Property24DB].[dbo].[property24_raw_data]
ORDER BY FLOOR_SIZE ASC

---Show Gauteng properties ordered by monthly repayment.
SELECT *
FROM [Property24DB].[dbo].[property24_raw_data]
WHERE PROVINCE = 'GAUTENG'
ORDER BY Monthly_Repayment 

---Find Western Cape properties priced below R3,000,000.
SELECT *
FROM [Property24DB].[dbo].[property24_raw_data]
WHERE PROVINCE = 'WESTERN CAPE' AND PROPERTY_PRICE < 3000000;

----Show KwaZulu-Natal properties with 3 or more bedrooms.
SELECT *
FROM [Property24DB].[dbo].[property24_raw_data]
WHERE PROVINCE = 'KWAZULU NATAL' AND BEDROOMS >= 3;

----Find properties in Limpopo or Free State ordered by property price.
SELECT *
FROM [Property24DB].[dbo].[property24_raw_data]
WHERE PROVINCE IN ('LIMPOPO', 'FREE STATE') 
ORDER BY PROPERTY_PRICE;

---Show the 10 most expensive properties.
SELECT TOP 10 *
FROM [Property24DB].[dbo].[property24_raw_data]
ORDER BY PROPERTY_PRICE DESC;

---- Show the 5 cheapest properties.
SELECT TOP 5 *
FROM [Property24DB].[dbo].[property24_raw_data]
ORDER BY PROPERTY_PRICE ASC;

---- Show the top 10 properties with the largest floor size.
SELECT TOP 10 *
FROM [Property24DB].[dbo].[property24_raw_data]
ORDER BY FLOOR_SIZE DESC;

---Which province appears to have the highest priced properties?
SELECT TOP 1 
    PROVINCE,         -- The name of the province
    AVG(CAST(PROPERTY_PRICE AS BIGINT)) AS AveragePropertyPrice -- Calculate the average price for each province and convert int into big int
FROM
    [Property24DB].[dbo].[property24_raw_data]  -- Replace with your actual table name
GROUP BY
   PROVINCE         -- Group results by province to get average per province
ORDER BY
    AveragePropertyPrice DESC; -- Order from highest average price to lowest


-----Which cities appear to have the most affordable housing?

SELECT TOP 10
    CITY,
    AVG(CAST(PROPERTY_PRICE AS BIGINT)) AS AveragePropertyPrice
FROM
    [Property24DB].[dbo].[property24_raw_data]
GROUP BY
    CITY
ORDER BY
    AveragePropertyPrice ASC;


----What minimum income is typically required for properties priced above R4,000,000?
SELECT TOP (1) [PROPERTY_ID]
      ,[COUNTRY]
      ,[PROVINCE]
      ,[CITY]
      ,[PROPERTY_PRICE]
      ,[BEDROOMS]
      ,[BATHROOMS]
      ,[PARKING]
      ,[FLOOR_SIZE]
      ,[Monthly_Repayment]
      ,[Total_Once_off_Costs]
      ,MIN([Min_Gross_Monthly_Income] ) AS MIN_REQUIRED
  FROM [Property24DB].[dbo].[property24_raw_data]
  WHERE PROPERTY_PRICE > 4000000 
  GROUP BY  [PROPERTY_ID]
      ,[COUNTRY]
      ,[PROVINCE]
      ,[CITY]
      ,[PROPERTY_PRICE]
      ,[BEDROOMS]
      ,[BATHROOMS]
      ,[PARKING]
      ,[FLOOR_SIZE]
      ,[Monthly_Repayment]
      ,[Total_Once_off_Costs]
ORDER BY MIN([Min_Gross_Monthly_Income] ) ASC

---SECTION 1 – COUNT Aggregations (10 Questions)

--1. How many total properties are in the database?
SELECT COUNT (PROPERTY_ID) as Number_of_Property
FROM [dbo].[property24_raw_data]


--2. How many properties are listed in each province?
SELECT DISTINCT (PROVINCE),
COUNT (PROPERTY_ID) AS Property_per_Province
FROM [dbo].[property24_raw_data]
GROUP BY PROVINCE


---3. How many properties are listed in each city?
SELECT DISTINCT (CITY),
COUNT (PROPERTY_ID) AS Property_per_City
FROM [dbo].[property24_raw_data]
GROUP BY CITY


--4. How many properties have more than 2 bedrooms?
SELECT COUNT (PROPERTY_ID) AS Property_with_more_than_2_Bedrooms
FROM [dbo].[property24_raw_data]
WHERE BEDROOMS > 2

--5. How many properties have 2 or more bathrooms?
SELECT COUNT (PROPERTY_ID) AS Property_with_2_or_more_Bathrooms
FROM [dbo].[property24_raw_data]
WHERE BATHROOMS >= 2


--6. How many properties have parking for at least 2 cars?
SELECT COUNT (PROPERTY_ID) AS Property_with_parking_for_2_cars
FROM [dbo].[property24_raw_data]
WHERE PARKING >= 2

--7. How many properties are priced above R3,000,000?
SELECT COUNT (PROPERTY_ID) AS Property_with_price_above_3M
FROM [dbo].[property24_raw_data]
WHERE PROPERTY_PRICE > 3000000

--8. How many properties are in Gauteng?
SELECT COUNT (PROPERTY_ID) AS Properties_in_Gauteng
FROM [dbo].[property24_raw_data]
WHERE PROVINCE = 'GAUTENG'


--9. How many properties per province have floor size greater than 200?
SELECT DISTINCT PROVINCE,
COUNT (PROPERTY_ID) AS Properties_in_Gauteng_with_FloorSize_GreaterThan_200
FROM [dbo].[property24_raw_data]
WHERE FLOOR_SIZE > 200
GROUP BY PROVINCE


--10. How many distinct provinces are in the table?
SELECT DISTINCT PROVINCE
FROM [dbo].[property24_raw_data]

--SECTION 2 – SUM Aggregations (10 Questions)
--11. What is the total value of all properties combined?
SELECT COUNT (PROPERTY_ID),
SUM(CAST(PROPERTY_PRICE AS BIGINT)) AS TotalValueForAllProperties
FROM [dbo].[property24_raw_data]

--12. What is the total property value per province?
SELECT DISTINCT PROVINCE,
SUM (Total_Once_off_Costs) AS Property_value_Per_Province
FROM [dbo].[property24_raw_data]
GROUP BY PROVINCE

--13. What is the total property value per city?
SELECT DISTINCT CITY,
SUM (Total_Once_off_Costs) AS Property_value_city
FROM [dbo].[property24_raw_data]
GROUP BY CITY

--14. What is the total monthly repayment for all properties?
SELECT PROPERTY_ID,
SUM (Monthly_Repayment) AS total_monthly_REPAYMENT
FROM [dbo].[property24_raw_data]
GROUP BY PROPERTY_ID

--15. What is the total monthly repayment per province?
SELECT DISTINCT PROVINCE,
SUM (Monthly_Repayment) AS total_monthly_REPAYMENT_per_province
FROM [dbo].[property24_raw_data]
GROUP BY PROVINCE

--16. What is the total once-off cost for all properties?
SELECT DISTINCT PROPERTY_ID,
SUM (Total_Once_off_Costs) AS total_once_OFF_COST_per_property
FROM [dbo].[property24_raw_data]
GROUP BY PROPERTY_ID

--17. What is the total once-off cost per province?
SELECT DISTINCT PROVINCE,
SUM (Total_Once_off_Costs) AS total_once_OFF_COST_per_province
FROM [dbo].[property24_raw_data]
GROUP BY PROVINCE

--18. What is the total property value for Gauteng?
SELECT DISTINCT PROVINCE,
SUM(CAST(PROPERTY_PRICE AS BIGINT)) AS total_property_value_for_gauteng
FROM [dbo].[property24_raw_data]
WHERE PROVINCE = 'Gauteng'
GROUP BY PROVINCE

--19. What is the total property value for properties priced above R4,000,000?
SELECT DISTINCT PROPERTY_ID,
SUM(CAST(PROPERTY_PRICE AS BIGINT)) AS total_property_vALUE_over_4M
FROM [dbo].[property24_raw_data]
WHERE PROPERTY_PRICE > 4000000
GROUP BY PROPERTY_ID

--20. What is the total minimum gross monthly income required per province?
SELECT DISTINCT PROVINCE,
(Min_Gross_Monthly_Income) 
FROM [dbo].[property24_raw_data]

--SECTION 3 – AVG Aggregations (10 Questions)
--21. What is the average property price overall?
SELECT AVG (CAST(PROPERTY_PRICE AS BIGINT))AS AVG_Property_PRICE
FROM [dbo].[property24_raw_data]


--22. What is the average property price per province?
SELECT DISTINCT PROVINCE,
AVG (CAST(PROPERTY_PRICE AS BIGINT))AS AVG_Property_PRICE_PER_PROVINCE
FROM [dbo].[property24_raw_data]
GROUP BY PROVINCE

--23. What is the average property price per city?
SELECT DISTINCT CITY,
AVG (CAST(PROPERTY_PRICE AS BIGINT))AS AVG_Property_PRICE_PER_city
FROM [dbo].[property24_raw_data]
GROUP BY CITY

--24. What is the average number of bedrooms per province?
SELECT DISTINCT PROVINCE,
AVG (BEDROOMS)AS AVG_number_of_bedroom_Per_province
FROM [dbo].[property24_raw_data]
GROUP BY PROVINCE

--25. What is the average number of bathrooms per province?
SELECT DISTINCT PROVINCE,
AVG (BATHROOMS)AS AVG_number_of_bathrooms_Per_province
FROM [dbo].[property24_raw_data]
GROUP BY PROVINCE

--26. What is the average floor size per province?
SELECT DISTINCT PROVINCE,
AVG (FLOOR_SIZE)AS AVG_number_of_FloorSize_Per_province
FROM [dbo].[property24_raw_data]
GROUP BY PROVINCE

--27. What is the average monthly repayment per province?
SELECT DISTINCT PROVINCE,
AVG (Monthly_Repayment)AS AVG_monthly_repayment_per_province
FROM [dbo].[property24_raw_data]
GROUP BY PROVINCE

--28. What is the average once-off cost per province?
SELECT DISTINCT PROVINCE,
AVG (Total_Once_off_Costs)AS AVG_Total_Once_off_Costs_per_province
FROM [dbo].[property24_raw_data]
GROUP BY PROVINCE

--29. What is the average minimum gross monthly income per province?
SELECT DISTINCT PROVINCE,
AVG (Min_Gross_Monthly_Income)AS AVG_Min_Gross_Monthly_Income_per_province
FROM [dbo].[property24_raw_data]
GROUP BY PROVINCE

--30. What is the average property price for properties above R3,000,000?
SELECT DISTINCT AVG (CAST(PROPERTY_PRICE AS BIGINT))AS AVG_property_price_for_properties_above_3M
FROM [dbo].[property24_raw_data]
WHERE PROPERTY_PRICE> 3000000