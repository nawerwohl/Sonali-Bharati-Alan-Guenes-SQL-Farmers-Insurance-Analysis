-- 	MySQL - Farmers Insurance Analysis
-- Group: Sonali Bharati, Alan Günes


use ndap;
-- ----------------------------------------------------------------------------------------------
-- SECTION 1. 
-- SELECT Queries [5 Marks]

-- 	Q1.	Retrieve the names of all states (srcStateName) from the dataset.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT srcstatename
FROM FarmersInsuranceData
ORDER BY srcstatename;

-- <write your answers in the empty spaces given, the length of solution queries (and the solution writing space) can vary>
/* 
KARNATAKA
JAMMU AND KASHMIR
HIMACHAL PRADESH
UTTARAKHAND
HARYANA
GUJARAT
RAJASTHAN
TELANGANA
JHARKHAND
UTTAR PRADESH
TRIPURA
ASSAM
WEST BENGAL
ODISHA
CHHATTISGARH
MADHYA PRADESH
MAHARASHTRA
ANDHRA PRADESH
GOA
KERALA
TAMIL NADU
PUDUCHERRY
PUNJAB
SIKKIM
MANIPUR
MEGHALAYA
ANDAMAN AND NICOBAR ISLANDS
*/
###

-- 	Q2.	Retrieve the total number of farmers covered (TotalFarmersCovered) 
-- 		and the sum insured (SumInsured) for each state (srcStateName), ordered by TotalFarmersCovered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
       SUM(TotalFarmersCovered) AS TotalFarmersCovered,
       ROUND(SUM(SumInsured),2) AS TotalSumInsured
FROM FarmersInsuranceData
GROUP BY srcStateName
ORDER BY TotalFarmersCovered DESC;


-- ###

-- --------------------------------------------------------------------------------------
-- SECTION 2. 
-- Filtering Data (WHERE) [15 Marks]

-- 	Q3.	Retrieve all records where Year is '2020'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT * 
FROM   FarmersInsuranceData
WHERE  srcYear = 2020;
-- ###

-- 	Q4.	Retrieve all rows where the TotalPopulationRural is greater than 1 million and the srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT *
FROM   FarmersInsuranceData  
WHERE  srcStateName ='HIMACHAL PRADESH'
AND    TotalPopulationRural > 1000000;

-- ###

-- 	Q5.	Retrieve the srcStateName, srcDistrictName, and the sum of FarmersPremiumAmount for each district in the year 2018, 
-- 		and display the results ordered by FarmersPremiumAmount in ascending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
       srcDistrictName,
       ROUND(SUM(FarmersPremiumAmount), 2) AS TotalFarmersPremiumAmount
FROM FarmersInsuranceData
WHERE srcYear = 2018
GROUP BY srcStateName,
         srcDistrictName
ORDER BY TotalFarmersPremiumAmount;



-- ###

-- 	Q6.	Retrieve the total number of farmers covered (TotalFarmersCovered) and the sum of premiums (GrossPremiumAmountToBePaid) for each state (srcStateName) 
-- 		where the insured land area (InsuredLandArea) is greater than 5.0 and the Year is 2018.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
       ROUND(SUM(TotalFarmersCovered),2) AS TotalFarmersCovered,
       ROUND(SUM(GrossPremiumAmountToBePaid),2) AS TotalPremiumPaid
FROM FarmersInsuranceData
WHERE InsuredLandArea > 5.0
  AND srcYear = 2018
GROUP BY srcStateName
ORDER BY srcStateName;



	  
-- ###
-- ------------------------------------------------------------------------------------------------

-- SECTION 3.
-- Aggregation (GROUP BY) [10 marks]

-- 	Q7. 	Calculate the average insured land area (InsuredLandArea) for each year (srcYear).
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcYear,
       ROUND(AVG(InsuredLandArea),2) AS AverageInsuredLandArea
FROM FarmersInsuranceData
GROUP BY srcYear
ORDER BY srcYear;


-- ###

-- 	Q8. 	Calculate the total number of farmers covered (TotalFarmersCovered) for each district (srcDistrictName) where Insurance units is greater than 0.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcDistrictName,
       ROUND(SUM(TotalFarmersCovered),2) AS TotalFarmersCoveredSum
FROM FarmersInsuranceData
WHERE InsuranceUnits > 0
GROUP BY srcDistrictName
ORDER BY TotalFarmersCoveredSum DESC;


-- ###

-- 	Q9.	For each state (srcStateName), calculate the total premium amounts (FarmersPremiumAmount, StatePremiumAmount, GOVPremiumAmount) 
-- 		and the total number of farmers covered (TotalFarmersCovered). Only include records where the sum insured (SumInsured) is greater than 500,000 (remember to check for scaling).
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
       ROUND(SUM(FarmersPremiumAmount), 2) AS TotalFarmersPremium,
       ROUND(SUM(StatePremiumAmount), 2) AS TotalStatePremium,
       ROUND(SUM(GOVPremiumAmount), 2) AS TotalGovPremium,
       ROUND(SUM(TotalFarmersCovered), 2) AS TotalFarmersCoveredSum
FROM FarmersInsuranceData
WHERE SumInsured > 5 -- Scaling Factor of 100000 applied
GROUP BY srcStateName
ORDER BY srcStateName;

-- ###
-- -------------------------------------------------------------------------------------------------
-- SECTION 4.
-- Sorting Data (ORDER BY) [10 Marks]

-- 	Q10.	Retrieve the top 5 districts (srcDistrictName) with the highest TotalPopulation in the year 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcDistrictName,
       TotalPopulation 
FROM   FarmersInsuranceData  
WHERE  srcYear = 2020
ORDER BY TotalPopulation DESC
LIMIT 5;
-- ###
-- 	Q11.	Retrieve the srcStateName, srcDistrictName, and SumInsured for the 10 districts with the lowest non-zero FarmersPremiumAmount, 
-- 		ordered by insured sum and then the FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
       srcDistrictName,
       ROUND(SUM(SumInsured),4) AS SumInsured,
       ROUND(SUM(FarmersPremiumAmount),4) AS TotalFarmersPremiumAmount
FROM FarmersInsuranceData
WHERE FarmersPremiumAmount > 0
GROUP BY srcStateName, srcDistrictName
ORDER BY SumInsured ASC,
         TotalFarmersPremiumAmount ASC
LIMIT 10;

-- ###
-- 	Q12. 	Retrieve the top 3 states (srcStateName) along with the year (srcYear) where the ratio of insured farmers (TotalFarmersCovered) to the total population (TotalPopulation) is highest. 
-- 		Sort the results by the ratio in descending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
       srcYear,
       ROUND(SUM(TotalFarmersCovered) / SUM(TotalPopulation), 2) AS CoverageRatio
FROM FarmersInsuranceData
WHERE TotalPopulation > 0
GROUP BY srcStateName, srcYear
ORDER BY CoverageRatio DESC
LIMIT 3;


-- -------------------------------------------------------------------------------------------------

-- SECTION 5.
-- String Functions [6 Marks]

-- 	Q13. 	Create StateShortName by retrieving the first 3 characters of the srcStateName for each unique state.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT srcStateName StateName, 
       SUBSTR(srcStateName,1,3) StateShortName
FROM   FarmersInsuranceData;
-- ###
-- 	Q14. 	Retrieve the srcDistrictName where the district name starts with 'B'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT srcDistrictName AS DistrictName
FROM   FarmersInsuranceData
WHERE  UPPER(srcDistrictName) like 'B%';
-- ###

-- 	Q15. 	Retrieve the srcStateName and srcDistrictName where the district name contains the word 'pur' at the end.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT srcStateName AS StateName,
       srcDistrictName AS DistrictName
FROM   FarmersInsuranceData
WHERE  UPPER(srcDistrictName) LIKE '%PUR';
-- ###
-- -------------------------------------------------------------------------------------------------

-- SECTION 6.
-- Joins [14 Marks]

-- 	Q16. 	Perform an INNER JOIN between the srcStateName and srcDistrictName columns to retrieve the aggregated
 -- FarmersPremiumAmount for districts where the district’s Insurance units for an individual yearare greater than 10.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
WITH Insunitfyearwise AS
  (SELECT srcStateName,
      	srcDistrictName,
      	srcYear,
      	ROUND(Sum(FarmersPremiumAmount),2) AS AggregatedPremium
   FROM FarmersInsuranceData
   WHERE insuranceUnits > 10
   GROUP BY srcStateName,
        	srcDistrictName,
        	srcYear)
SELECT f1.srcStateName StateName,
   	f1.srcDistrictName DistrictName,
   	f1.srcYear,
   	f1.insuranceUnits,
   	f2.AggregatedPremium
FROM FarmersInsuranceData f1
INNER JOIN Insunitfyearwise f2 USING(srcStateName,
                                     srcDistrictName,
                                 	srcYear)
ORDER BY f1.srcStateName,
     	f1.srcDistrictName,
     	f1.srcYear;


-- ###
-- 	Q17.	Write a query that retrieves srcStateName, srcDistrictName, Year, TotalPopulation for each district and the the highest recorded FarmersPremiumAmount for that district over all available years
-- 		Return only those districts where the highest FarmersPremiumAmount exceeds 20 crores.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
       srcDistrictName,
       srcYear,
       TotalPopulation,
       max(FarmersPremiumAmount) HighestPrmAmt
FROM   FarmersInsuranceData
GROUP BY srcStateName,srcDistrictName,srcYear,TotalPopulation
HAVING (HighestPrmAmt*100000) > 200000000
ORDER BY  srcStateName, srcDistrictName, srcYear;


-- ###
-- 	Q18.	Perform a LEFT JOIN to combine the total population statistics with the farmers’ data (TotalFarmersCovered, SumInsured) for each district and state. 
-- 		Return the total premium amount (FarmersPremiumAmount) and the average population count for each district aggregated over the years, where the total FarmersPremiumAmount is greater than 100 crores.
-- 		Sort the results by total farmers' premium amount, highest first.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT f1.srcStateName,
       f1.srcDistrictName,
       SUM(f1.TotalFarmersCovered) TotFarmCov,
       SUM(f1.SumInsured) SumIns,
       SUM(f1.FarmersPremiumAmount) TotPrmAmt,
       AVG(f1.TotalPopulation) AvgPopulationCnt
FROM   FarmersInsuranceData f1
LEFT JOIN FarmersInsuranceData f2
USING( srcStateName,srcDistrictName)
GROUP BY srcStateName, srcDistrictName 
HAVING  SUM(f1.FarmersPremiumAmount*100000) > 1000000000 
ORDER BY TotPrmAmt DESC;


-- ###
-- -------------------------------------------------------------------------------------------------

-- SECTION 7.
-- Subqueries [10 Marks]

-- 	Q19.	Write a query to find the districts (srcDistrictName) where the TotalFarmersCovered is greater than the  average TotalFarmersCovered across all records.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcDistrictName,
   	TotalFarmersCovered
FROM FarmersInsuranceData
WHERE TotalFarmersCovered >
	(SELECT AVG(TotalFarmersCovered)
 	FROM FarmersInsuranceData)
ORDER BY TotalFarmersCovered DESC;

-- ###

-- 	Q20.	Write a query to find the srcStateName where the SumInsured is higher than the SumInsured of the district with the highest FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
   	ROUND(SUM(SumInsured),2) AS StateSumInsured
FROM FarmersInsuranceData
GROUP BY srcStateName
HAVING SUM(SumInsured) >
  (SELECT SUM(SumInsured)
   FROM FarmersInsuranceData
   WHERE FarmersPremiumAmount =
   	(SELECT MAX(FarmersPremiumAmount)
    	FROM FarmersInsuranceData)
   GROUP BY srcDistrictName
   LIMIT 1)
ORDER BY StateSumInsured DESC;

			
                        
 -- ###

-- 	Q21.	Write a query to find the srcDistrictName where the FarmersPremiumAmount is higher than the average FarmersPremiumAmount of the state that has the highest TotalPopulation.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcDistrictName,
   	ROUND(MAX(FarmersPremiumAmount), 2) AS MaxFarmersPremiumAmount
FROM FarmersInsuranceData
WHERE FarmersPremiumAmount >
	(SELECT AVG(FarmersPremiumAmount)
 	FROM FarmersInsuranceData
 	WHERE srcStateName =
     	(SELECT srcStateName
      	FROM FarmersInsuranceData
      	WHERE TotalPopulation =
          	(SELECT MAX(TotalPopulation)
           	FROM FarmersInsuranceData)
      	LIMIT 1))
GROUP BY srcDistrictName
ORDER BY MaxFarmersPremiumAmount DESC;

-- ###




-- -------------------------------------------------------------------------------------------------

-- SECTION 8.
-- Advanced SQL Functions (Window Functions) [10 Marks]

-- 	Q22.	Use the ROW_NUMBER() function to assign a row number to each record in the dataset ordered by total farmers covered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT *,
   	ROW_NUMBER() OVER(
                     	ORDER BY TotalFarmersCovered DESC) AS ROWNUMBER
FROM FarmersInsuranceData;

-- ###

-- 	Q23.	Use the RANK() function to rank the districts (srcDistrictName) based on the SumInsured (descending) and partition by alphabetical srcStateName.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcYear,
   	srcStateName,
   	srcDistrictName,
   	ROUND(SUM(SumInsured), 2) AS TotalSumInsured,
   	DENSE_RANK() OVER (PARTITION BY srcStateName
                      	ORDER BY SUM(SumInsured) DESC) AS RANKING
FROM FarmersInsuranceData
GROUP BY srcYear,
     	srcStateName,
     	srcDistrictName
ORDER BY srcStateName,
     	RANKING;



-- ###

-- 	Q24.	Use the SUM() window function to calculate a cumulative sum of FarmersPremiumAmount for each district (srcDistrictName), ordered ascending by the srcYear, partitioned by srcStateName.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT  srcYear,
		srcStateName,
        srcDistrictName,
        FarmersPremiumAmount,
        ROUND(SUM(FarmersPremiumAmount) OVER (PARTITION BY srcStateName, srcDistrictName ORDER BY srcYear ASC),2) AS CumulativePremiumAmount
FROM    FarmersInsuranceData
ORDER BY srcStateName ASC, srcDistrictName ASC,  srcYear ASC;
-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 9.
-- Data Integrity (Constraints, Foreign Keys) [4 Marks]

-- 	Q25.	Create a table 'districts' with DistrictCode as the primary key and columns for DistrictName and StateCode. 
-- 		Create another table 'states' with StateCode as primary key and column for StateName.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
CREATE TABLE states (StateCode INT PRIMARY KEY,
                               	StateName VARCHAR(80) NOT NULL);
 

 
CREATE TABLE districts (DistrictCode INT PRIMARY KEY,
                                         DistrictName VARCHAR(80) NOT NULL,
                                                                  StateCode INT);


-- ###

-- 	Q26.	Add a foreign key constraint to the districts table that references the StateCode column from a states table.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >



ALTER TABLE districts ADD CONSTRAINT foreign_key_statecode
FOREIGN KEY (StateCode) REFERENCES states(StateCode);

-- ###
-- -------------------------------------------------------------------------------------------------

-- SECTION 10.
-- UPDATE and DELETE [6 Marks]

-- 	Q27.	Update the FarmersPremiumAmount to 500.0 for the record where rowID is 1.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

UPDATE FarmersInsuranceData
SET FarmersPremiumAmount = 500.0
WHERE rowID = 1;
COMMIT;

-- ###

-- 	Q28.	Update the Year to '2021' for all records where srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
    SET SQL_SAFE_UPDATES = 0;
   /*  select srcYear,count(*) from FarmersInsuranceData
    WHERE  srcStateName  =  'HIMACHAL PRADESH'
    group by srcYear;
    */
   UPDATE FarmersInsuranceData
   SET    srcYear = 2021
   WHERE  srcStateName  =  'HIMACHAL PRADESH';
    /* GOt Error Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column. 
    --  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.000 sec
    --Since the query does not use id's column for update we need to surpass this safe update
     using SET SQL_SAFE_UPDATES = 0;
     Use below query to verify
        select srcYear,count(*) from FarmersInsuranceData
    WHERE  srcStateName  =  'HIMACHAL PRADESH'
    group by srcYear;
    */
-- ###



-- 	Q29.	Delete all records where the TotalFarmersCovered is less than 10000 and Year is 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
/*
   SELECT count(*)from FarmersInsuranceData
   WHERE  TotalFarmersCovered < 10000
    and srcYear = 2020
*/
--
  DELETE FROM FarmersInsuranceData
  WHERE  TotalFarmersCovered < 10000
  AND    srcYear = 2020;
  
  SET SQL_SAFE_UPDATES = 1;
-- ###