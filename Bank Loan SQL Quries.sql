SELECT * FROM bank_loan_data

--Total Loan Applications
SELECT COUNT(id) AS Total_Loan_Application 
FROM bank_loan_data


--MTD Loan Applications
SELECT COUNT(id) AS MTD_Loan_Application 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 --FOR 12th Month


--PMTD Loan Applications
SELECT COUNT(id) AS PMTD_Loan_Application 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 --For 11th Month


--Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data


--MTD Total Funded Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


--PMTD Total Funded Amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM bank_loan_data 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


--Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data 

--MTD Total Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM bank_loan_data 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


--PMTD Total Funded Amount
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM bank_loan_data 
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


--Average Interest Rate
SELECT ROUND(AVG(int_rate)*100,2) AS Average_Interest_Rate
FROM bank_loan_data 

--MTD Average Interest Rate
SELECT ROUND(AVG(int_rate)*100,2) AS MTD_Average_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


--PMT Average Interest Rate
SELECT ROUND(AVG(int_rate)*100,2) AS PMT_Average_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


--Average DTI
SELECT ROUND(AVG(dti)*100,2) AS Average_DTI
FROM bank_loan_data 

--MTD Average Interest Rate
SELECT ROUND(AVG(dti)*100,2) AS MTD_Average_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


--PMT Average Interest Rate
SELECT ROUND(AVG(dti)*100,2) AS PMT_Average_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


---GOOD LOAN ISSUED
--Good Loan Percentage
SELECT 
	(COUNT (CASE WHEN 
	loan_status = 'Fully Paid' OR loan_status = 'Current' 
	THEN id
	END)*100)
	/
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data


--Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current' 


--Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current' 



---BAD LOAN ISSUED
--Bad Loan Percentage
SELECT 
	(COUNT (CASE WHEN 
	loan_status = 'Charged Off'
	THEN id
	END) * 100.0)
	/
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data


--Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Charged Off' 


--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Charged Off'



---LOAN STATUS

SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
FROM bank_loan_data
GROUP BY loan_status


SELECT 
loan_status,
SUM(total_payment) AS MTD_Total_Amount_Received,
SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status



---BANK LOAN REPORT | OVERVIEW
SELECT
	MONTH(issue_date) AS Month_Number,
	DATENAME(MONTH, issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)



--STATE
SELECT
	address_state,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state


--TERM
SELECT
	term,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term


--EMPLOYEE LENGTH
SELECT
	emp_length,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length


--PURPOSE
SELECT
	purpose,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC


--HOME OWNERSHIP
SELECT
	home_ownership,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC


--GRADE
SELECT
	home_ownership,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY home_ownership
ORDER BY COUNT(id) DESC