USE [master]
RESTORE DATABASE [AdventureWorks2016] FROM  DISK = N'C:\temp\AdventureWorks2016.bak' WITH  FILE = 1,  
MOVE N'AdventureWorks2016_Data' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2016_Data.mdf',  
MOVE N'AdventureWorks2016_Log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2016_Log.ldf', 
NOUNLOAD,  STATS = 5

GO

USE AdventureWorks2016
GO

SELECT NationalIDNumber
,LoginID
,OrganizationNode
,OrganizationLevel
,JobTitle
,BirthDate
,MaritalStatus
,Gender
,HireDate
,SalariedFlag
,VacationHours
,SickLeaveHours
,CurrentFlag
,rowguid
,ModifiedDate
FROM HumanResources.Employee;


SELECT LoginID, BirthDate
FROM HumanResources.Employee
WHERE BirthDate >= '1980-01-01';

SELECT LoginID, BirthDate
FROM HumanResources.Employee
WHERE BirthDate >='1980-01-01' AND BirthDate <'1981-01-01';

SELECT *
FROM HumanResources.Employee
WHERE BirthDate >='1980-01-01' AND BirthDate <'1981-01-01'
AND Gender='M';

SELECT JobTitle, BirthDate, Gender, VacationHours
FROM HumanResources.Employee
WHERE (Gender = 'M' AND VacationHours BETWEEN 90 AND 99
OR Gender = 'F' AND VacationHours BETWEEN 80 AND 89)
AND BirthDate >= '1990-01-01';

SELECT *
FROM HumanResources.Employee
WHERE JobTitle IN ('Marketing Specialist'
,'Control Specialist'
,'Benefits Specialist'
,'Accounts Receivable Specialist');

WHERE 2


SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE '%Specialist%';

SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE '%Specialist%' OR JobTitle LIKE '%Marketing%';

SELECT *
FROM Production.Product
WHERE Name Like '%[0-9]%';

SELECT *
FROM Production.Product
WHERE Name Like '%[0-9][0-9]%';

SELECT *
FROM Production.Product
WHERE Name Like '%[0-9][0-9]%[^0-9]';

SELECT *
FROM Production.Product
WHERE Name Like '____';

--Dzialania na kolumnach

SELECT UnitPrice, OrderQty, UnitPrice * OrderQty Total
FROM Sales.SalesOrderDetail;

SELECT UnitPrice, UnitPriceDiscount, OrderQty, (UnitPrice - UnitPriceDiscount) * OrderQty TotalWithDiscount
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0
ORDER BY UnitPriceDiscount DESC;

SELECT CardType, CardNumber, CardType + ':' + CardNumber [CardType and CardNumber]
FROM Sales.CreditCard;

SELECT 
	SalesOrderNumber 
	,PurchaseOrderNumber
	,SalesOrderNumber+'-'+PurchaseOrderNumber [Sales And Purchase Order Number]
FROM Sales.SalesOrderHeader;

SELECT SalesOrderNumber, PurchaseOrderNumber, CONCAT(SalesOrderNumber, '-', PurchaseOrderNumber)
FROM Sales.SalesOrderHeader;

SELECT 
	SalesOrderNumber
	,ProductID
	,UnitPrice
	,TaxAmt
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
ON h.SalesOrderID = d.SalesOrderID;


SELECT 
	sod.ProductID
	,sod.SalesOrderID
	,sod.OrderQty * sod.UnitPrice AS Total
FROM Sales.SalesOrderDetail sod
WHERE sod.OrderQty * sod.UnitPrice > 10000
ORDER BY ZADANIA

SELECT *
FROM HumanResources.Employee
ORDER BY BirthDate ASC;

SELECT *
FROM HumanResources.Employee
ORDER BY BirthDate DESC;

SELECT*, YEAR(GETDATE()) - YEAR(e.BirthDate) AS Age
FROM HumanResources.Employee e
ORDER BY Age DESC;

SELECT 
	p.ProductId
	,p.Name 
	,p.ListPrice 
	,p.Class
	,p.Style
	,p.Color
FROM Production.Product p
ORDER BY Class, Style;

SELECT 
	p.ProductId
	,p.Name 
	,p.ListPrice 
	,p.Class
	,p.Style
	,p.Color
FROM Production.Product p
ORDER BY 4, 5;


