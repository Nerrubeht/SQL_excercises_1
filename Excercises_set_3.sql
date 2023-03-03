USE AdventureWorks2016
GO

SELECT Name
		,CASE Name
		WHEN 'cell' THEN 'mobile phone'
		WHEN 'Home' THEN 'Staionary'
		WHEN 'Work' THEN 'Stationary'
		ELSE 'Other'
	END			
FROM Person.PhoneNumberType

SELECT ProductID
		,Name
		,Size
		,CASE Size
		WHEN 'S' THEN 'SMALL'
		WHEN 'M' THEN 'MEDIUM'
		WHEN 'L' THEN 'LARGE'
		WHEN 'XL' THEN 'EXTRA LARGE'
		ELSE '???'
	END

SELECT COUNT(*)
		,COUNT(MddleName)
		,COUNT(FirstName)
		,COUNT(1)
FROM Production.Product
WHERE EmailPromotion = 1


SELECT SUM(UnitPrice * OrderQty)
		,SUM((UnitPrice-UnitPriceDiscount) * OrderQty)
FROM Sales.SalesOrderDetail;


SELECT COUNT(*)
		,ProductSubcategoryID AS 'SUBCATEGORY'
		,MIN (StandardCost)
		,MAX (StandardCost)
		,AVG (StandardCost)
		,STDEV (StandardCost)
FROM Production.Product
WHERE ProductSubcategoryID = 14
GROUP BY ProductSubcategoryID;

SELECT COUNT(*) AS 'Amount of Orders'
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) ='2012'
GROUP BY SalesPersonID
ORDER BY [Amount of Orders] DESC;

SELECT COUNT(*) AS 'Amount of Orders'
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2012-01-01' AND '2012-12-31'
GROUP BY SalesPersonID
ORDER BY [Amount of Orders] DESC;

SELECT COUNT(*) AS 'Amount of Orders'
		,SUM(SubTotal) AS 'TotalSales'
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2012-01-01' AND '2012-12-31'
GROUP BY SalesPersonID
HAVING SUM(SubTotal)> 10000
ORDER BY TotalSales DESC;

SELECT COUNT(*) AS 'AmountOfOrdersShipMetod'
FROM Sales.SalesOrderHeader
GROUP BY ShipMethodID

--ZADANIA z NULL

SELECT *
FROM Person.Person
WHERE MiddleName IS NULL;

SELECT *
FROM Person.Person
WHERE MiddleName IS NOT NULL;

SELECT p.FirstName
		,p.MiddleName
		,p.LastName
		,p.FirstName +' '+ p.MiddleName +' '+ p.LastName 
		,CASE
			WHEN p.MiddleName IS NULL THEN p.FirstName +' '+ p.LastName
			ELSE p.FirstName +' '+ p.MiddleName +' '+ p.LastName
		END
		,p.FirstName+' '+ISNULL(p.MiddleName,'')+' '+p.LastName
FROM Person.Person as p

SELECT ProductID	
		,Name
		,Size
		,ListPrice
		,Weight
		,COALESCE('S:'+Size, 'W:'+CAST(Weight AS VARCHAR(10)), 'P:'+CAST(ListPrice AS VARCHAR(10)))
FROM Production.Product

--ZADANIA Z SELECT DISTINCT i SELECT TOP

SELECT DISTINCT City
FROM Person.Address;

SELECT DISTINCT PostalCode
FROM Person.Address;

SELECT DISTINCT City, PostalCode
FROM Person.Address;

SELECT TOP(4) WITH TIES BusinessEntityID, Bonus
FROM Sales.SalesPerson
ORDER BY Bonus DESC;

SELECT TOP (20) PERCENT WITH TIES BusinessEntityID, Bonus
FROM Sales.SalesPerson
ORDER BY Bonus DESC

--ZADANIA Z GROUP BY, ROLLUP, CUBEI GROUPING SET

SELECT MONTH(OrderDate), SalesPersonID, TerritoryID, SUM(SubTotal)
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL AND TerritoryID IS NOT NULL AND OrderDate BETWEEN '2012-01-01' AND '2012-03-31'
GROUP BY SalesPersonID, TerritoryID, MONTH(OrderDate)

SELECT MONTH(OrderDate), SalesPersonID, TerritoryID, SUM(SubTotal)
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL AND TerritoryID IS NOT NULL AND OrderDate BETWEEN '2012-01-01' AND '2012-03-31'
GROUP BY CUBE (SalesPersonID, TerritoryID, MONTH(OrderDate))

SELECT MONTH(OrderDate), SalesPersonID, TerritoryID, SUM(SubTotal)
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL AND TerritoryID IS NOT NULL AND OrderDate BETWEEN '2012-01-01' AND '2012-03-31'
GROUP BY GROUPING SETS ((MONTH(OrderDate)), (SalesPersonID, TerritoryID, MONTH(OrderDate)))

--ZADANIA Z GROUPINGID
SELECT
MONTH(OrderDate)
,GROUPING_ID(MONTH(OrderDate)) AS AggregateByMonth
,SalesPersonId, GROUPING_ID(SalesPersonId) AS AggregateBySalesPersonId
,TerritoryID, GROUPING_ID(TerritoryID) AS AggregateByTerritoryID
,SUM(SubTotal) AS SumOfTotal
,GROUPING_ID(MONTH(OrderDate),SalesPersonID,TerritoryID)
FROM Sales.SalesOrderHeader
GROUP BY ROLLUP (MONTH(OrderDate),SalesPersonID,TerritoryID)

SELECT
MONTH(OrderDate) AS Month 
,GROUPING_ID(MONTH(OrderDate)) AS AggregateByMonth
,SalesPersonId, GROUPING_ID(SalesPersonId) AS AggregateBySalesPersonId
,TerritoryID, GROUPING_ID(TerritoryID) AS AggregateByTerritoryID
,SUM(SubTotal) AS SumOfTotal
,GROUPING_ID(MONTH(OrderDate),SalesPersonID,TerritoryID)
FROM Sales.SalesOrderHeader
GROUP BY CUBE (MONTH(OrderDate),SalesPersonID,TerritoryID)

SELECT
MONTH(OrderDate) AS Month
,GROUPING_ID(MONTH(OrderDate)) AS AggregateByMonth
,SalesPersonId, GROUPING_ID(SalesPersonId) AS AggregateBySalesPersonId
,TerritoryID, GROUPING_ID(TerritoryID) AS AggregateByTerritoryID
,SUM(SubTotal) AS SumOfTotal
,GROUPING_ID(MONTH(OrderDate),SalesPersonID,TerritoryID)
FROM Sales.SalesOrderHeader
GROUP BY GROUPING SETS ((MONTH(OrderDate)),(MONTH(OrderDate),SalesPersonID,TerritoryId))