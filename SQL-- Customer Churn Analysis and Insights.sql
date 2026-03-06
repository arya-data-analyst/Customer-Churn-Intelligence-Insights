              -- -- Customer Churn Analysis and Insights -- -- 


use db_churn;
select count(*) from churn ;
select * from churn ;

  -- Data Exploration – Check Distinct Values
SELECT Gender, Count(Gender) as TotalCount,
Count(Gender) * 1.0 / (Select Count(*) from churn)  as Percentage
from churn
Group by Gender;

SELECT Contract, Count(Contract) as TotalCount,
Count(Contract) * 1.0 / (Select Count(*) from churn)  as Percentage
from churn
Group by Contract;


SELECT Customer_Status, Count(Customer_Status) as TotalCount, Sum(Total_Revenue) as TotalRev,
Sum(Total_Revenue) / (Select sum(Total_Revenue) from churn) * 100  as RevPercentage
from churn
Group by Customer_Status;

SELECT State, Count(State) as TotalCount,
Count(State) * 1.0 / (Select Count(*) from churn)  as Percentage
from churn
Group by State
Order by Percentage desc;


   -- Data Exploration – Check Nulls
SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM churn;


   -- Remove null and insert the new data into Prod table
SELECT 
    Customer_ID,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    Tenure_in_Months,
    ISNULL(Value_Deal, 'None') AS Value_Deal,
    Phone_Service,
    ISNULL(Multiple_Lines, 'No') As Multiple_Lines,
    Internet_Service,
    ISNULL(Internet_Type, 'None') AS Internet_Type,
    ISNULL(Online_Security, 'No') AS Online_Security,
    ISNULL(Online_Backup, 'No') AS Online_Backup,
    ISNULL(Device_Protection_Plan, 'No') AS Device_Protection_Plan,
    ISNULL(Premium_Support, 'No') AS Premium_Support,
    ISNULL(Streaming_TV, 'No') AS Streaming_TV,
    ISNULL(Streaming_Movies, 'No') AS Streaming_Movies,
    ISNULL(Streaming_Music, 'No') AS Streaming_Music,
    ISNULL(Unlimited_Data, 'No') AS Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    ISNULL(Churn_Category, 'Others') AS Churn_Category,
    ISNULL(Churn_Reason , 'Others') AS Churn_Reason;

     -- Total Customers
    SELECT COUNT(*) AS total_customers
FROM db_churn.churn;

      -- Total Churn
SELECT COUNT(*) AS total_churn
FROM db_churn.churn
WHERE Customer_Status = 'Churned';

     -- New Joiners
SELECT COUNT(*) AS new_joiners
FROM db_churn.churn
WHERE Customer_Status = 'Joined';

        -- Churn Rate
SELECT 
ROUND(
    SUM(CASE WHEN Customer_Status='Churned' THEN 1 ELSE 0 END) 
    / COUNT(*) * 100,2
) AS churn_rate
FROM db_churn.churn;

      -- Total Churn by Gender
SELECT 
Gender,
COUNT(*) AS total_churn
FROM db_churn.churn
WHERE Customer_Status = 'Churned'
GROUP BY Gender;

     -- Total Customers and Churn Rate by Tenure Group
SELECT 
CASE
    WHEN Tenure_in_Months < 6 THEN '< 6 Months'
    WHEN Tenure_in_Months BETWEEN 6 AND 12 THEN '6-12 Months'
    WHEN Tenure_in_Months BETWEEN 12 AND 18 THEN '12-18 Months'
    WHEN Tenure_in_Months BETWEEN 18 AND 24 THEN '18-24 Months'
    ELSE '> 24 Months'
END AS Tenure_Group,

COUNT(*) AS total_customers,

ROUND(
    SUM(CASE WHEN Customer_Status='Churned' THEN 1 ELSE 0 END)
/ COUNT(*),2
) AS churn_rate

FROM db_churn.churn
GROUP BY Tenure_Group;

    -- Churn Rate by Internet Type
SELECT 
Internet_Type,
ROUND(
    SUM(CASE WHEN Customer_Status='Churned' THEN 1 ELSE 0 END)
/ COUNT(*) * 100,2
) AS churn_rate
FROM db_churn.churn
GROUP BY Internet_Type;

    -- Churn Rate by Payment Method
SELECT 
Payment_Method,
ROUND(
    SUM(CASE WHEN Customer_Status='Churned' THEN 1 ELSE 0 END)
/ COUNT(*) * 100,2
) AS churn_rate
FROM db_churn.churn
GROUP BY Payment_Method
ORDER BY churn_rate DESC;

      -- Churn Rate by Contract
SELECT 
Contract,
ROUND(
    SUM(CASE WHEN Customer_Status='Churned' THEN 1 ELSE 0 END)
/ COUNT(*) * 100,2
) AS churn_rate
FROM db_churn.churn
GROUP BY Contract;

      -- Total Customers and Churn Rate by Age Group
SELECT 
CASE
    WHEN Age < 20 THEN '< 20'
    WHEN Age BETWEEN 20 AND 35 THEN '20 - 35'
    WHEN Age BETWEEN 36 AND 50 THEN '36 - 50'
    ELSE '> 50'
END AS Age_Group,

COUNT(*) AS total_customers,

ROUND(
SUM(CASE WHEN Customer_Status='Churned' THEN 1 ELSE 0 END)
/ COUNT(*),2
) AS churn_rate

FROM db_churn.churn
GROUP BY Age_Group;

     -- Total Churn by Churn Category
SELECT 
Churn_Category,
COUNT(*) AS total_churn
FROM db_churn.churn
WHERE Customer_Status = 'Churned'
GROUP BY Churn_Category
ORDER BY total_churn DESC;

     -- Total Churn by State
SELECT 
State,
COUNT(*) AS total_churn
FROM db_churn.churn
WHERE Customer_Status = 'Churned'
GROUP BY State
ORDER BY total_churn DESC;

     -- Filter Query (for Dashboard Filters)
-- Monthly Charge Range
SELECT *
FROM db_churn.churn
WHERE Monthly_Charge BETWEEN 50 AND 100;
  -- Married Filter
SELECT *
FROM db_churn.churn
WHERE Married = 'Yes';

      -- Total Churn by Churn_Reason
SELECT 
    Churn_Reason,
    COUNT(*) AS Total_Churn
FROM db_churn.churn
WHERE Customer_Status = 'Churned'
AND Churn_Reason IS NOT NULL
GROUP BY Churn_Reason
ORDER BY Total_Churn DESC;