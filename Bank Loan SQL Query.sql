SELECT COUNT(*) AS TotalRows
FROM bank_data;

use sakila;
select * from bank_data;


SELECT COUNT(`Client id_Y`) 
AS Total_loan_Applications
FROM bank_data;

select sum(`Loan Amount_Y`) 
As Total_Funded_Amount 
From bank_data;

select (count(case when `Loan Status_Y`= "Fully Paid" or`Loan Status_Y`= "Paid Off" then `Client id_Y` end)* 100)
 /
 count(`Client id_Y`) As Good_Loan_Persentge 
 from bank_data;



select (count(case when `Loan Status_Y`= "Cancelled" then `Client id_Y` end)* 100)/
 count(`Client id_Y`) As Bad_Loan_Percentge 
 from	bank_data;

SELECT SUM(`Total Rrec int_Y`) AS total_interest
FROM bank_data;


#Branch-Wise (Interest, Fees, Total Revenue)#

SELECT `Branch Name_Y`, 
       SUM(`Total Rrec int_Y`) AS total_interest,
       SUM(`Total Pymnt_Y`) AS total_fees,
       SUM(`Total Rrec int_Y` + `Total Pymnt_Y`) AS total_revenue
FROM bank_data
GROUP BY `Branch Name_Y`;

#State-Wise Loan#

SELECT `State name_Y`, COUNT(*) AS total_loans
FROM bank_data
GROUP BY `State name_Y`;


#Religion-Wise Loan#

SELECT `Region Name_Y`, COUNT(*) AS total_loans
FROM bank_data
GROUP BY `Region Name_Y`;

#Product Group-Wise Loan#

SELECT `Product Code_Y`, COUNT(*) AS total_loans
FROM bank_data
GROUP BY `Product Code_Y`;

select * from bank_data;


#Grade-Wise Loan#

SELECT Grrade_Y, COUNT(*) AS total_loans
FROM bank_data
GROUP BY Grrade_Y;

#Count of Default Loan#

SELECT COUNT(*) AS `Is Default Loan_Y`
FROM bank_data
WHERE `Is Default Loan_Y` = 'Y';

 #Count of Delinquent Clients#

SELECT COUNT(DISTINCT `Client id_Y`) AS `Is Delinquent Loan_Y`
FROM bank_data
WHERE `Is Delinquent Loan_Y` = 'Y';

#Delinquent Loans Rate#

SELECT 
    (SUM(CASE WHEN `Is Delinquent Loan_Y` = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS delinquent_rate
FROM bank_data;

#Default Loan Rate#

SELECT 
    (SUM(CASE WHEN `Is Default Loan_Y` = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS default_rate
FROM bank_data;

#Loan Status-Wise Loan#

SELECT `Verification Status_Y`, COUNT(*) AS total_loans
FROM bank_data
GROUP BY `Verification Status_Y`;

#Age Group-Wise Loan#

SELECT `Age`, COUNT(*) AS total_loans
FROM bank_data
GROUP BY `Age` ;


#No Verified Loan#

SELECT COUNT(*) AS no_verified_loans
FROM bank_data
WHERE `Verification Status_Y` = 'Not Verified';


#Loan Maturity#

SELECT AVG(`Term_Y`) AS avg_maturity_period
FROM bank_data;