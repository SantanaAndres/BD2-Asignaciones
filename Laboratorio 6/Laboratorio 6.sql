-- 1
create view Nombre_Apellido_Cumpleaños as
	select FirstName, LastName, BirthDate
from Employees

select * from Nombre_Apellido_Cumpleaños

-- 2
create view Nombre_Apellido_Cumpleaños2 as
	select FirstName, LastName, DATEPART(DAY, BirthDate) AS Dia
from Employees
	where MONTH(BirthDate) = 1 

select * from Nombre_Apellido_Cumpleaños2

-- 3
create view Ordenes as
	select ord.EmployeeID, em.FirstName, em.LastName, ord.OrderID, ord.OrderDate
	from Orders as ord
	inner join [dbo].[Employees] as em on ord.EmployeeID = em.EmployeeID

select * from Ordenes

-- 4
create view Ordenes4 as 
	select ord.EmployeeID, 
			em.FirstName, 
			em.LastName, 
			ord.OrderID, 
			ord.OrderDate,
			ct.CompanyName
	from Orders as ord
		inner join 
			Employees as em on ord.EmployeeID = em.EmployeeID
		inner join
			Customers as ct on ord.CustomerID = ct.CustomerID
	where ord.ShippedDate > ord.RequiredDate

select * from Ordenes4

-- 5
create view Productos
	as 
	select 
		pd.ProductName,
		ct.CategoryName
	from Products as pd
	inner join Categories as ct on pd.CategoryID = ct.CategoryID

select * from Productos

-- 6
update Ordenes4
	set 
		FirstName = 'Michael',
		LastName = 'Suyama '
	where OrderID = 10280

select * from Ordenes4
select * from Orders
select * from Employees

-- 7
insert into Nombre_Apellido_Cumpleaños
	values
	(
		'Andres',
		'Santana',
		'2002-11-16'
	)

select * from Nombre_Apellido_Cumpleaños

-- 8
insert into Nombre_Apellido_Cumpleaños2
	values
	(
		'Andres',
		'Santana',
		'2002-01-16'
	)
select * from Nombre_Apellido_Cumpleaños2

-- 9
create view Regalos 
as
	select TitleOfCourtesy
	from Employees
	where YEAR(HireDate) = 1992