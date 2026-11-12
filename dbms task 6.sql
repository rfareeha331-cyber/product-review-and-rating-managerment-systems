-- ============================================
-- WEEK 6: PRODUCT REVIEW AND RATING MANAGEMENT
-- COMPLETE MYSQL WORKBENCH SCRIPT
-- ============================================

CREATE DATABASE IF NOT EXISTS Ecommerce_Week6;
USE Ecommerce_Week6;

-- 1. CUSTOMER TABLE

CREATE TABLE IF NOT EXISTS Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL
);

-- 2. PRODUCT TABLE

CREATE TABLE IF NOT EXISTS Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL
);

-- 3. INSERT CUSTOMER DATA

INSERT IGNORE INTO Customer VALUES
(1, 'John'),
(2, 'Priya'),
(3, 'David'),
(4, 'Rahul');

-- 4. INSERT PRODUCT DATA

INSERT IGNORE INTO Product VALUES
(1, 'Laptop'),
(2, 'Mobile'),
(3, 'Headphones'),
(4, 'Smart Watch');

-- 5. CREATE REVIEW TABLE

CREATE TABLE IF NOT EXISTS Review (
    Review_ID VARCHAR(10) PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Rating INT NOT NULL,
    Review_Text VARCHAR(500),
    Review_Date DATE NOT NULL,

    CHECK (Rating BETWEEN 1 AND 5),

    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID),

    FOREIGN KEY (Product_ID)
    REFERENCES Product(Product_ID)
);

-- 6. INSERT REVIEW DATA

INSERT IGNORE INTO Review VALUES
('R101', 1, 1, 5, 'Excellent performance', '2026-11-01'),
('R102', 2, 2, 4, 'Good battery life', '2026-11-02'),
('R103', 3, 1, 5, 'Very useful product', '2026-11-03'),
('R104', 1, 3, 3, 'Average quality', '2026-11-04'),
('R105', 2, 3, 2, 'Needs improvement', '2026-11-05'),
('R106', 3, 2, 5, 'Excellent quality', '2026-11-06'),
('R107', 4, 4, 4, 'Good product', '2026-11-07');

-- 7. DISPLAY ALL REVIEWS

SELECT * FROM Review;

-- 8. UPDATE REVIEW

UPDATE Review
SET Review_Text = 'Excellent product and quality'
WHERE Review_ID = 'R101';

-- 9. DELETE REVIEW
-- Uncomment to execute:
-- DELETE FROM Review WHERE Review_ID = 'R105';

-- 10. DISPLAY PRODUCT REVIEWS

SELECT
P.Product_Name,
R.Rating,
R.Review_Text,
R.Review_Date
FROM Product P
JOIN Review R
ON P.Product_ID = R.Product_ID;

-- 11. CUSTOMER NAME WITH REVIEWS

SELECT
C.Customer_Name,
P.Product_Name,
R.Rating,
R.Review_Text,
R.Review_Date
FROM Review R
JOIN Customer C
ON R.Customer_ID = C.Customer_ID
JOIN Product P
ON R.Product_ID = P.Product_ID;

-- 12. PRODUCTS HAVING MAXIMUM REVIEWS

SELECT
P.Product_Name,
COUNT(R.Review_ID) AS Total_Reviews
FROM Product P
LEFT JOIN Review R
ON P.Product_ID = R.Product_ID
GROUP BY P.Product_ID, P.Product_Name
ORDER BY Total_Reviews DESC;

-- 13. RECENT CUSTOMER FEEDBACK

SELECT *
FROM Review
ORDER BY Review_Date DESC;

-- 14. RATINGS ABOVE 4

SELECT *
FROM Review
WHERE Rating > 4;

-- 15. AVERAGE PRODUCT RATINGS

SELECT
P.Product_Name,
ROUND(AVG(R.Rating), 2) AS Average_Rating
FROM Product P
LEFT JOIN Review R
ON P.Product_ID = R.Product_ID
GROUP BY P.Product_ID, P.Product_Name;

-- 16. COUNT REVIEWS PER PRODUCT

SELECT
P.Product_Name,
COUNT(R.Review_ID) AS Total_Reviews
FROM Product P
LEFT JOIN Review R
ON P.Product_ID = R.Product_ID
GROUP BY P.Product_ID, P.Product_Name;

-- 17. HIGHEST RATED PRODUCTS

SELECT
P.Product_Name,
ROUND(AVG(R.Rating), 2) AS Average_Rating
FROM Product P
JOIN Review R
ON P.Product_ID = R.Product_ID
GROUP BY P.Product_ID, P.Product_Name
ORDER BY Average_Rating DESC;

-- 18. PRODUCTS WITH AVERAGE RATING ABOVE 4

SELECT
P.Product_Name,
ROUND(AVG(R.Rating), 2) AS Average_Rating
FROM Product P
JOIN Review R
ON P.Product_ID = R.Product_ID
GROUP BY P.Product_ID, P.Product_Name
HAVING AVG(R.Rating) > 4;

-- 19. REPORT 1: PRODUCT RATING ANALYSIS

SELECT
P.Product_Name,
COUNT(R.Review_ID) AS Number_of_Reviews,
ROUND(AVG(R.Rating), 2) AS Average_Rating
FROM Product P
LEFT JOIN Review R
ON P.Product_ID = R.Product_ID
GROUP BY P.Product_ID, P.Product_Name;

-- 20. REPORT 2: MOST REVIEWED PRODUCTS

SELECT
P.Product_Name,
COUNT(R.Review_ID) AS Total_Reviews
FROM Product P
LEFT JOIN Review R
ON P.Product_ID = R.Product_ID
GROUP BY P.Product_ID, P.Product_Name
ORDER BY Total_Reviews DESC;

-- 21. REPORT 2: HIGHLY RATED PRODUCTS

SELECT
P.Product_Name,
ROUND(AVG(R.Rating), 2) AS Average_Rating
FROM Product P
JOIN Review R
ON P.Product_ID = R.Product_ID
GROUP BY P.Product_ID, P.Product_Name
HAVING AVG(R.Rating) >= 4;

-- 22. REPORT 2: PRODUCTS NEEDING IMPROVEMENT

SELECT
P.Product_Name,
ROUND(AVG(R.Rating), 2) AS Average_Rating
FROM Product P
JOIN Review R
ON P.Product_ID = R.Product_ID
GROUP BY P.Product_ID, P.Product_Name
HAVING AVG(R.Rating) < 3;

-- 23. REPORT 3: RATING DISTRIBUTION

SELECT
Rating,
COUNT(*) AS Total_Ratings
FROM Review
GROUP BY Rating
ORDER BY Rating DESC;

-- 24. COUNT 5 STAR RATINGS

SELECT COUNT(*) AS Five_Star_Ratings
FROM Review
WHERE Rating = 5;

-- 25. COUNT 4 STAR RATINGS

SELECT COUNT(*) AS Four_Star_Ratings
FROM Review
WHERE Rating = 4;

-- 26. COUNT LOW RATED REVIEWS

SELECT COUNT(*) AS Low_Rated_Reviews
FROM Review
WHERE Rating <= 2;

-- 27. FINAL TABLE DISPLAY

SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Review;

-- ============================================
-- WEEK 6 COMPLETED
-- ============================================