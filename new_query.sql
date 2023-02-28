USE AdventureWorks2016
GO

--1.
SELECT p.FirstName
		,p.LastName
		,s.Bonus
FROM Person.Person AS p
JOIN Sales.SalesPerson AS s ON p.BusinessEntityID = s.BusinessEntityID

SELECT soh.SalesOrderId
		,soh.OrderDate
		,soh.SalesOrderNumber
		,sod.ProductId
		,sod.OrderQty
		,sod.UnitPrice
FROM Sales.SalesOrderHeader as soh
JOIN Sales.SalesOrderDetail as sod ON soh.SalesOrderId=sod.SalesOrderId

SELECT p.Name
		,(s.UnitPrice - s.UnitPriceDiscount)*s.OrderQty as DiscountValue
FROM Production.Product as p
JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductId

SELECT p.Name
		,SUM((s.UnitPrice - s.UnitPriceDiscount)*s.OrderQty) as TotalValue
FROM Production.Product as p
JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductId
GROUP BY p.Name
ORDER BY TotalValue DESC

SELECT c.Name as "CategoryName"
		,sc.Name as "SubcategoryName"
FROM Production.ProductCategory as c
JOIN Production.ProductSubCategory as sc ON c.ProductCategoryId = sc.ProductCategoryId

SELECT c.Name as "CategoryName"
		,COUNT(*) AS NumberOfSubcategories
FROM Production.ProductCategory as c
JOIN Production.ProductSubCategory as sc ON c.ProductCategoryId = sc.ProductCategoryId
GROUP BY c.Name
ORDER BY c.Name

SELECT p.Name
		,COUNT(*) AS 'ReviewAmount'
FROM Production.Product p
JOIN Production.ProductReview r on p.ProductID=r.ProductID
GROUP BY p.Name;

SELECT p.LastName
		,p.FirstName
		,COUNT(*)
FROM HumanResources.EmployeeDepartmentHistory as h
JOIN  Person.Person as p ON p.BusinessEntityId=h.BusinessEntityId
GROUP BY p.FirstName
HAVING count(*) > 1

SELECT p.LastName
		,p.FirstName
		,pp.PhoneNumber
FROM Person.Person as p
LEFT JOIN Person.PersonPhone as pp ON p.BusinessEntityId=pp.BusinessEntityId

SELECT p.LastName
		,p.FirstName
		,pp.PhoneNumber
FROM Person.Person as p
LEFT JOIN Person.PersonPhone as pp ON p.BusinessEntityId=pp.BusinessEntityId
WHERE pp.PhoneNumber IS NULL

SELECT p.Name
		,d.DocumentNode
FROM Production.Product as p
LEFT JOIN Production.ProductDocument as d ON p.ProductId=d.ProductId
WHERE d.ProductID IS NULL

SELECT m.Name
		,m.UnitMeasureCode
		,CASE
		WHEN pSize.SizeUnitMeasureCode IS NOT NULL THEN 'Is used as size'
		WHEN pWeight.WeightUnitMeasureCode IS NOT NULL THEN 'Is used as weight'
		END as 'Used as'
FROM Production.UnitMeasure m
LEFT JOIN Production.Product pSize ON m.UnitMeasureCode = pSize.SizeUnitMeasureCode
LEFT JOIN Production.Product pWeight ON m.UnitMeasureCode = pWeight.WeightUnitMeasureCode

SELECT m.Name
		,m.UnitMeasureCode
		,CASE
		WHEN pSize.SizeUnitMeasureCode IS NOT NULL THEN 'Is used as size'
		WHEN pWeight.WeightUnitMeasureCode IS NOT NULL THEN 'Is used as weight'
		END as 'Used as'
FROM Production.UnitMeasure m
LEFT JOIN Production.Product pSize ON m.UnitMeasureCode = pSize.SizeUnitMeasureCode
LEFT JOIN Production.Product pWeight ON m.UnitMeasureCode = pWeight.WeightUnitMeasureCode
WHERE pSize.SizeUnitMeasureCode IS NULL AND pWeight.WeightUnitMeasureCode IS NULL




