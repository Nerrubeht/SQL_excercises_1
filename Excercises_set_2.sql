USE AdventureWorks2016
GO

DECLARE @t TINYINT
SET @t = 2*2*2*2*2*2*2*2 
PRINT @t

DECLARE @t TINYINT
SET @t = 2*2*2*2*2*2*2*2-1 
PRINT @t

DECLARE @s SMALLINT
SET @s = 128*256-1
PRINT @s

DECLARE @k INT = -1
SET @k = POWER (2,31)
SET @k = -1
PRINT @k

SELECT *
FROM HumanResources.Department;

--TEXT VARIABLES--

DECLARE @t NVARCHAR(1000)
SET @t = ''
SELECT @t = Name
FROM HumanResources.Department
WHERE DepartmentID = 1
PRINT @t
SELECT LEN(@t),DATALENGTH(@t)

--DATETIME VARIABLES--

DECLARE @f FLOAT = -1
SELECT @f +1 ,@f + 0.5 + 0.5,@f + 0.5 + 0.25 + 0.25,@f+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1 
GO

DECLARE @d SMALLDATETIME = GETDATE()
PRINT @d

SELECT *
FROM Sales.SalesOrderHeader;
--Wystarczy sama data--

SELECT CardNumber
	,SUBSTRING(CardNumber,4,1000)
FROM Sales.CreditCard;

SELECT AddressLine1
	,SUBSTRING(AddressLine1,1, CHARINDEX(' ',AddressLine1))
FROM Person.Address;

SELECT FORMAT(OrderDate,'MM/yyyy'), OrderDate
FROM Sales.SalesOrderHeader;

SELECT OrderQty * UnitPrice
	,FORMAT(OrderQty * UnitPrice,'0.00')
FROM Sales.SalesOrderDetail;

SELECT ProductNumber
	,REPLACE(ProductNumber,'-',' ')
FROM Production.Product

SELECT TotalDue
	,REPLICATE('*',15 - LEN(FORMAT(TotalDue,'0.00')))+FORMAT(TotalDue,'0.00')+'**'
FROM Sales.SalesOrderHeader;

--Typy daty i czasu--

SELECT GETDATE()


SELECT SalesOrderID
		,OrderDate
		,YEAR(OrderDate) AS Year
		,MONTH(OrderDate) AS Month
		,DAY(OrderDate) AS Day
		,DATEPART(dw,OrderDate) AS WeekDay
		,DATEPART(wk, OrderDate) AS week
FROM Sales.SalesOrderHeader

SELECT SalesOrderID
		,OrderDate
		,YEAR(OrderDate) AS Year
		,DATENAME(MM,OrderDate) AS Month
		,DAY(OrderDate) AS Day
		,DATENAME(dw,OrderDate) AS WeekDay
		,DATEPART(wk, OrderDate) AS week
FROM Sales.SalesOrderHeader

DECLARE @u DATETIME2 = '1994-04-21'
SET LANGUAGE ENGLISH
SELECT DATENAME(dw,@u) AS DzienUrodzenia

SELECT e.LoginID
		,e.BirthDate
		,DATEFROMPARTS(YEAR(GetDate()),MONTH(BirthDate),1) AS BeginingOfTheMonth
		,EOMONTH(DATEFROMPARTS(YEAR(GETDATE()),MONTH(BirthDate),1)) AS EndOFMOnth
FROM HumanResources.Employee e

SELECT SalesOrderID
		,OrderDate
		,DueDate
		,DATEDIFF(d,OrderDate,DueDate)
FROM Sales.SalesOrderHeader

DECLARE @n DATETIME2 = '1994-04-21'
SELECT DATEDIFF(day,@n,GETDATE())
		,DATEDIFF(year,@n,GETDATE())

SELECT *
FROM HumanResources.Employee
WHERE BirthDate BETWEEN DATEADD(Year,-1,'1986-06-05') AND DATEADD(Year,1,'1986-06-05')

DECLARE @Urodzinki DATE 
SELECT @Urodzinki = BirthDate
FROM HumanResources.Employee
WHERE LoginID = 'adventure-works\diane1'

SELECT *
FROM HumanResources.Employee
WHERE BirthDate BETWEEN DATEADD(Year,-1,@Urodzinki) AND DATEADD(Year,1,@Urodzinki)

--NOWY TEMAT Funkcje matematyczne--

SELECT SalesOrderID
		,TaxAmt
		,FLOOR(TaxAmt/1000)*1000
FROM Sales.SalesOrderHeader

DECLARE @l INT = CEILING(RAND()*49)
SELECT @l

SELECT TaxAmt
		,ROUND(TaxAmt,0)
FROM Sales.SalesOrderHeader

SELECT TaxAmt
		,ROUND(TaxAmt,-3)
FROM Sales.SalesOrderHeader

--NOWY TEMAT Funkcje konwertujace--

SELECT 'Shift' + Name + ' starts at ' + CAST(StartTime AS VARCHAR(10)) 
FROM HumanResources.Shift

SELECT*
FROM HumanResources.Shift
WHERE ShiftID = 1

SELECT LoginID + ' ' + CONVERT(VARCHAR(100), HireDate, 104)
FROM HumanResources.Employee

DECLARE @j CHAR(30) = '20 kwietniucha 1994'
SELECT TRY_PARSE(@j AS DATE USING 'pl-PL')

--NOWY TEMAT Funkcje logiczne--

SELECT LoginID
		,IIF(DATEDIFF(year,HireDate,GETDATE())>10,'OldStranger','Adept')
FROM HumanResources.Employee

SELECT LoginID
		,IIF(DATEDIFF(year,HireDate,GETDATE())>8,'Veteran','Adept')
		,IIF(DATEDIFF(year,HireDate,GETDATE())>10,'OldStranger','Adept')
FROM HumanResources.Employee

SELECT SalesOrderId
		,OrderDate
		,CHOOSE(DATEPART(WEEKDAY,OrderDate)
			,'lunes'
			,'martes'
			,'miércoles'
			,'jueves'
			,'viernes'
			,'sábado'
			,'domingo')
FROM Sales.SalesOrderHeader