
/* --------------------------------------------------------------------------------------------------
1. Retrieve the entire contents of the relation PRODUCT. 
----------------------------------------------------------------------------------------------------*/
SELECT *
FROM Product;

/* --------------------------------------------------------------------------------------------------
2. Display the VendorID and VendorName for all vendors.
----------------------------------------------------------------------------------------------------*/
SELECT VendorID, VendorName
FROM Vendor;

/* --------------------------------------------------------------------------------------------------
3. Display the CustomerName and CustomerZip for all customers. 
----------------------------------------------------------------------------------------------------*/
SELECT CustomerName, CustomerZip
FROM Customer;

/* --------------------------------------------------------------------------------------------------
4. Retrieve the entire contents of the relation PRODUCT and show the columns in the following order:
ProductName, ProductID, VendorID, CategoryID, ProductPrice. 
----------------------------------------------------------------------------------------------------*/
SELECT ProductName, ProductID, VendorID, CategoryID, ProductPrice
FROM Product;

/* --------------------------------------------------------------------------------------------------
5. For the table PRODUCT, show the columns ProductID and ProductPrice and a column showing
ProductPrice increased by 40% (Multiply ProductPrice by 1.40). 
----------------------------------------------------------------------------------------------------*/
SELECT ProductID, ProductPrice, ProductPrice*1.40 AS "ProductPrice increased by 40%"
FROM Product;

/* --------------------------------------------------------------------------------------------------
6. Display the ProductID, ProductName, and ProductPrice for products with a ProductPrice of $100 or
higher. 
----------------------------------------------------------------------------------------------------*/
SELECT ProductID, ProductName, VendorID, ProductPrice
FROM Product
WHERE ProductPrice >= 100;

/* --------------------------------------------------------------------------------------------------
7. Retrieve the product ID, ProductName, VendorID, CategoryId, and ProductPrice of products of the FW
category whose price is equal to or below $200 (Hint: two conditions in WHERE clause).
----------------------------------------------------------------------------------------------------*/
SELECT ProductID, ProductName, VendorID, CategoryId, ProductPrice
FROM Product
WHERE CategoryId = 'FW' AND ProductPrice <= 200;

/* --------------------------------------------------------------------------------------------------
8. Display the VendorID of all vendors that we have a product from them. In the result, we must not see duplicate vendorIDs. 
For example, if we have 5 products from 1 vendor, we must see the vendorID of that vendor only one time not 5 times.  
----------------------------------------------------------------------------------------------------*/
SELECT VendorId
FROM Product
GROUP  BY VendorId;

/* --------------------------------------------------------------------------------------------------
9. Retrieve the average price of all products. (Hint: AVG).
----------------------------------------------------------------------------------------------------*/
SELECT AVG(ProductPrice) AS "Average Price"
FROM Product;

/* --------------------------------------------------------------------------------------------------
10. Show how many products are there for sale. (Hint: COUNT) 
----------------------------------------------------------------------------------------------------*/
SELECT COUNT(ProductName) AS "Number of Products"
FROM Product;

/* --------------------------------------------------------------------------------------------------
11. Count how many distinct vendors are there in the product table. (Hint: you must get the answer 4)
----------------------------------------------------------------------------------------------------*/
SELECT COUNT(DISTINCT VendorID) AS "Number of Vendors"
FROM Product;

/* --------------------------------------------------------------------------------------------------
12. Retrieve the number of products, average product price, lowest product price, and highest product
price in the CP product category. 
----------------------------------------------------------------------------------------------------*/
SELECT COUNT(ProductName) AS "Number of Products", AVG(ProductPrice) AS "Average Price", MIN(ProductPrice) AS "Lowest Price", MAX(ProductPrice) AS "Highest Price"
FROM Product
WHERE CategoryId = 'CP';

/* --------------------------------------------------------------------------------------------------
13. Retrieve the product ID, product name, category ID, and product price for each product of the FW
product category, sorted by product price in descending order.
----------------------------------------------------------------------------------------------------*/
SELECT ProductID, ProductName, CategoryId, ProductPrice
FROM Product
WHERE CategoryId = 'FW'
ORDER BY ProductPrice DESC; 

/* --------------------------------------------------------------------------------------------------
Query 14.	For each product, retrieve the ProductID, and the total number of product items sold within all transactions. 
(Hint: transactions can be found in SoldVia table. NoOfItems attribute holds how many items sold in one transaction, but 
we need to find the total sold of a product in all transactions. See the table below for your reference).
We need the heading of the columns be exactly "PRODUCTID" and "Total Sold" as you can see below. 
----------------------------------------------------------------------------------------------------*/
SELECT ProductID AS PRODUCTID, SUM(NoOfItems) AS "Total Sold"
FROM SoldVia
GROUP BY ProductID;


/* --------------------------------------------------------------------------------------------------
15. For each vendor, retrieve the VendorId, number of products supplied by the vendor, and average
price of the products supplied by the vendor. 
----------------------------------------------------------------------------------------------------*/
SELECT VendorID, Count(ProductID) AS "Number of Products", AVG(ProductPrice) AS "Average Price"
FROM Product
GROUP BY VendorId;

/* --------------------------------------------------------------------------------------------------
16. Retrieve all attributes of products whose name starts with 'Tiny', for example, 'Tiny Tent' 
----------------------------------------------------------------------------------------------------*/
SELECT *
FROM Product
WHERE ProductName LIKE 'Tiny%';

/* --------------------------------------------------------------------------------------------------
17. Display the ProductID, ProductName, and ProductPrice for products in the category whose
CategoryID value is 'CP'. Sort the results by ProductID. 
----------------------------------------------------------------------------------------------------*/
SELECT ProductID, ProductName, ProductPrice
FROM Product
WHERE CategoryID = 'CP'
ORDER BY ProductID;

/* --------------------------------------------------------------------------------------------------
18. Query 18.	Display the transaction ID (TID) and the total number of items sold in that transaction 
(of all products) that the total number of items (of all products) sold in that transaction is greater 
than five. In other words, we want to get the sample result as follows. We need the heading of the columns
be exactly ‘TID’ and ‘Total Items Sold’ as you can see below.
----------------------------------------------------------------------------------------------------*/
SELECT TID, SUM(NoOfItems) AS "Total Items Sold"
FROM SoldVia
GROUP BY TID
HAVING SUM(NoOfItems) > 5;


/* --------------------------------------------------------------------------------------------------
19. Display all RegionIDs and number of stores in their region.
----------------------------------------------------------------------------------------------------*/
SELECT RegionID, COUNT(StoreId) AS "Number Of Stores"
FROM Store
GROUP BY RegionID;


/* --------------------------------------------------------------------------------------------------
20. Display RegionID and number of Stores in regions that number of stores in their region is 4 or more
----------------------------------------------------------------------------------------------------*/
SELECT RegionID, COUNT(StoreId) AS "Number Of Stores"
FROM Store
GROUP BY RegionID
HAVING COUNT(StoreId) >= 4;
