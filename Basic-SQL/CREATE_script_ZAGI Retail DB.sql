CREATE TABLE Vendor ( 
  VendorID CHAR(2) NOT NULL,
  VendorName VARCHAR(25) NOT NULL,
  PRIMARY KEY (VendorID) 
);

CREATE TABLE Category (
  CategoryID CHAR(2) NOT NULL,
  Categoryname VARCHAR(25) NOT NULL,
  PRIMARY KEY (CategoryID) 
);

CREATE TABLE Product ( 
  ProductID CHAR(3) NOT NULL,
  ProductName VARCHAR(25) NOT NULL,
  ProductPrice NUMERIC (7,2) NOT NULL,
  VendorID CHAR(2) NOT NULL,
  CategoryID CHAR(2) NOT NULL,
  PRIMARY KEY (ProductID),
  FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID),
  FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) 
);

CREATE TABLE Region (
  RegionID CHAR(3) NOT NULL,
  RegionName VARCHAR(25) NOT NULL,
  PRIMARY KEY (RegionID) 
);

CREATE TABLE Store (
  StoreId VARCHAR(3) NOT NULL,
  StoreZIP CHAR(5) NOT NULL,
  RegionID CHAR(3) NOT NULL,
  PRIMARY KEY (StoreID),
  FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

CREATE TABLE Customer (
  CustomerID CHAR(7) NOT NULL,
  CustomerName VARCHAR(15) NOT NULL,
  CustomerZIP CHAR(5) NOT NULL,
  PRIMARY KEY (CustomerID) 
);

CREATE TABLE SalesTransaction (
  TID VARCHAR(8) NOT NULL,
  CustomerID CHAR(7) NOT NULL,
  StoreID VARCHAR(3) NOT NULL,
  TDate DATE NOT NULL,
  PRIMARY KEY (TID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);

CREATE TABLE SoldVia (
  ProductID CHAR(3) NOT NULL,
  TID VARCHAR(8) NOT NULL,
  NoOfItems INT NOT NULL,
  PRIMARY KEY (ProductID, TID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
  FOREIGN KEY (TID) REFERENCES SalesTransaction(TID) 
); 