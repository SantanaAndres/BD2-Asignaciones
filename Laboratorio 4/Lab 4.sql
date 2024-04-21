use Northwind

-- 1
select Country, LEN(Country) as 'longitud'
	from Employees

-- 2
select FirstName, 
		LEN(FirstName) as 'Largo',
		RIGHT(FirstName, 3) as 'TRES_ULTIMOS'
	from Employees

-- 3
select FirstName as 'NOMBRE',
		upper(FirstName) as 'MAYÚSCULA',
		LOWER(FirstName) as 'MINÚSCULA'
	from Employees

-- 4
select UPPER(FirstName) + SPACE(20) + LOWER(LastName)
		as 'Nombre del Empleado'
	from Employees

-- 5
select 
		[TitleOfCourtesy] + ' '  + LastName +' ' + left(FirstName, 1) + '.' as 'EMPLEADO',
		left(City, 4) as 'Ciudad'
	from Employees

-- 6
select 
		Freight,
		str(Freight, 6, 2) as 'Longitud 6',
		str(Freight, 4, 1) as 'Longitud 4',
		str(Freight, 2, 1) as 'Longitud 2'
	from Orders

-- 7
select 
		round(Freight, 0) as 'Round 0',
		round(Freight, 1) as 'Round 1',
		round(Freight, 2) as 'Round 2',
		round(Freight, -1) as 'Round -1',
		round(Freight, -2) as 'Round -2'
	from Orders

-- 8
select 
		[OrderID],
		[OrderDate],
		[ShipName]
	from Orders
	where year(OrderDate) = 1998
		and month(OrderDate) = 1
		and ShipName = 'LINO-Delicateses'

-- 9
select sysdatetime()
select getdate()

-- 10
select 
		OrderID,
		OrderDate,
		OrderDate + 5 as 'Fecha de Entrega'
	from Orders

-- 11
select DATEDIFF(year, [BirthDate], GETDATE()) as 'EDAD'
	from Employees

-- 12
select 
		FirstName,
		[BirthDate]
	from Employees
	where (month([BirthDate]) = 9)

-- 13
select DATEDIFF(DAY, GETDATE(), '2023/12/25')

-- 14
select 
		day(ShippedDate) - day(OrderDate)
			as 'Dias Transcurridos'
	from Orders

-- 15
create table REGISTRO
	(
		Usuario char(10),
		Contraseña char(8)
			constraint ck_Registro_Contraseña
				check (Contraseña like '%@%' or Contraseña like '%!%' or Contraseña like '¿'),
		Fecha_acceso datetime default getdate()
	)

insert into [dbo].[REGISTRO](Usuario, Contraseña)
	values 
	(
		'Jeannette',
		'ABCD'
	)

select * from REGISTRO

-- 16
select OrderDate
	from Orders
		where year(OrderDate) = 1997 
		and month(OrderDate) between 4 and 6 

-- 17
select distinct(p.ProductName)
	from Products p
		join Order_Details od on p.ProductID = od.ProductID
		join Orders o on od.OrderID = o.OrderID
	where year(o.OrderDate) = 1997 AND month(o.OrderDate) = 8
