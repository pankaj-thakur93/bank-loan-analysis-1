
#1. Total Credit Amount

SELECT SUM(Amount) AS Total_Credit_Amount
FROM credit_debit
WHERE `Transaction Type` = 'Credit';
#2. Total Debit Amount

SELECT SUM(Amount) AS Total_Debit_Amount
FROM credit_debit
WHERE `Transaction Type` = 'Debit';

#3. Credit to Debit Ratio

SELECT
    SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END) /
    SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 1 END) AS Credit_Debit_Ratio
FROM credit_debit;

#4. Net Transaction Amount

SELECT
    SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END) -
    SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END) AS Net_Transaction_Amount
FROM credit_debit;

#5. Account Activity Ratio

SELECT
    `Account Number`,
    COUNT(*) / MAX(Balance) AS Account_Activity_Ratio
FROM credit_debit
GROUP BY `Account Number`;

 

#6. Transactions per Day/Week/Month

-- Per Day
SELECT DATE(`Transaction Date`) AS Day, COUNT(*) AS Transactions
FROM credit_debit
GROUP BY DATE(`Transaction Date`);

-- Per Month
SELECT DATE_FORMAT(`Transaction Date`, '%Y-%m') AS Month, COUNT(*) AS Transactions
FROM credit_debit
GROUP BY DATE_FORMAT(`Transaction Date`, '%Y-%m');


#7. Total Transaction Amount by Branch

SELECT Branch, SUM(Amount) AS Total_Transaction_Amount
FROM credit_debit
GROUP BY branch;

#8. Transaction Volume by Bank

SELECT `Bank Name`, SUM(Amount) AS Total_Transaction_Amount
FROM credit_debit
GROUP BY `Bank Name`;

#9. Transaction Method Distribution

SELECT 
    `Transaction Method`, 
    COUNT(*) AS Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM credit_debit), 2) AS Percentage
FROM credit_debit
GROUP BY `Transaction Method`;



#10. Branch Transaction Growth

SELECT Branch,
       SUM(CASE WHEN YEAR(`Transaction Date`) = 2024 THEN Amount ELSE 0 END) AS Amount_2024,
       SUM(CASE WHEN YEAR(`Transaction Date`) = 2025 THEN Amount ELSE 0 END) AS Amount_2025,
       ROUND((
           SUM(CASE WHEN YEAR(`Transaction Date`) = 2025 THEN Amount ELSE 0 END) -
           SUM(CASE WHEN YEAR(`Transaction Date`) = 2024 THEN Amount ELSE 0 END)
       ) * 100.0 /
       NULLIF(SUM(CASE WHEN YEAR(`Transaction Date`) = 2024 THEN Amount ELSE 0 END), 0), 2) AS Growth_Percent
FROM credit_debit
GROUP BY Branch;

#11. High-Risk Transaction Flag



SELECT *,
       CASE
           WHEN Amount > 4000 THEN 'High-Risk'
           ELSE 'Normal'
       END AS Risk_Flag
FROM credit_debit;

#12. Suspicious Transaction Frequency

SELECT COUNT(*) AS Suspicious_Transaction_Count
FROM credit_debit
WHERE Amount > 4000;


