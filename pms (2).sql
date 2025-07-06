DROP DATABASE IF EXISTS PHARMACY_MANAGEMENT_SYSTEM;
CREATE DATABASE PHARMACY_MANAGEMENT_SYSTEM;
USE PHARMACY_MANAGEMENT_SYSTEM;

CREATE TABLE Customer(
customer_id INT  AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
contact VARCHAR(20)  ,
email VARCHAR(50) NOT NULL,
address TEXT
);
INSERT INTO Customer ( name, contact, email, address) VALUES
( 'Ali Raza', '03001234567', 'ali.raza@example.com', 'Lahore, Punjab'),
( 'Ayesha Khan', '03111234567', 'ayesha.khan@example.com', 'Karachi, Sindh'),
( 'Usman Tariq', '03211234567', 'usman.tariq@example.com', 'Islamabad'),
( 'Fatima Zahra', '03331234567', 'fatima.zahra@example.com', 'Rawalpindi'),
( 'Ahmed Nawaz', '03451234567', 'ahmed.nawaz@example.com', 'Peshawar, KPK'),
( 'Hassan Javed', '03061234567', 'hassan.javed@example.com', 'Gujrat, Punjab'),
( 'Mariam Bukhari', '03161234567', 'mariam.bukhari@example.com', 'Sargodha, Punjab'),
( 'Zain Ali', '03261234567', 'zain.ali@example.com', 'Abbottabad, KPK'),
( 'Nida Irfan', '03361234567', 'nida.irfan@example.com', 'Sahiwal, Punjab'),
( 'Bilal Haider', '03461234567', 'bilal.haider@example.com', 'Mirpur, AJK');

-- alternate for synonym
-- METHOD # 01:
-- CREATE VIEW customer_details AS
-- SELECT * FROM Customer;

-- METHOD # 02:
-- SELECT * FROM Customer AS customer_details;
CREATE TABLE Supplier(
supplier_id INT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
contact VARCHAR(20),
email VARCHAR(50) NOT NULL,
address TEXT NOT NULL
);
INSERT INTO Supplier (supplier_id, name, contact, email, address) VALUES
(1, 'Hamza Traders', '03012345678', 'hamza.traders@pharmapak.com', 'Lahore, Punjab'),
(2, 'Medico Supplies', '03122345678', 'contact@medicosupplies.pk', 'Karachi, Sindh'),
(3, 'Health Plus', '03232345678', 'info@healthplus.pk', 'Islamabad'),
(4, 'Zahid Pharma', '03332345678', 'zahid@zahidpharma.com', 'Multan, Punjab'),
(5, 'Cure Medics', '03452345678', 'support@curemedics.pk', 'Faisalabad, Punjab'),
(6, 'Pharma Link', '03082345678', 'sales@pharmalink.pk', 'Sialkot, Punjab'),
(7, 'Al Shifa', '03152345678', 'info@alshifadist.com', 'Quetta, Balochistan'),
(8, 'MedZone Pvt Ltd', '03262345678', 'support@medzone.pk', 'Hyderabad, Sindh'),
(9, 'Sehat Pharma', '03362345678', 'contact@sehatpharma.com', 'Bahawalpur, Punjab'),
(10, 'Royal Medics', '03462345678', 'royal@royalmedics.pk', 'Gujranwala, Punjab');



CREATE TABLE Medicine(
medicine_id INT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
discription TEXT,
category VARCHAR(30) NOT NULL,
price DECIMAL(10,2), CHECK (price>0),
mgf_date DATE,
exp_date DATE DEFAULT '2025-01-12',
supplier_id INT ,
FOREIGN KEY (supplier_id) REFERENCES Supplier (supplier_id) 
ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO Medicine (medicine_id, name, discription, category, price, mgf_date, exp_date, supplier_id) VALUES
(1, 'Panadol Extra', 'Pain reliever and fever reducer', 'Analgesic', 35.00, '2024-01-15', '2026-01-14', 1),
(2, 'Augmentin ', 'Antibiotic for bacterial infections', 'Antibiotic', 480.00, '2023-11-10', '2025-11-09', 2),
(3, 'Brufen ', 'Used for pain, inflammation and fever', 'NSAID', 90.00, '2024-02-01', '2026-01-31', 3),
(4, 'Calpol', 'Syrup for fever and pain in children', 'Pediatric', 55.00, '2023-12-05', '2025-12-04', 4),
(5, 'Multivitamin Syrup', 'Vitamin supplement for children', 'Supplement', 150.00, '2024-03-01', '2026-03-01', 5),
(6, 'Inj. Diclofenac', 'NSAID for pain and inflammation', 'Injection', 120.00, '2024-01-10', '2026-01-09', 3),
(7, 'Inj. Ceftriaxone', 'Broad-spectrum antibiotic', 'Antibiotic Injection', 220.00, '2024-03-15', '2026-03-14', 4),
(8, 'Cetrizine ', 'Allergy relief tablet', 'Antihistamine', 25.00, '2024-04-10', '2026-04-09', 6),
(9, 'Metformin', 'For type 2 diabetes', 'Anti-Diabetic', 150.00, '2023-09-01', '2025-08-31', 7),
(10, 'ORS Sachets', 'Rehydration salts for dehydration', 'Electrolytes', 40.00, '2024-06-01', '2026-05-31', 10);
CREATE INDEX med_name ON Medicine (name);

ALTER TABLE Medicine 
ADD COLUMN quantity INT;
UPDATE Medicine SET quantity = 50 WHERE medicine_id = 1;
UPDATE Medicine SET quantity = 70 WHERE medicine_id = 2;
UPDATE Medicine SET quantity = 10 WHERE medicine_id = 3;
UPDATE Medicine SET quantity = 54 WHERE medicine_id = 4;
UPDATE Medicine SET quantity = 23 WHERE medicine_id = 5;
UPDATE Medicine SET quantity = 32 WHERE medicine_id = 6;
UPDATE Medicine SET quantity = 100 WHERE medicine_id = 7;
UPDATE Medicine SET quantity = 67 WHERE medicine_id = 8;
UPDATE Medicine SET quantity = 9 WHERE medicine_id = 9;
UPDATE Medicine SET quantity = 34 WHERE medicine_id = 10;

ALTER TABLE Medicine 
CHANGE discription description TEXT;

CREATE TABLE Tablet (
    medicine_id INT PRIMARY KEY,
    FOREIGN KEY(medicine_id) REFERENCES Medicine(medicine_id)
    ON DELETE CASCADE  ON UPDATE CASCADE,
    dosage_mg INT NOT NULL,
    tablet_type VARCHAR(30) NOT NULL
);
INSERT INTO Tablet (medicine_id, dosage_mg, tablet_type) VALUES
(1, 500, 'Tablet'),
(2, 625, 'Tablet'),
(3, 400, 'Tablet'),
(8, 10, 'Tablet'),
(9, 500, 'Tablet');



CREATE TABLE Syrup (
    medicine_id INT PRIMARY KEY,
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id) ON DELETE CASCADE ON UPDATE CASCADE,
    volume_ml INT NOT NULL,
    flavor VARCHAR(30)
);
INSERT INTO Syrup (medicine_id, volume_ml, flavor) VALUES
(4, 60, 'Strawberry'),
(5, 120, 'Mixed Fruit'),
(10, 200, 'Orange');    

CREATE TABLE Injection (
    medicine_id INT PRIMARY KEY REFERENCES Medicine(medicine_id)ON DELETE CASCADE ON UPDATE CASCADE,
    storage_temp DECIMAL(5,2) ,CHECK (storage_temp>=0),
    route VARCHAR(20)
);
INSERT INTO Injection (medicine_id, storage_temp, route) VALUES
(6, 25.00, 'IM'),
(7, 4.00, 'IV');

CREATE TABLE Employee(
employee_id INT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
contact VARCHAR(20) ,
email VARCHAR(50) NOT NULL
);
INSERT INTO Employee (employee_id, name, contact, email) VALUES
(1, 'Imran Ali', '03001234567', 'imran.ali@pharma.pk'),
(2, 'Sadia Anwar', '03111234567', 'sadia.anwar@pharma.pk'),
(3, 'Tariq Mehmood', '03211234567', 'tariq.mehmood@pharma.pk'),
(4, 'Nimra Hassan', '03331234567', 'nimra.hassan@pharma.pk'),
(5, 'Faisal Riaz', '03451234567', 'faisal.riaz@pharma.pk'),
(6, 'Kiran Malik', '03061234567', 'kiran.malik@pharma.pk'),
(7, 'Adnan Qureshi', '03161234567', 'adnan.qureshi@pharma.pk'),
(8, 'Rabia Shah', '03261234567', 'rabia.shah@pharma.pk'),
(9, 'Zubair Khan', '03361234567', 'zubair.khan@pharma.pk'),
(10, 'Hira Yousuf', '03461234567', 'hira.yousuf@pharma.pk');

CREATE TABLE Manager (
    employee_id INT PRIMARY KEY,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO Manager (employee_id) VALUES
(1);


CREATE TABLE Salesman (
    employee_id INT PRIMARY KEY,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO Salesman (employee_id)
SELECT employee_id FROM Employee
WHERE employee_id NOT IN (SELECT employee_id FROM Manager);
/*to check*/
-- SELECT Salesman.employee_id, Employee.name
-- FROM Salesman
-- JOIN Employee ON Salesman.employee_id = Employee.employee_id;


-- DROP TABLE Orders;
CREATE TABLE Orders(
order_id INT PRIMARY KEY,
order_date DATE DEFAULT(CURRENT_DATE()),
order_status VARCHAR(30) NOT NULL,
total_amount DECIMAL(10,2),
manager_id INT,
FOREIGN KEY (manager_id) REFERENCES Manager(employee_id)
ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO Orders (order_id, order_date, order_status, total_amount, manager_id) VALUES
(1, '2025-06-01', 'Completed', 1200.00, 1),
(2, '2025-06-02', 'Pending', 850.00, 1),
(3, '2025-06-03', 'Completed', 600.00, 1),
(4, '2025-06-04', 'Completed', 450.00, 1),
(5, '2025-06-05', 'Pending', 700.00, 1);

CREATE TABLE Order_item(
orderitem_id INT PRIMARY KEY,
order_id INT, 
FOREIGN KEY (order_id) REFERENCES Orders(order_id)
ON DELETE CASCADE ON UPDATE CASCADE ,
medicine_id INT,
FOREIGN KEY (medicine_id) REFERENCES Medicine (medicine_id)
ON DELETE CASCADE ON UPDATE CASCADE ,
quantity INT NOT NULL,
unit_price DECIMAL(10,2)
);
INSERT INTO Order_item (orderitem_id, order_id, medicine_id, quantity, unit_price) VALUES
(1, 1, 1, 5, 50.00),
(2, 1, 2, 10, 40.00),
(3, 2, 3, 7, 60.00),
(4, 3, 4, 3, 150.00),
(5, 4, 5, 8, 25.00),
(6, 5, 6, 2, 100.00);

CREATE TABLE Sales(
sale_id INT PRIMARY KEY,
customer_id INT ,
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id)
ON DELETE CASCADE ON UPDATE CASCADE ,
salesman_id INT,
FOREIGN KEY(salesman_id) REFERENCES Salesman (employee_id)
ON DELETE CASCADE ON UPDATE CASCADE,
sale_date DATE DEFAULT(CURRENT_DATE()) ,
total_amount DECIMAL(10,2) 
);

INSERT INTO Sales (sale_id, customer_id, salesman_id, sale_date, total_amount) VALUES
(1, 1, 2, '2025-06-01', 1200.00),
(2, 2, 4, '2025-06-02', 850.00),
(3, 3, 6, '2025-06-03', 600.00),
(4, 4, 7, '2025-06-04', 450.00),
(5, 5, 8, '2025-06-05', 700.00);

CREATE TABLE Payment_Method (
    method_id INT PRIMARY KEY,
    method_name VARCHAR(30) DEFAULT "Cash"
);
INSERT INTO Payment_Method (method_id, method_name) VALUES
(1, 'Cash'),
(2, 'Card'),
(3, 'Digital');

CREATE TABLE Payment(
    payment_id INT PRIMARY KEY,
    sale_id INT,  
    FOREIGN KEY (sale_id)REFERENCES Sales(sale_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
	method_id INT,
    FOREIGN KEY (method_id) REFERENCES Payment_Method(method_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    amount DECIMAL(10,2),
    payment_date DATE DEFAULT(CURRENT_DATE())
);
INSERT INTO Payment (payment_id, sale_id, method_id, amount, payment_date) VALUES
(1, 1, 2, 1200.00, '2025-06-01'),
(2, 2, 1, 850.00, '2025-06-02'),
(3, 3, 3, 600.00, '2025-06-03'),
(4, 4, 2, 450.00, '2025-06-04'),
(5, 5, 1, 700.00, '2025-06-05');

-- drop table Cash_Payment;

CREATE TABLE Cash_Payment (
    payment_id INT PRIMARY KEY,
    FOREIGN KEY(payment_id)REFERENCES Payment(payment_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO Cash_Payment (payment_id) VALUES
(2),
(5);

CREATE TABLE Card_Payment (
    payment_id INT PRIMARY KEY ,
    FOREIGN KEY(payment_id)REFERENCES Payment(payment_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    last_four_digit INT NOT NULL,
    card_type VARCHAR(20)
);
INSERT INTO Card_Payment (payment_id, last_four_digit, card_type) VALUES
(1, 1234, 'Visa'),
(4, 5678, 'MasterCard');

CREATE TABLE Digital_Payment (
    payment_id INT PRIMARY KEY ,
    FOREIGN KEY( payment_id) REFERENCES Payment(payment_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    payment_platform VARCHAR(30),
    order_id INT,
    FOREIGN KEY( order_id)REFERENCES Orders(order_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO Digital_Payment (payment_id, payment_platform, order_id) VALUES
(3, 'Easypaisa', 3);
SELECT * FROM Customer;
SELECT * FROM Tablet;
SELECT * FROM Supplier;
 
SELECT employee_id FROM Employee
WHERE employee_id NOT IN (SELECT employee_id FROM Manager);

ALTER TABLE Sales
MODIFY sale_date DATE DEFAULT(current_date());



SELECT Salesman.employee_id, Employee.name
FROM Salesman
JOIN Employee ON Salesman.employee_id = Employee.employee_id;

/*to check*/
/*SELECT Manager.employee_id, Employee.name
FROM Manager
JOIN Employee ON Manager.employee_id = Employee.employee_id;*/

SELECT* FROM Medicine 
WHERE NAME='Panadol Extra';

SELECT name, quantity
FROM Medicine
WHERE quantity < 10;

SELECT name, exp_date
FROM Medicine 
WHERE exp_date< CURRENT_DATE()+INTERVAL 30 DAY;

SELECT * FROM Medicine;

SELECT CONCAT('Order having order_id ',order_id,' is ', order_status) AS order_details
FROM Orders;
SELECT CONCAT(name ,' Contact ',contact,' Email ',email) AS Customer_info
FROM Employee;

SELECT DISTINCT address From Supplier;
SELECT name, quantity, price ,(quantity*price)AS Total_stock
FROM Medicine;

SELECT name, quantity, price
FROM Medicine 
WHERE price>200;

SELECT name, quantity, price
FROM Medicine 
WHERE price>100 AND quantity>30;

SELECT name, quantity, price
FROM Medicine 
WHERE price>100 AND quantity>30;

SELECT name, quantity, price
FROM Medicine 
WHERE price>150 OR quantity>34;

SELECT name, quantity, price
FROM Medicine 
WHERE price BETWEEN 150 AND 500;

SELECT name, category, quantity
FROM Medicine
WHERE (category = 'Antibiotic' OR category = 'Pediatric')
  AND quantity > 30;

SELECT name, price
FROM Medicine 
WHERE price>ALL(
SELECT price
FROM Medicine 
WHERE category='syrup'
);

SELECT name, price
FROM Medicine 
WHERE price>ANY(
SELECT price
FROM Medicine 
WHERE Medicine_id IN (SELECT medicine_id FROM Tablet)
);

SELECT name
FROM Customer c
WHERE EXISTS (
SELECT 1
FROM sales s
WHERE s.customer_id=c.customer_id
);

SELECT name, CONVERT(price, CHAR) AS price_text
FROM Medicine;

SELECT name,exp_date,LAST_DAY(exp_date)
AS month_end
FROM Medicine;

SELECT name ,mgf_date, exp_date, TIMESTAMPDIFF(MONTH,mgf_date,exp_date)
AS medicine_lifetime
FROM Medicine;

SELECT 
    MAX(amount) AS Max_Payment,
    MIN(amount) AS Min_Payment,
    AVG(amount) AS Avg_Payment
FROM Payment;

SELECT 
    SUM(total_amount) AS Total_Orders_Amount
FROM Orders;

-- joins

SELECT 
    m.medicine_id,
    m.name AS medicine_name,
    m.price,
    s.supplier_id,
    s.name AS supplier_name,
    s.contact
FROM Medicine m
INNER JOIN Supplier s 
ON m.supplier_id = s.supplier_id;


SELECT o.order_id, o.total_amount, e.name AS manager_name
FROM Orders o
LEFT JOIN Manager m ON o.manager_id = m.employee_id
LEFT JOIN Employee e ON m.employee_id = e.employee_id;

SELECT o.order_id, o.total_amount, e.name AS manager_name
FROM Orders o
RIGHT JOIN Manager m ON o.manager_id = m.employee_id
RIGHT JOIN Employee e ON m.employee_id = e.employee_id;


SELECT 
    s.sale_id,
    s.customer_id,
    s.sale_date,
    s.total_amount AS sale_amount,
    p.payment_id,
    p.amount AS payment_amount,
    p.payment_date
FROM Sales s
LEFT JOIN Payment p ON s.sale_id = p.sale_id
UNION
SELECT 
    s.sale_id,
    s.customer_id,
    s.sale_date,
    s.total_amount AS sale_amount,
    p.payment_id,
    p.amount AS payment_amount,
    p.payment_date
FROM Payment p
LEFT JOIN Sales s ON p.sale_id = s.sale_id
WHERE s.sale_id IS NULL;

SELECT 
    category,
    AVG(price) AS avg_price
FROM Medicine
GROUP BY category
HAVING avg_price > 100;

SELECT 
    e.name AS salesman_name,
    SUM(s.total_amount) AS total_sales
FROM Sales s
JOIN Employee e ON s.salesman_id = e.employee_id
GROUP BY e.name;

SELECT * FROM Orders
ORDER BY order_date DESC;

CREATE VIEW Expiring_Medicines AS
SELECT 
    medicine_id,
    name AS medicine_name,
    exp_date
FROM 
    Medicine
WHERE 
    exp_date <= DATE_ADD(CURDATE(), INTERVAL 6 MONTH);

SELECT * FROM Expiring_Medicines;

DROP VIEW IF EXISTS Expiring_Medicines;

-- ALTERNATE FOR SYNONYM:
SELECT * FROM customer_details;

SHOW TABLE STATUS WHERE Name = 'Medicine';

START TRANSACTION;
SAVEPOINT first_transaction;
UPDATE Medicine SET price=200 WHERE medicine_id=1;

ROLLBACK TO first_transaction;
COMMIT;
-- SET autocommit = 0;
-- START TRANSACTION;
-- UPDATE Medicine SET price=100 WHERE medicine_id=1;

-- ROLLBACK ;
-- COMMIT;
SHOW TABLE STATUS LIKE 'Medicine';
SHOW CREATE TABLE Medicine;

BEGIN;
DELETE FROM Medicine WHERE medicine_id=1;
SELECT * FROM Medicine WHERE medicine_id=1;  -- EMPTY ROW TEMPORARY DELETED
ROLLBACK;
COMMIT;
SELECT * FROM Medicine WHERE medicine_id=1;    -- DATA RESTORED

