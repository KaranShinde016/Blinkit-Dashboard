/************************************************************************************************
Project Name : Blinkit Grocery Sales Analysis
Author       : Karan Shinde
Tools Used   : MySQL, Power BI
Dataset      : Blinkit Grocery Sales Dataset

Project Workflow
----------------
1. Database Setup
2. Data Quality Check and  Cleaning
3. Exploratory Data Analysis (EDA)
4.  Dashboard Queries
5.Advanced Business Analysis


************************************************************************************************/

/*-------------------------------------------------------------
SECTION 1 : Database_Setup

--------------------------------------------------------------*/
CREATE DATABASE blinkit_analysis;
USE blinkit_analysis;
show tables;

SELECT COUNT(*)
FROM `blinkit grocery data`;

RENAME TABLE `blinkit grocery data`
TO blinkit;


#view first 10 rows
SELECT *
FROM blinkit
LIMIT 10;

#check table structure
DESCRIBE blinkit;

#thier is table name not imported in good manar so change it 
ALTER TABLE blinkit
CHANGE COLUMN `ï»¿Item Fat Content` `Item Fat Content` TEXT;

#Issue 2: Column names contain spaces
# so it is not ideal ,change that
ALTER TABLE blinkit
CHANGE COLUMN `Item Fat Content` item_fat_content VARCHAR(30),
CHANGE COLUMN `Item Identifier` item_identifier VARCHAR(20),
CHANGE COLUMN `Item Type` item_type VARCHAR(100),
CHANGE COLUMN `Outlet Establishment Year` outlet_establishment_year INT,
CHANGE COLUMN `Outlet Identifier` outlet_identifier VARCHAR(20),
CHANGE COLUMN `Outlet Location Type` outlet_location_type VARCHAR(30),
CHANGE COLUMN `Outlet Size` outlet_size VARCHAR(20),
CHANGE COLUMN `Outlet Type` outlet_type VARCHAR(50),
CHANGE COLUMN `Item Visibility` item_visibility DECIMAL(10,6),
CHANGE COLUMN `Item Weight` item_weight DECIMAL(10,2),
CHANGE COLUMN `Total Sales` total_sales DECIMAL(10,2),
CHANGE COLUMN `Rating` rating DECIMAL(3,1);


/*-------------------------------------------------------------
SECTION 2 : Data_Quality_Check

--------------------------------------------------------------*/
#Data cleaning
# cheking missing or null values
SELECT
SUM(item_weight IS NULL) AS missing_weight,
SUM(outlet_size IS NULL) AS missing_outlet_size
FROM blinkit;


#it is for Business Purpose
#We want to know:
#"What unique values exist in the item_fat_content column?"
#Before cleaning, your data contained:
#item_fat_content
#Low Fat
#LF
#Regular
#reg
#These are 4 different text values, even though they represent only 2 business categories.
SELECT DISTINCT item_fat_content
FROM blinkit;

#safe update mode is on so we cant modify or rename  so we have to off that first
SET SQL_SAFE_UPDATES = 0;

#now you can run
UPDATE blinkit
SET item_fat_content = 'Low Fat'
WHERE item_fat_content = 'LF';
#also
UPDATE blinkit
SET item_fat_content = 'Regular'
WHERE item_fat_content = 'reg';

#verify
SELECT DISTINCT item_fat_content
FROM blinkit;

#finally safe update mode is on
SET SQL_SAFE_UPDATES = 1;

#Check Are there any duplicate rows?
SELECT
*
FROM blinkit
GROUP BY
item_identifier,
item_type,
item_fat_content,
outlet_identifier,
total_sales,
rating,
item_weight,
item_visibility,
outlet_size,
outlet_type,
outlet_location_type,
outlet_establishment_year
HAVING COUNT(*) > 1;


#now Check Duplicate Item IDs
SELECT
item_identifier,
COUNT(*) AS duplicate_count
FROM blinkit
GROUP BY item_identifier
HAVING COUNT(*) > 1;
#Don't worry if you see duplicates. The same product can appear in different outlets

#Check Outlet Types
SELECT DISTINCT outlet_type
FROM blinkit;

#check all important columns(missing values?)
SELECT
SUM(item_identifier IS NULL) AS missing_item_identifier,
SUM(item_type IS NULL) AS missing_item_type,
SUM(item_fat_content IS NULL) AS missing_fat_content,
SUM(total_sales IS NULL) AS missing_sales,
SUM(rating IS NULL) AS missing_rating
FROM blinkit;


#Check  Invalid Values
#like Sales cannot be negative.
SELECT *
FROM blinkit
WHERE total_sales < 0;

#Ratings should usually be between 1 and 5.
SELECT *
FROM blinkit
WHERE rating < 1
OR rating > 5;


/*-------------------------------------------------------------
SECTION 3 : Exploratory_Data_Analysis

--------------------------------------------------------------*/
#now dashboard queris 
#These are the exact SQL queries that correspond to your Power BI visuals

#Total Sales
SELECT
ROUND(SUM(total_sales),2) AS total_sales
FROM blinkit;

#AVG Sales
SELECT
ROUND(AVG(total_sales),2) AS average_sales
FROM blinkit;

#Number of items
SELECT
COUNT(*) AS total_items
FROM blinkit;

#average Ratings
SELECT
ROUND(AVG(rating),2) AS average_rating
FROM blinkit;

#Total Unique Item Types
SELECT
COUNT(DISTINCT item_type) AS total_item_types
FROM blinkit;

#Total Outlet Types
SELECT
COUNT(DISTINCT outlet_type) AS total_outlet_types
FROM blinkit;

#Highest, Lowest & Average Rating
SELECT
MAX(rating) AS highest_rating,
MIN(rating) AS lowest_rating,
ROUND(AVG(rating),2) AS average_rating
FROM blinkit;

#Item Distribution by Rating
SELECT
rating,
COUNT(*) AS total_items
FROM blinkit
GROUP BY rating
ORDER BY rating DESC;

# Visibility Analysis
SELECT
MAX(item_visibility) AS max_visibility,
MIN(item_visibility) AS min_visibility,
ROUND(AVG(item_visibility),4) AS average_visibility
FROM blinkit;


/*-------------------------------------------------------------
SECTION 4 : DASHBOARD QUERIES
Purpose:
These queries answer the business questions used to build
the Power BI dashboard.
--------------------------------------------------------------*/
#Sales By Fact Dashboard 
SELECT
item_fat_content,
ROUND(SUM(total_sales),2) AS total_sales
FROM blinkit
GROUP BY item_fat_content
ORDER BY total_sales DESC;

#Dashboard 2: Sales by Item Type
#1. Business Question
# Which product categories generate the highest sales?

SELECT
    item_type,
    ROUND(SUM(total_sales),2) AS total_sales
FROM blinkit
GROUP BY item_type
ORDER BY total_sales DESC;



#Dashboard 3:  Fat Content by Outlet for Total Sales
#Business Question
#Which outlet sells more Low Fat and Regular products?

SELECT
    outlet_location_type,
    item_fat_content,
    ROUND(SUM(total_sales),2) AS total_sales
FROM blinkit
GROUP BY outlet_location_type, item_fat_content
ORDER BY outlet_location_type;


#Dashboard 4:  Total Sales by Outlet Establishment
#Business Question
#Does the outlet establishment year affect sales?

SELECT
    outlet_establishment_year,
    ROUND(SUM(total_sales),2) AS total_sales
FROM blinkit
GROUP BY outlet_establishment_year
ORDER BY outlet_establishment_year;


#Dashboard 5:Percentage of Sales by Outlet Size
#Business Question
#What percentage of total sales comes from Small, Medium, and High outlets?

SELECT
    outlet_size,
    ROUND(SUM(total_sales),2) AS total_sales,
    ROUND(SUM(total_sales) * 100 /(SELECT SUM(total_sales) FROM blinkit),2) AS sales_percentage
FROM blinkit
GROUP BY outlet_size
ORDER BY total_sales DESC;


#Dashboard6. Sales by Outlet Location
#Business Question
#Which location tier contributes the highest sales?

SELECT
    outlet_location_type,
    ROUND(SUM(total_sales),2) AS total_sales
FROM blinkit
GROUP BY outlet_location_type
ORDER BY total_sales DESC;

#Dashboard7. All Metrics by Outlet Type
#This is the most important query because it powers the summary table in the dashboard.
SELECT
    outlet_type,
    ROUND(SUM(total_sales),2) AS total_sales,
    ROUND(AVG(total_sales),2) AS average_sales,
    COUNT(*) AS number_of_items,
    ROUND(AVG(rating),2) AS average_rating
FROM blinkit
GROUP BY outlet_type
ORDER BY total_sales DESC;


/*-------------------------------------------------------------
SECTION 5 :Advanced_Business_Analysis

--------------------------------------------------------------*/
#Top 10 Highest Selling Products
SELECT
item_identifier,
item_type,
total_sales
FROM blinkit
ORDER BY total_sales DESC
LIMIT 10;

#Bottom 10 Products
SELECT
item_identifier,
item_type,
total_sales
FROM blinkit
ORDER BY total_sales
LIMIT 10;

#Highest Rated Products
SELECT
item_identifier,
item_type,
rating
FROM blinkit
ORDER BY rating DESC
LIMIT 10;

#Best performing outlets
SELECT
outlet_identifier,
ROUND(SUM(total_sales),2) AS total_sales
FROM blinkit
GROUP BY outlet_identifier
ORDER BY total_sales DESC;

#Best Selling Item Type
SELECT
item_type,
ROUND(SUM(total_sales),2) AS total_sales
FROM blinkit
GROUP BY item_type
ORDER BY total_sales DESC;



SELECT
*
FROM blinkit
GROUP BY
item_identifier,
item_type,
item_fat_content,
outlet_identifier,
total_sales,
rating,
item_weight,
item_visibility,
outlet_size,
outlet_type,
outlet_location_type,
outlet_establishment_year
HAVING COUNT(*) > 1;



SELECT VERSION();