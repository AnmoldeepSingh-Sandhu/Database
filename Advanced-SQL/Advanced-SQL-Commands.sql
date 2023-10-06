
/* --------------------------------------------------------------------------------------------------
1. Display the TID, CustomerName, and TDate for sales transactions 
    involving a customer buying a product whose ProductName is Dura Boot. 
----------------------------------------------------------------------------------------------------*/
SELECT SalesTransaction.TID, CustomerName, TDate
FROM SalesTransaction, Customer, SoldVia, Product
WHERE Product.ProductID = SoldVia.ProductID 
		AND SoldVia.TID = SalesTransaction.TID
		AND SalesTransaction.CustomerID = Customer.CustomerID
		AND ProductName = 'Dura Boot';

/* --------------------------------------------------------------------------------------------------
2. Display the ProductID and ProductName of the cheapest product. 
----------------------------------------------------------------------------------------------------*/
SELECT ProductID, ProductName
FROM Product
WHERE ProductPrice = (SELECT MIN(ProductPrice) FROM Product);

/* --------------------------------------------------------------------------------------------------
3. Display the ProductID, ProductName, and VendorName for products 
    whose price is below the average price of all products. 
----------------------------------------------------------------------------------------------------*/
SELECT ProductID, ProductName, VendorName
FROM Product, Vendor
WHERE ProductPrice < (SELECT AVG(ProductPrice) FROM Product) AND Product.VendorID = Vendor.VendorID;

/* --------------------------------------------------------------------------------------------------
4. Display the CustomerName and the average of product price for each customer. 
----------------------------------------------------------------------------------------------------*/
SELECT CustomerName, AVG(ProductPrice) AS AvgPrice
FROM Customer, Product, SalesTransaction, SoldVia
WHERE Product.ProductID = SoldVia.ProductID 
		AND SoldVia.TID = SalesTransaction.TID
		AND SalesTransaction.CustomerID = Customer.CustomerID
GROUP BY CustomerName;

/* --------------------------------------------------------------------------------------------------
5. Display the CustomerName who purchased products having price greater 
    than the average of each customer purchase.
----------------------------------------------------------------------------------------------------*/
SELECT CustomerName
FROM Customer, Product, SalesTransaction, SoldVia
WHERE Product.ProductPrice > ALL (SELECT AVG(ProductPrice) AS AvgPrice
									FROM Customer, Product, SalesTransaction, SoldVia
									WHERE Product.ProductID = SoldVia.ProductID 
									AND SoldVia.TID = SalesTransaction.TID
									AND SalesTransaction.CustomerID = Customer.CustomerID
									GROUP BY CustomerName)
		AND Product.ProductID = SoldVia.ProductID 
		AND SoldVia.TID = SalesTransaction.TID
		AND SalesTransaction.CustomerID = Customer.CustomerID
GROUP BY CustomerName;



/* --------------------------------------------------------------------------------------------------
6. Display the ProductID for the product that has been sold the most 
    (i.e., that has been sold in the highest quantity). 
----------------------------------------------------------------------------------------------------*/
SELECT Product.ProductID
FROM Product, SoldVia
WHERE SoldVia.NoOfItems = (SELECT MAX(NoOfItems) FROM SoldVia) 
		AND Product.ProductID = SoldVia.ProductID;


/* --------------------------------------------------------------------------------------------------
7. Display the RegionID, RegionName, and number of stores in the region for all regions. 
    Sort the results by number of stores from greatest to least. 
----------------------------------------------------------------------------------------------------*/
SELECT Region.RegionID, RegionName, COUNT(StoreZIP) AS NoOfStores
FROM Region, Store
WHERE Region.RegionID = Store.RegionID
GROUP BY Region.RegionID, RegionName;


/* --------------------------------------------------------------------------------------------------
8. Retrieve the product ID, product name, and product price for each product that has 
    more than three items sold within all sales transactions or whose items were sold 
    in more than one sales transaction (Hint: UNION)
----------------------------------------------------------------------------------------------------*/
CREATE VIEW Products_more_than_3_sold AS 
SELECT ProductID, ProductName, ProductPrice 
FROM Product 
WHERE ProductID IN (SELECT ProductID
					FROM SoldVia 
					GROUP BY ProductID 
					HAVING SUM(NoOfItems) > 3); 


CREATE VIEW Products_in_multiple_trnsc AS 
SELECT ProductId, ProductName, ProductPrice 
FROM Product 
WHERE ProductId IN (SELECT ProductID 
					FROM SoldVia 
					GROUP BY ProductID 
					HAVING COUNT(*) > 1); 




SELECT * 
FROM Products_more_than_3_sold
UNION
SELECT *
FROM Products_in_multiple_trnsc;


/* --------------------------------------------------------------------------------------------------
9. Retrieve the product ID, product name, and product price for each product that has 
    more than three items sold within all sales transactions and whose items were sold 
    in more than one sales transaction. (Hint: INTERSECTS)
----------------------------------------------------------------------------------------------------*/
SELECT * 
FROM Products_more_than_3_sold
INTERSECT
SELECT *
FROM Products_in_multiple_trnsc;


/* --------------------------------------------------------------------------------------------------
10. Retrieve the product ID, product name, and product price for each product that has 
    more than three items sold within all sales transactions but whose items 
    were not sold in more than one sales transaction. (Hint: MINUS)
----------------------------------------------------------------------------------------------------*/
SELECT * 
FROM Products_more_than_3_sold
EXCEPT
SELECT *
FROM Products_in_multiple_trnsc;



/* --------------------------------------------------------------------------------------------------
11. Update the manager table so that table look like below:
-----------------------------------------------------------------------------------------------------
|   MANAGERID   |   MFNAME  |   MLNAME  |   MBDATE      |   MSALARY |   MBONUS  |   MRESBUILDINGID  |
|---------------|-----------|-----------|---------------|-----------|-----------|-------------------|
|   M12         |   Boris   |   Grant   |   01/04/1980  |   60000   |   -       |   B1              |
|   M23         |   Austin  |   Lee     |   02/05/1975  |   50000   |   5000    |   B2              |
|   M34         |   George  |   Sherman |   12/06/1978  |   52000   |   2000    |   B4              |
-----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------*/
ALTER TABLE Manager 
ADD CONSTRAINT fkresidesin 
FOREIGN KEY (MResBuildingId) REFERENCES Building (BuildingId); 

UPDATE Manager 
SET MResBuildingId = 'B1' 
WHERE ManagerId = 'M12';

UPDATE Manager 
SET MResBuildingId = 'B2' 
WHERE ManagerId = 'M23';

UPDATE Manager 
SET MResBuildingId = 'B4' 
WHERE ManagerId = 'M34';


/* --------------------------------------------------------------------------------------------------
12. Display the MFName, MLName, MSalary, MBDate, and number of buildings that the 
    manager manages for all managers with a salary less than $55,000.
----------------------------------------------------------------------------------------------------*/
SELECT MFName, MLName, MSalary, MBDate, COUNT(BuildingID) AS NoOfBuildings
FROM Manager M, Building B
WHERE M.ManagerID = B.BManagerID
		AND MSalary < 55000
GROUP BY MFName, MLName, MSalary, MBDate;


/* --------------------------------------------------------------------------------------------------
13. Display the BuildingID and AptNo, for all apartments leased by the corporate client WindyCT.
----------------------------------------------------------------------------------------------------*/
SELECT B.BuildingID, AptNo
FROM Building B, Apartment A, CorpClient CC
WHERE CCName = 'WindyCT'
		AND B.BuildingID = A.BuildingID
		AND A.CCID = CC.CCID;

/* --------------------------------------------------------------------------------------------------
14. Display the SMemberID and SMemberName of staff members cleaning apartments 
    rented by corporate clients whose corporate location is Chicago. Do not 
    display the same information more than once.
----------------------------------------------------------------------------------------------------*/
SELECT DISTINCT SM.SMemberID, SMemberName
FROM StaffMember SM,Cleaning C, Apartment A, CorpClient CC
WHERE CCLocation = 'Chicago'
		AND SM.SMemberID = C.SMemberID
		AND C.AptNo = A.AptNo
		AND A.CCID = CC.CCID;

/* --------------------------------------------------------------------------------------------------
15. Display the CCName of the client and the CCName of the client who referred it, 
    for every client referred by a client in the music industry.
----------------------------------------------------------------------------------------------------*/
SELECT CC1.CCName, CC2.CCName AS ReferredByName
FROM CorpClient CC1, CorpClient CC2
WHERE CC1.CCIDReferredBy = CC2.CCID
		AND CC2.CCIndustry = 'Music';

/* --------------------------------------------------------------------------------------------------
16. Display the BuildingID, AptNo, and ANoOfBedrooms for all apartments that are not leased.
----------------------------------------------------------------------------------------------------*/
SELECT  BuildingID, AptNo, ANoOfBedrooms
FROM Apartment A
WHERE CCID IS null;

