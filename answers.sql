
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