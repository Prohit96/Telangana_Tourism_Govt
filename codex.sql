CREATE DATABASE CodeX_beverages;
USE CodeX_beverages;

-- Table Structure - Dim_Cities 

CREATE TABLE dim_cities 
	(
			city_id VARCHAR(8),
            city CHAR(10),
            Tier VARCHAR(10)
    );
    
select * from dim_cities

LOAD DATA INFILE 
'C:/dim_cities.csv'
INTO TABLE dim_cities
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Table Structure - Dim repondents 

CREATE TABLE dim_repondents
		(
			respondent_id INT,
            Full_Name CHAR(30),
            age VARCHAR(8),
            gender CHAR(12),
            city_id VARCHAR(6)
    );
    
select * from dim_repondents    
    
-- Load the dataset in the table dim_repondents 

LOAD DATA INFILE 
'C:/dim_repondents.csv'
INTO TABLE dim_repondents
FIELDS TERMINATED BY     ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



-- Table Structure fact_survey_response 

CREATE TABLE fact_survey_response 
	(
		response_id INT,
        repondents_id INT,
        consume_frequency VARCHAR(20),
        consume_time VARCHAR(35),
        consume_reason VARCHAR(30),
        heard_before CHAR(10),
        brand_perception CHAR(10),
        general_perception CHAR(10),
        tired_before CHAR(10),
        taste_experience INT,
        reasons_preventing_trying VARCHAR(40),
        current_brands VARCHAR(10),
        resaons_for_choosing_brands VARCHAR(30),
        improvement_desired CHAR(30),
        ingredients_expected CHAR(20),
        health_concerns VARCHAR(15),
        interest_in_natural_or_organic CHAR(20),
        marketing_channels CHAR(20),
        packaging_prederence CHAR(30),
        limited_edition_packaging CHAR(10),
        price_range VARCHAR(15),
        purchase_location CHAR(40),
        typical_consumption_situations VARCHAR(30)
    );
    
select * from fact_survey_response 
    
-- Load the dataset in the table fact_survey 

LOAD DATA INFILE 
'C:/fact_survey_responses.csv'
INTO TABLE fact_survey_response
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Overview the tables of beverages 

SELECT * FROM dim_cities;
SELECT * FROM dim_repondents;
SELECT * FROM fact_survey_response;

-- Demographic Insights`

-- 1. Who Prefers energy drink more?

SELECT 
	gender AS Gender,
    COUNT((respondent_id)/1000000) AS Total_respondents_mlns
FROM
    dim_repondents
GROUP BY gender
ORDER BY 2 DESC;

-- 2. Which age group prefers energy drinks more?

SELECT 
    age AS Age,
    COUNT((respondent_id) / 1000000) AS Total_Respondents_mln
FROM
    dim_repondents
GROUP BY age
ORDER BY 2 DESC;

-- 3. Which type of marketing reaches the most youth (15-30)?

SELECT 
    dr.age,
    sr.marketing_channels,
    COUNT(respondent_id) AS Total_Respondents
FROM
    dim_repondents dr
        JOIN
    fact_survey_response sr ON dr.respondent_id = respondent_id
WHERE dr.age IN ("15-18" , "19-30")    
GROUP BY dr.age , sr.marketing_channels
ORDER BY 3 DESC;

select * from dim_repondents
