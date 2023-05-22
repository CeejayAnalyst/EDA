/*
Name : Chijioke Iwuchukwu 
Project : Bank market campaign Analysis 
Date : 2023-05-21

*/

-- 1.) DESCRIBE THE DATA SET 


SELECT * 
FROM [Cleaned_bank ]

/* DEESCRIBING AGE COLUMN */
--- 1.) Max age and min age of client contacted ---

SELECT 

	MAX(age) AS Max_age,
	MIN(age) AS Min_age

FROM [Cleaned_bank ]

--- 2.) Total Number of customers by Age group ( age group 21 - 40 & 41 - 60 ) . ---

SELECT
    CASE
        WHEN age >= 1 AND age <= 20 THEN '1-20'
        WHEN age > 20 AND age <= 40 THEN '21-40'
        WHEN age > 40 AND age <= 60 THEN '41-60'
		WHEN age > 60 AND age <= 80 THEN '61-80'
		WHEN age > 80 AND age <= 100 THEN '81-100'
    END AS age_group,
    COUNT(*) AS entry_count
FROM
    [Cleaned_bank ]
GROUP BY
        CASE
        WHEN age >= 1 AND age <= 20 THEN '1-20'
        WHEN age > 20 AND age <= 40 THEN '21-40'
        WHEN age > 40 AND age <= 60 THEN '41-60'
		WHEN age > 60 AND age <= 80 THEN '61-80'
		WHEN age > 80 AND age <= 100 THEN '81-100'
    END 

---3.) Total Number of clients by marital status
SELECT

	COUNT(*) AS Total_count,
	marital
FROM [Cleaned_bank ]

GROUP BY 
	marital

--- 4.) Total Number of Customers by Education level

SELECT

	COUNT(*) AS Total_count,
	education
FROM [Cleaned_bank ]

GROUP BY 
	education

--5.) Total number of Customer with default 
SELECT

	COUNT(*) AS Total_count,
	Load_default
FROM [Cleaned_bank ]

GROUP BY 
	Load_default
HAVING
	Load_default = 'yes' OR Load_default = 'no'

--- 6.) Total Number of clients having Housing Loans and personal loans
SELECT

	COUNT(*) AS Total_count,
	housing
FROM [Cleaned_bank ]

GROUP BY 
	housing

HAVING
	housing = 'yes' OR housing = 'no'

--- 7.) Total Number of clients personal loans

SELECT

	COUNT(*) AS Total_count,
	loan

FROM [Cleaned_bank ]

GROUP BY 
	loan

HAVING
	Loan = 'yes' OR loan = 'no'

/* number of days that passed by after the client was last contacted from a previous campaign , KINDLY NOTE THAT '999' means clients was not previously contacted * 
DATASET ORIGINALLY HAS COLUMN 'Pdays' as INT , BUT I CHANGED THE DATATYPE TO VARCHAR , AS '999' WILL SKEW MY ANALYSIS , I ALSO REPLACED '999' TO NA '

THE 'Pdays means number of days that passed by after the client was last contacted from a previous campaign */

--- Replacing '999' with 'NA' ----
UPDATE [Cleaned_bank ]
SET pdays = REPLACE(pdays, '999', 'NA')
WHERE pdays LIKE '%999%';

--1.) pdays with the highest count (MODE) 
SELECT 

	pdays,
	COUNT(*) AS Total_counts

FROM [Cleaned_bank ]

GROUP BY 
	pdays

ORDER BY 
	Total_counts DESC

--2.) Min , Max and Average number of contacts performed during this campaign 
SELECT 
	MIN(campaign_now) As Min_num_contact,
	MAX(campaign_now) As Max_num_contact,
	AVG(campaign_now) As AVG_num_contact
FROM
	[Cleaned_bank ]

--3.) Min , Max and Average number of contacts performed before this campaign for clients 
SELECT 
	MIN(Campaign_prev) As Min_num_contact,
	MAX(Campaign_prev) As Max_num_contact,
	AVG(Campaign_prev) As AVG_num_contact
FROM
	[Cleaned_bank ]


/* SOME exploratory analysis */

-- CUSTOMERS WITH ADMIN JOB TENDS TO BE THE ONES WITH THE HIGHEST SUCCESS WITH LOWEST CONTACT ---
SELECT COUNT(*) AS Total_counts , job

FROM [Cleaned_bank ]

WHERE campaign_now = 
(SELECT 
	MIN(campaign_now) As Max_num_contact
FROM
	[Cleaned_bank ]) AND poutcome = 'success'

GROUP BY 
	job 

ORDER BY 
 Total_counts DESC
	

