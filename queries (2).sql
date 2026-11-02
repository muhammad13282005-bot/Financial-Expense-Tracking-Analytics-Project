-- 1. Create Database
CREATE DATABASE financial_analytics_db;
-- 1. Database Select Karein
USE financial_analytics_db;

-- 3. Categories Table (Ab category_id PRIMARY KEY ke sath banegi)
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    transaction_type ENUM('Revenue', 'Expense') NOT NULL
);

-- 4. Budgets Table
CREATE TABLE Budgets (
    budget_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    budget_month DATE NOT NULL,
    allocated_budget DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

-- 5. Transactions Table
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_date DATE NOT NULL,
    category_id INT,
    amount DECIMAL(12,2) NOT NULL,
    description VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);






-- Categories Insert Karein
INSERT INTO Categories (category_name, transaction_type) VALUES
('Product Sales', 'Revenue'),
('Consulting Services', 'Revenue'),
('Salaries & Wages', 'Expense'),
('Marketing & Ads', 'Expense'),
('Office Rent & Utilities', 'Expense'),
('Software & IT Subscriptions', 'Expense'),
('Travel & Logistics', 'Expense');

-- Allocated Budgets Insert Karein (Year 2026 Monthly Budget)
INSERT INTO Budgets (category_id, budget_month, allocated_budget) VALUES
(1, '2026-02-03', 40000.00),
(2, '2026-02-02', 45000.00),
(3, '2026-02-01', 50000.00), 
(4, '2026-02-01', 16000.00), 
(5, '2026-02-01', 10000.00), 
(6, '2026-02-01', 5200.00), 
(7, '2026-02-01', 7500.00),  
(3, '2026-03-01', 50000.00),
(4, '2026-03-01', 18500.00), 
(5, '2026-03-01', 10000.00), 
(6, '2026-03-01', 4900.00),  
(7, '2026-03-01', 5800.00),  
(3, '2026-04-01', 50000.00), 
(4, '2026-04-01', 16000.00), 
(5, '2026-04-01', 10000.00), 
(6, '2026-04-01', 5100.00),  
(7, '2026-04-01', 6700.00);  

-- Actual Transactions Insert Karein
INSERT INTO Transactions (transaction_date, category_id, amount, description) VALUES
-- February 2026 Transactions
('2026-02-04', 1, 92000.00, 'Q1 Enterprise Product Sales'),
('2026-02-10', 2, 28000.00, 'Client Consulting Milestone'),
('2026-02-15', 3, 48000.00, 'February Staff Salaries'),
('2026-02-18', 4, 14000.00, 'Q1 Digital Marketing Ads'),
('2026-02-20', 5, 9500.00, 'February Office Rent & Utility'),
('2026-02-22', 6, 5200.00, 'Cloud Infrastructure & AWS Bill'),
('2026-02-25', 7, 7500.00, 'Client Visit Travel Expense'),

-- March 2026 Transactions
('2026-03-05', 1, 105000.00, 'Spring Product Sales Revenue'),
('2026-03-11', 2, 31000.00, 'Advisory Services Retainer'),
('2026-03-15', 3, 50000.00, 'March Staff Salaries'),
('2026-03-19', 4, 18500.00, 'Social Media Ad Campaign'),
('2026-03-21', 5, 9500.00, 'March Office Rent & Utility'),
('2026-03-23', 6, 4900.00, 'SaaS & Development Tools'),
('2026-03-27', 7, 5800.00, 'Onboarding Client Expenses'),

-- April 2026 Transactions
('2026-04-04', 1, 98000.00, 'April Product Sales Revenue'),
('2026-04-10', 2, 26000.00, 'Client Consulting Fee'),
('2026-04-15', 3, 50000.00, 'April Staff Salaries'),
('2026-04-18', 4, 16000.00, 'Brand Awareness Campaign'),
('2026-04-20', 5, 9500.00, 'April Office Rent & Utility'),
('2026-04-23', 6, 5100.00, 'AWS Cloud & Hosting Renewal'),
('2026-04-26', 7, 6700.00, 'Business Travel & Logistics');
--  Total Revenue aur Total Expense ki Summary
select SUM(Transactions.amount) AS Total_Revenue
FROM Transactions
JOIN Categories
ON Transactions.category_id=Categories.category_id
WHERE Categories.transaction_type = 'Revenue';
-- Category-wise Breakdown
select SUM(Transactions.amount) AS Total_Expense
FROM Transactions
JOIN Categories
ON Transactions.category_id=Categories.category_id
WHERE Categories.transaction_type = 'Expense';
--  Budget vs. Actual Comparison AND Monthly Trend Analysis 
select Categories.category_name,Transactions.amount
FROM Transactions
JOIN Categories
ON Transactions.category_id=Categories.category_id
WHERE Categories.transaction_type = 'Expense';


SELECT Budgets.budget_month, Budgets.allocated_budget,Transactions.amount ,Categories.category_name
FROM Transactions
JOIN Budgets ON Transactions.category_id = Budgets.category_id
JOIN Categories ON Transactions.category_id = Categories.category_id
WHERE Categories.transaction_type = 'Expense';






