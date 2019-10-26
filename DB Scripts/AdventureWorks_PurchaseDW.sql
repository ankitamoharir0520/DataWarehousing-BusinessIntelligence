use AdventureWorks2017

--select * from Purchasing.PurchaseOrderDetail

-- Ranked order of Vendors by purchase amount $
SELECT VendorID, sum(SubTotal) as PurchaseAmount
FROM Purchasing.PurchaseOrderHeader   
GROUP BY VendorID
ORDER BY PurchaseAmount DESC

SELECT VendorID, 
       sum(SubTotal),  
       DENSE_RANK() OVER(ORDER BY sum(SubTotal) DESC) Rank
FROM Purchasing.PurchaseOrderHeader
GROUP BY VendorID

/*Ranked order of products purchased by amount $
▪ By category
▪ By subcategory
▪ By product model (top 20)
▪ By product (top 20) */
 
-- By product (top 20) 
SELECT * from(
SELECT P.ProductID, P.Name,
       sum(POH.SubTotal) AS PurchasingAmount,  
       DENSE_RANK() OVER(ORDER BY sum(SubTotal) DESC) Rank
FROM Purchasing.PurchaseOrderHeader POH 
	INNER JOIN Purchasing.PurchaseOrderDetail POD
	ON POH.PurchaseOrderID = POD.PurchaseOrderID
	INNER JOIN Production.Product P
	ON POD.ProductID = P.ProductID
GROUP BY P.ProductID, P.Name ) AS abc where Rank <= 20

ORDER BY Rank

-- By category
SELECT * from(
SELECT PS.ProductCategoryID,
       sum(POH.SubTotal) AS PurchasingAmount,  
       DENSE_RANK() OVER(ORDER BY sum(SubTotal) DESC) Rank
FROM Purchasing.PurchaseOrderHeader POH 
	INNER JOIN Purchasing.PurchaseOrderDetail POD
	ON POH.PurchaseOrderID = POD.PurchaseOrderID
	INNER JOIN Production.Product P
	ON POD.ProductID = P.ProductID
	INNER JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
GROUP BY PS.ProductCategoryID) AS abc 
ORDER BY Rank

-- By Subcategory
SELECT * from(
SELECT PS.ProductSubcategoryID, PS.Name, 
       sum(POH.SubTotal) AS PurchasingAmount,  
       DENSE_RANK() OVER(ORDER BY sum(SubTotal) DESC) Rank
FROM Purchasing.PurchaseOrderHeader POH 
	INNER JOIN Purchasing.PurchaseOrderDetail POD
	ON POH.PurchaseOrderID = POD.PurchaseOrderID
	INNER JOIN Production.Product P
	ON POD.ProductID = P.ProductID
	INNER JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID =  PS.ProductSubcategoryID
GROUP BY PS.ProductSubcategoryID, PS.Name) AS abc 
ORDER BY Rank

 --By product model (top 20)

 SELECT * from(
SELECT PM.ProductModelID, PM.Name,
       sum(POH.SubTotal) AS PurchasingAmount,  
       DENSE_RANK() OVER(ORDER BY sum(SubTotal) DESC) Rank
FROM Purchasing.PurchaseOrderHeader POH 
	INNER JOIN Purchasing.PurchaseOrderDetail POD
	ON POH.PurchaseOrderID = POD.PurchaseOrderID
	INNER JOIN Production.Product P
	ON POD.ProductID = P.ProductID
	INNER JOIN Production.ProductModel PM
	ON P.ProductModelID = PM.ProductModelID
GROUP BY PM.ProductModelID, PM.Name ) AS abc where Rank <= 20


------------------------------------------------------------------------------------
-- List of employees who purchased products with phone, email & address
--------------------------------------------------------------------------------

CREATE VIEW EmployeeDetails
AS
SELECT e.BusinessEntityID,
	   p.FirstName,
	   p.LastName,
	   em.EmailAddress,
	   pp.PhoneNumber,
	   bea.AddressID,
	   a.AddressLine1,
	   a.AddressLine2,
	   a.city,
	   a.PostalCode,
	   sp.Name AS State,
	   cr.Name as Country
FROM [HumanResources].[Employee] e 
	INNER JOIN [Person].[Person] p
	ON e.BusinessEntityID = p.BusinessEntityID
	INNER JOIN [Person].[EmailAddress] em
	ON e.BusinessEntityID = em.BusinessEntityID
	INNER JOIN [Person].[PersonPhone] pp
	ON e.BusinessEntityID = pp.BusinessEntityID
	INNER JOIN [Person].[BusinessEntityAddress] bea
	ON e.BusinessEntityID = bea.BusinessEntityID
	INNER JOIN [Person].[Address] a
	ON bea.AddressID = a.AddressID
	INNER JOIN [Person].[StateProvince] sp
	ON sp.StateProvinceID = a.StateProvinceID
	INNER JOIN [Person].[CountryRegion] cr 
	ON sp.CountryRegionCode  =  cr.CountryRegionCode
	
		 
select * from EmployeeDetails order by BusinessEntityID
select * from Purchasing.PurchaseOrderHeader order by EmployeeID


select DISTINCT ed.BusinessEntityID, 
				ed.FirstName, 
				ed.LastName, 
				ed.EmailAddress, 
				ed.AddressLine1, 
				ed.AddressLine2, 
				ed.city,
				ed.PostalCode,
				ed.PhoneNumber, 
				ed.State, 
				ed.Country  
FROM EmployeeDetails ed
	INNER JOIN Purchasing.PurchaseOrderHeader POH
	ON ed.BusinessEntityID = POH.EmployeeID

------------------------------------------------------------------------------------
--List of purchasing vendor contacts with vendor name, phone, email & address
-------------------------------------------------------------------------------------

select distinct  
	c.BusinessEntityID
	,c.[Name]
    ,c.[PhoneNumber]
	,c.[EmailAddress]
	,a.AddressType
	,a.AddressLine1
	,a.AddressLine2
	,a.City
	,a.StateProvinceName
	,a.PostalCode
	,a.CountryRegionName
from Purchasing.PurchaseOrderHeader v
inner join Purchasing.vVendorWithContacts c on c.BusinessEntityID=v.VendorID
inner join Purchasing.vVendorWithAddresses a on a.BusinessEntityID=v.VendorID
order by c.BusinessEntityID

-------------------------------------------------------------------------------
------List of employees who purchased products with pay rate & raises (SCD)
----------------------------------------------------------------------------------

;with cte2 
	as
	(
	select * , ROW_NUMBER() over (Partition by productid order by ModifiedDate desc) as rno from Production.ProductCostHistory
	-- where EndDate is null
	)
	,cte
	as
	(
	select * from cte2 where rno=1
	),
	cte3
	as
	(
	select Distinct poh.EmployeeID,poh.OrderDate,pod.ProductID,pod.UnitPrice from Purchasing.PurchaseOrderHeader poh
	inner join Purchasing.PurchaseOrderDetail pod on pod.PurchaseOrderID=poh.PurchaseOrderID
	where poh.EmployeeID>0
	)
	select distinct c.ProductID,c.StandardCost,c3.UnitPrice,c.ModifiedDate,c3.OrderDate from cte c
	inner join cte3 c3 on c.ProductID =c3.ProductID and  Convert(Decimal(18,2),c.StandardCost) > Convert(Decimal(18,2),c3.UnitPrice)

-----------------------------------------------------------------------------------------
----- List of product prices by product order by product and SCD effective ascending
-------------------------------------------------------------------------------------------

select distinct  pod.ProductID, pod.PurchaseOrderID,poh.OrderDate,pod.UnitPrice from 	Purchasing.PurchaseOrderHeader poh
	inner join Purchasing.PurchaseOrderDetail pod on poh.PurchaseOrderID=pod.PurchaseOrderID
	--where pod.productid=1
	order by pod.ProductID,poh.OrderDate--,UnitPrice

-----------------------------------------------------------------------------------------
----- List of standard cost by product order by product and SCD effective ascending
-------------------------------------------------------------------------------------------

	select distinct pod.PurchaseOrderID,p.ProductID,p.Name,p.StandardCost,poh.OrderDate from Purchasing.PurchaseOrderDetail  pod
	inner join Purchasing.PurchaseOrderHeader poh on poh.PurchaseOrderID=pod.PurchaseOrderID
	inner join Production.Product p on p.ProductID=pod.ProductID
	order by p.ProductID,poh.OrderDate









