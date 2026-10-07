CREATE DATABASE BankDB;

USE BankDB;

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Account (
    Account_No INT PRIMARY KEY,
    Customer_ID INT,
    Account_Type VARCHAR(20),
    Balance DECIMAL(12,2),
    Branch VARCHAR(50),

    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID)
);

CREATE TABLE Bank_Transaction (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Account_No INT,
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(12,2),
    Transaction_Date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (Account_No)
    REFERENCES Account(Account_No)
);

CREATE TABLE Loan (
    Loan_ID INT PRIMARY KEY,
    Customer_ID INT,
    Loan_Type VARCHAR(30),
    Loan_Amount DECIMAL(12,2),
    Interest_Rate DECIMAL(5,2),

    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID)
);

INSERT INTO Customer
(Customer_ID, Customer_Name, Phone, Email, City)
VALUES
(101, 'Ravi Kumar', '9876543210',
 'ravi@gmail.com', 'Hyderabad'),

(102, 'Priya Sharma', '9876543211',
 'priya@gmail.com', 'Vijayawada'),

(103, 'Arjun Reddy', '9876543212',
 'arjun@gmail.com', 'Bangalore'),

(104, 'Sneha Rao', '9876543213',
 'sneha@gmail.com', 'Chennai'),

(105, 'Kiran Kumar', '9876543214',
 'kiran@gmail.com', 'Hyderabad'),

(106, 'Anil Kumar', '9876543215',
 'anil@gmail.com', 'Delhi'),

(107, 'Meena Reddy', '9876543216',
 'meena@gmail.com', 'Mumbai'),

(108, 'Rahul Sharma', '9876543217',
 'rahul@gmail.com', 'Pune'),

(109, 'Lakshmi Devi', '9876543218',
 'lakshmi@gmail.com', 'Hyderabad'),

(110, 'Suresh Babu', '9876543219',
 'suresh@gmail.com', 'Vijayawada');
 
 
INSERT INTO Account
(Account_No, Customer_ID, Account_Type, Balance, Branch)
VALUES
(10001, 101, 'Savings', 50000, 'Hyderabad'),

(10002, 102, 'Savings', 75000, 'Vijayawada'),

(10003, 103, 'Current', 120000, 'Bangalore'),

(10004, 104, 'Savings', 45000, 'Chennai'),

(10005, 105, 'Current', 90000, 'Hyderabad'),

(10006, 106, 'Savings', 65000, 'Delhi'),

(10007, 107, 'Current', 150000, 'Mumbai'),

(10008, 108, 'Savings', 35000, 'Pune'),

(10009, 109, 'Savings', 85000, 'Hyderabad'),

(10010, 110, 'Current', 110000, 'Vijayawada');

INSERT INTO Bank_Transaction
(Account_No, Transaction_Type, Amount)
VALUES
(10001, 'DEPOSIT', 10000),

(10001, 'WITHDRAW', 5000),

(10002, 'DEPOSIT', 15000),

(10003, 'WITHDRAW', 20000),

(10004, 'DEPOSIT', 5000),

(10005, 'WITHDRAW', 10000),

(10006, 'DEPOSIT', 12000),

(10007, 'DEPOSIT', 25000),

(10008, 'WITHDRAW', 5000),

(10009, 'DEPOSIT', 20000),

(10010, 'WITHDRAW', 15000);


INSERT INTO Loan
(Loan_ID, Customer_ID, Loan_Type,
 Loan_Amount, Interest_Rate)
VALUES
(501, 101, 'Home Loan', 5000000, 7.5),

(502, 102, 'Education Loan', 1000000, 6.5),

(503, 103, 'Car Loan', 800000, 8.2),

(504, 104, 'Personal Loan', 500000, 10.5),

(505, 105, 'Home Loan', 4000000, 7.2),

(506, 106, 'Car Loan', 900000, 8.5),

(507, 107, 'Business Loan', 3000000, 9.0),

(508, 109, 'Personal Loan', 600000, 10.0);

SELECT * FROM Customer;

SELECT * FROM Account;

SELECT * FROM Bank_Transaction;

SELECT * FROM Loan;

CREATE VIEW Customer_View AS
SELECT *
FROM Customer;

SELECT * FROM Customer_View;

CREATE VIEW Customer_Basic_View AS
SELECT
    Customer_ID,
    Customer_Name,
    City
FROM Customer;


SELECT * FROM Customer_Basic_View;

CREATE VIEW Account_View AS
SELECT
    Account_No,
    Account_Type,
    Balance,
    Branch
FROM Account;

SELECT * FROM Account_View;

CREATE VIEW Savings_Account_View AS
SELECT *
FROM Account
WHERE Account_Type = 'Savings';

SELECT * FROM Savings_Account_View;

CREATE VIEW Current_Account_View AS
SELECT *
FROM Account
WHERE Account_Type = 'Current';

SELECT * FROM Current_Account_View;

CREATE VIEW High_Balance_View AS
SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance
FROM Account
WHERE Balance > 100000;

SELECT * FROM High_Balance_View;

CREATE VIEW Hyderabad_Account_View AS
SELECT *
FROM Account
WHERE Branch = 'Hyderabad';

SELECT * FROM Hyderabad_Account_View;

CREATE VIEW Low_Balance_View AS
SELECT
    Account_No,
    Customer_ID,
    Balance
FROM Account
WHERE Balance < 50000;

SELECT * FROM Low_Balance_View;

CREATE VIEW Customer_Account_View AS
SELECT
    C.Customer_ID,
    C.Customer_Name,
    C.City,
    A.Account_No,
    A.Account_Type,
    A.Balance,
    A.Branch
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID;

SELECT * FROM Customer_Account_View;

CREATE VIEW Hyderabad_Customer_Accounts AS
SELECT
    C.Customer_Name,
    C.City,
    A.Account_No,
    A.Account_Type,
    A.Balance
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID
WHERE A.Branch = 'Hyderabad';

SELECT * FROM Hyderabad_Customer_Accounts;

CREATE VIEW Customer_Loan_View AS
SELECT
    C.Customer_ID,
    C.Customer_Name,
    C.City,
    L.Loan_ID,
    L.Loan_Type,
    L.Loan_Amount,
    L.Interest_Rate
FROM Customer C
JOIN Loan L
ON C.Customer_ID = L.Customer_ID;

SELECT * FROM Customer_Loan_View;


CREATE VIEW Customer_Banking_View AS
SELECT
    C.Customer_ID,
    C.Customer_Name,
    C.City,
    A.Account_No,
    A.Account_Type,
    A.Balance,
    A.Branch,
    L.Loan_Type,
    L.Loan_Amount
FROM Customer C
LEFT JOIN Account A
ON C.Customer_ID = A.Customer_ID
LEFT JOIN Loan L
ON C.Customer_ID = L.Customer_ID;

SELECT * FROM Customer_Banking_View;

CREATE VIEW Total_Bank_Balance AS
SELECT
    SUM(Balance) AS Total_Balance
FROM Account;

SELECT * FROM Total_Bank_Balance;

CREATE VIEW Average_Account_Balance AS
SELECT
    AVG(Balance) AS Average_Balance
FROM Account;

SELECT * FROM Average_Account_Balance;

CREATE VIEW Maximum_Balance_View AS
SELECT
    MAX(Balance) AS Maximum_Balance
FROM Account;

SELECT * FROM Maximum_Balance_View;

CREATE VIEW Minimum_Balance_View AS
SELECT
    MIN(Balance) AS Minimum_Balance
FROM Account;
SELECT * FROM Minimum_Balance_View;

CREATE VIEW Account_Count_View AS
SELECT
    COUNT(*) AS Total_Accounts
FROM Account;

SELECT * FROM Account_Count_View;

CREATE VIEW Branch_Account_Count AS
SELECT
    Branch,
    COUNT(*) AS Number_of_Accounts
FROM Account
GROUP BY Branch;

SELECT * FROM Branch_Account_Count;

CREATE VIEW Branch_Total_Balance AS
SELECT
    Branch,
    SUM(Balance) AS Total_Balance
FROM Account
GROUP BY Branch;

SELECT * FROM Branch_Total_Balance;

CREATE VIEW Account_Type_Count AS
SELECT
    Account_Type,
    COUNT(*) AS Number_of_Accounts
FROM Account
GROUP BY Account_Type;

SELECT * FROM Account_Type_Count;

CREATE VIEW Multiple_Account_Branches AS
SELECT
    Branch,
    COUNT(*) AS Number_of_Accounts
FROM Account
GROUP BY Branch
HAVING COUNT(*) > 1;
SELECT * FROM Multiple_Account_Branches;

CREATE VIEW Rich_Branches AS
SELECT
    Branch,
    SUM(Balance) AS Total_Balance
FROM Account
GROUP BY Branch
HAVING SUM(Balance) > 100000;

SELECT * FROM Rich_Branches;

CREATE VIEW Deposit_Transaction_View AS
SELECT *
FROM Bank_Transaction
WHERE Transaction_Type = 'DEPOSIT';

SELECT * FROM Deposit_Transaction_View;

CREATE VIEW Withdrawal_Transaction_View AS
SELECT *
FROM Bank_Transaction
WHERE Transaction_Type = 'WITHDRAW';

SELECT * FROM Withdrawal_Transaction_View;

CREATE VIEW Customer_Transaction_View AS
SELECT
    C.Customer_Name,
    A.Account_No,
    A.Account_Type,
    T.Transaction_ID,
    T.Transaction_Type,
    T.Amount,
    T.Transaction_Date
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID
JOIN Bank_Transaction T
ON A.Account_No = T.Account_No;

SELECT * FROM Customer_Transaction_View;

CREATE VIEW High_Value_Transaction_View AS
SELECT *
FROM Bank_Transaction
WHERE Amount > 10000;

SELECT * FROM High_Value_Transaction_View;

CREATE VIEW Balance_Ranking_View AS
SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance
FROM Account
ORDER BY Balance DESC;

SELECT * FROM Balance_Ranking_View;

CREATE VIEW Customer_Name_View AS
SELECT
    Customer_ID,
    Customer_Name,
    City
FROM Customer
ORDER BY Customer_Name;

SELECT * FROM Customer_Name_View;

CREATE VIEW Loan_Interest_View AS
SELECT
    Loan_ID,
    Customer_ID,
    Loan_Type,
    Loan_Amount,
    Interest_Rate,
    (Loan_Amount * Interest_Rate / 100)
        AS Annual_Interest
FROM Loan;

SELECT * FROM Loan_Interest_View;
CREATE VIEW Loan_Total_Amount_View AS
SELECT
    Loan_ID,
    Customer_ID,
    Loan_Type,
    Loan_Amount,
    Interest_Rate,
    Loan_Amount +
    (Loan_Amount * Interest_Rate / 100)
    AS Total_Amount
FROM Loan;

SELECT * FROM Loan_Total_Amount_View;

SELECT *
FROM High_Balance_View
WHERE Balance > 120000;

SELECT *
FROM Savings_Account_View
WHERE Balance > 60000;

SELECT *
FROM Hyderabad_Account_View
WHERE Balance > 50000;

SELECT *
FROM Customer_Basic_View
WHERE City = 'Hyderabad';

SELECT *
FROM Customer_Account_View
ORDER BY Balance DESC;

SELECT *
FROM Customer_Loan_View
WHERE Loan_Amount > 1000000;

UPDATE Account_View
SET Balance = 60000
WHERE Account_No = 10001;

SELECT *
FROM Account
WHERE Account_No = 10001;

CREATE VIEW Simple_Account_View AS
SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance,
    Branch
FROM Account;

INSERT INTO Simple_Account_View
VALUES
(10011, 101, 'Savings', 55000, 'Hyderabad');

SELECT *
FROM Account;

DELETE FROM Simple_Account_View
WHERE Account_No = 10011;

SELECT *
FROM Account;

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';

SHOW CREATE VIEW Customer_Account_View;
DESCRIBE Customer_Account_View;

DROP VIEW Customer_View;
DROP VIEW
Customer_Basic_View,
Savings_Account_View,
Current_Account_View;


DELIMITER //
CREATE PROCEDURE GetAllCustomers()
BEGIN
    SELECT * FROM Customer;
END //
DELIMITER ;

CALL GetAllCustomers();

DELIMITER //
CREATE PROCEDURE GetAccountDetails(
    IN p_Account_No INT
)
BEGIN
    SELECT *
    FROM Account
    WHERE Account_No = p_Account_No;
END //
DELIMITER ;

CALL GetAccountDetails(10001);


DELIMITER //
CREATE PROCEDURE GetCustomerAccounts(
    IN p_Customer_ID INT
)
BEGIN

    SELECT
        C.Customer_ID,
        C.Customer_Name,
        A.Account_No,
        A.Account_Type,
        A.Balance,
        A.Branch
    FROM Customer C
    JOIN Account A
    ON C.Customer_ID = A.Customer_ID
    WHERE C.Customer_ID = p_Customer_ID;
END //
DELIMITER ;

CALL GetCustomerAccounts(101);

DELIMITER //
CREATE PROCEDURE DepositMoney(
    IN p_Account_No INT,
    IN p_Amount DECIMAL(12,2)
)
BEGIN
    UPDATE Account
    SET Balance = Balance + p_Amount
    WHERE Account_No = p_Account_No;
END //
DELIMITER ;

CALL DepositMoney(10001, 5000);

DELIMITER //
CREATE PROCEDURE WithdrawMoney(
    IN p_Account_No INT,
    IN p_Amount DECIMAL(12,2)
)
BEGIN
    UPDATE Account
    SET Balance = Balance - p_Amount
    WHERE Account_No = p_Account_No;
END //
DELIMITER ;

CALL WithdrawMoney(10001, 3000);

DELIMITER //
CREATE TRIGGER CheckBalance
BEFORE UPDATE ON Account
FOR EACH ROW
BEGIN
    IF NEW.Balance < 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Transaction failed: Insufficient balance';
    END IF;
END //
DELIMITER ;


UPDATE Account
SET Balance = Balance - 60000
WHERE Account_No = 10001;

DELIMITER //
CREATE TRIGGER CheckTransactionAmount
BEFORE INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN
    IF NEW.Amount <= 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Transaction amount must be greater than zero';

    END IF;
END //
DELIMITER ;

INSERT INTO Bank_Transaction
(Account_No, Transaction_Type, Amount)
VALUES
(10001, 'DEPOSIT', -5000);


CREATE TABLE Transaction_Audit (
    Audit_ID INT PRIMARY KEY AUTO_INCREMENT,
    Transaction_ID INT,
    Account_No INT,
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(12,2),
    Audit_Date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER TransactionAudit
AFTER INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN

    INSERT INTO Transaction_Audit
    (
        Transaction_ID,
        Account_No,
        Transaction_Type,
        Amount
    )
    VALUES
    (
        NEW.Transaction_ID,
        NEW.Account_No,
        NEW.Transaction_Type,
        NEW.Amount
    );

END //
DELIMITER ;

INSERT INTO Bank_Transaction
(Account_No, Transaction_Type, Amount)
VALUES
(10001, 'DEPOSIT', 2500);

SELECT * FROM Transaction_Audit;

DELIMITER //
CREATE TRIGGER UpdateBalanceAfterTransaction
AFTER INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN
    IF NEW.Transaction_Type = 'DEPOSIT' THEN
        UPDATE Account
        SET Balance = Balance + NEW.Amount
        WHERE Account_No = NEW.Account_No;
    ELSEIF NEW.Transaction_Type = 'WITHDRAW' THEN
        UPDATE Account
        SET Balance = Balance - NEW.Amount
        WHERE Account_No = NEW.Account_No;

   END IF;
END //
DELIMITER ;

INSERT INTO Bank_Transaction
(Account_No, Transaction_Type, Amount)
VALUES
(10001, 'DEPOSIT', 5000);

SELECT *
FROM Account
WHERE Account_No = 10001;

DELIMITER //
CREATE TRIGGER PreventInsufficientWithdrawal
BEFORE INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN

    DECLARE CurrentBalance DECIMAL(12,2);

    SELECT Balance
    INTO CurrentBalance
    FROM Account
    WHERE Account_No = NEW.Account_No;

    IF NEW.Transaction_Type = 'WITHDRAW'
       AND NEW.Amount > CurrentBalance THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Withdrawal failed: Insufficient balance';

    END IF;

END //
DELIMITER ;

INSERT INTO Bank_Transaction
(Account_No, Transaction_Type, Amount)
VALUES
(10001, 'WITHDRAW', 1000000);

DELIMITER //
CREATE PROCEDURE TransferMoney(
    IN SenderAccount INT,
    IN ReceiverAccount INT,
    IN TransferAmount DECIMAL(12,2)
)
BEGIN

    DECLARE SenderBalance DECIMAL(12,2);

    SELECT Balance
    INTO SenderBalance
    FROM Account
    WHERE Account_No = SenderAccount;

    IF SenderBalance < TransferAmount THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Transfer failed: Insufficient balance';

    ELSE

        UPDATE Account
        SET Balance = Balance - TransferAmount
        WHERE Account_No = SenderAccount;

        UPDATE Account
        SET Balance = Balance + TransferAmount
        WHERE Account_No = ReceiverAccount;

    END IF;

END //
DELIMITER ;

CALL TransferMoney(10001, 10002, 5000);

SELECT *
FROM Account
WHERE Account_No IN (10001,10002);


DELIMITER //

CREATE PROCEDURE GetCustomerLoans(
    IN p_Customer_ID INT
)
BEGIN

    SELECT
        C.Customer_Name,
        L.Loan_ID,
        L.Loan_Type,
        L.Loan_Amount,
        L.Interest_Rate
    FROM Customer C
    JOIN Loan L
    ON C.Customer_ID = L.Customer_ID
    WHERE C.Customer_ID = p_Customer_ID;

END //
DELIMITER ;

CALL GetCustomerLoans(101);

DELIMITER //
CREATE PROCEDURE HighBalanceAccounts(
    IN MinimumBalance DECIMAL(12,2)
)
BEGIN

    SELECT *
    FROM Account
    WHERE Balance >= MinimumBalance
    ORDER BY Balance DESC;

END //

DELIMITER ;

CALL HighBalanceAccounts(50000);


DELIMITER //

CREATE PROCEDURE GetBalance(
    IN p_Account_No INT,
    OUT p_Balance DECIMAL(12,2)
)
BEGIN

    SELECT Balance
    INTO p_Balance
    FROM Account
    WHERE Account_No = p_Account_No;

END //

DELIMITER ;

CALL GetBalance(10001, @CurrentBalance);

SELECT @CurrentBalance;

SHOW TRIGGERS;
SHOW CREATE TRIGGER CheckBalance;

DROP TRIGGER CheckBalance;

SHOW PROCEDURE STATUS
WHERE Db = 'BankDB';
