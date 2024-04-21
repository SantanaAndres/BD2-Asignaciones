use Northwind

-- 1
declare @nombre varchar(20)
	set @nombre = 'Andres'
select @nombre 


-- 2
select 
 	MAX (UnitPrice) as 'Precio Mayor',
	MIN (UnitPrice) as 'Precio Menor'
from Products

declare @PrecioMayor money,
		@PrecioMenor money
select 
	@PrecioMayor = MAX (UnitPrice),
	@PrecioMenor = MIN (UnitPrice)
from Products

select 'Precio Mayor = '+ rtrim (str(@PrecioMayor, 7, 2)),
		'Precio Menor = '+ rtrim(str(@PrecioMenor, 7, 2))

-- 3
declare @NombreEmpleado varchar(50)

select
	[TitleOfCourtesy] + ' ' +
	FirstName + ' ' +
	LastName as 'NOMBRE'
from Employees

-- 4

create procedure ListarEmpleadosConCumpleaños
as
	begin
		select 
			case 
				when TitleOfCourtesy = 'Ms.' then 'Señorita ' + FirstName + ' ' + LastName
				when TitleOfCourtesy = 'Mr.' then 'Señor ' + FirstName + ' ' + LastName
				when TitleOfCourtesy = 'Mrs.' then 'Señora ' + FirstName + ' ' + LastName
				when TitleOfCourtesy = 'Dr.' then 'Doctor ' + FirstName + ' ' + LastName
				else FirstName + ' ' + LastName
        end as NombreCompleto,
		case 
			When month(BirthDate) = 09 then 'MES SEPTEMBER'
			else 'NULL'
			end as 'MES'
    from Employees;
end

exec ListarEmpleadosConCumpleaños;

-- 5
if exists (select * from Region where [RegionID] = 4)
	update Region
		set RegionDescription='Northerm'
	where RegionID=4
else
	insert into Region
		values
		(
			4,
			'Northerm'
		)

select * from Region

-- 6

if exists (select * from Region where [RegionID] = 100)
	update Region
		set RegionDescription='Northerm'
	where RegionID=100
else
	insert into Region
		values
		(
			100,
			'Northerm'
		)

select * from Region

-- 7
create proc primer_proc1
	@categoria_id int
as 
	select c.[CategoryName], MAX(p.UnitPrice) as 'Maximo Precio', MIN(p.UnitPrice) as 'Precio Minimo'
		from Categories as c
	join [dbo].[Products] as p on p.CategoryID=c.CategoryID
	where (c.CategoryID=@categoria_id)
	group by c.CategoryName
return

exec primer_proc1 1

-- 8
create proc EliminarAlCliente
    @CustomerID varchar(15),
    @Resultado varchar(75) OUTPUT
as
begin
    if EXISTS (select * from Orders where CustomerID = @CustomerID)
    begin
        set @Resultado = 'No se puede eliminar el cliente. Tiene órdenes pendientes.';
    end
    else
    begin
        delete from Customers where CustomerID = @CustomerID;
        set @Resultado = 'Cliente eliminado satisfactoriamente.';
    end
end

declare @ResultadoMensaje varchar(75);

exec EliminarAlCliente @CustomerID = 'Lilas', @Resultado = @ResultadoMensaje output;
print @ResultadoMensaje;

declare @ResultadoMensaje varchar(75);
exec EliminarAlCliente @CustomerID = 'Pedro', @Resultado = @ResultadoMensaje output;