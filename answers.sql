-- Create the normalized tables to satisfy 1NF

-- 1. First, create the Orders table to store order information
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- 2. Create the OrderProducts table to store one product per row
CREATE TABLE OrderProducts (
    OrderProductID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    Product VARCHAR(100) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- 3. Insert the order data into the normalized tables
INSERT INTO Orders (OrderID, CustomerName)
VALUES 
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- 4. Insert the products with one product per row
INSERT INTO OrderProducts (OrderID, Product)
VALUES 
    (101, 'Laptop'),
    (101, 'Mouse'),
    (102, 'Tablet'),
    (102, 'Keyboard'),
    (102, 'Mouse'),
    (103, 'Phone');

-- QUESTION 2 SECOND NORMAL FORM (2NF)


-- Step 1: Create the Orders table to store order-level information
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Step 2: Create the OrderProducts table to store product-level information
CREATE TABLE OrderProducts (
    OrderID INT NOT NULL,
    Product VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- Step 3: Insert data into the normalized tables
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Then insert all products into OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;