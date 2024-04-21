create database LAB_3_FITCLUB 
use LAB_3_FITCLUB
create table Socios
(
	cedula char(13)
		constraint Socios_pk primary key
		constraint Socios_cedula_ck 
			check (cedula like '[0-9][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'),
	num_socio int identity
		constraint Socios_uk unique,
	nombre varchar(30),
	domicilio varchar(30)
)

create table Instructor
(
	cedula char(13)
		constraint Instructor_pk primary key
		constraint Instructor_cedula_ck
			check(cedula like '[0-9][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'),
	nombre varchar(30),
	domicilio varchar(30)
)

create table Categoria
(
	cod_categoria int
		constraint Categoria_pk primary key,
	nombre varchar(30)
		constraint Categoria_nombre_ck 
			check (nombre in ('maquina', 'baile', 'speeding', 'pesas')),
	ced_instructor char(13)
		constraint Categoria_fk foreign key(ced_instructor)
			references Instructor(cedula)
		on delete set null
		on update cascade
		default null,
	Dia varchar(30)	
		constraint Categoria_dia_ck 
			check(Dia in ('lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado'))
		default 'sabado',
)

create table Inscripcion
(
	ced_socio char(13)
		constraint Inscripcion_cedula_fk foreign key(ced_socio)
			references Socios(cedula)
		on delete cascade,
	cod_categoria int 
		constraint Inscripcion_categoria_fk foreign key(cod_categoria)
			references Categoria(cod_categoria)
		default null,
	matricula char(1)
		constraint Inscripcion_matricula_ck
			check (matricula in ('s','n'))
		default 'n',
	monto money
		constraint Inscripcion_monto_ck
			check(monto > 0),
	constraint Inscripcion_pk primary key(ced_socio, cod_categoria)
)

insert into Socios
(
	[cedula],
	[nombre],
	[domicilio]
) values 
	('08-0987-09876', 'Andrés Araúz', 'Avenida 111'),
	('09-0076-06554', 'Bertina Bustamante', 'Balboa 222'),
	('07-0987-98769', 'Carlos Camarena', 'Colon 333'),
	('08-1111-22222', 'Luis Cortés', 'Vila Lucre'),
	('09-7777-00023', 'Pedro Jaén', 'Don Bosco'),
	('08-9999-34343', 'Rosa Filos', 'La Castellana')

select * from Socios

insert into Instructor
(
	cedula,
	nombre,
	domicilio
) values 
	('08-0775-02222', 'Ana López', 'Paical 2345')

insert into Instructor
(
	cedula,
	nombre,
	domicilio
) values 
	('04-9555-98989', 'Lorenzo González', 'San Miguelito 4')

insert into Instructor
(
	cedula,
	nombre,
	domicilio
) values 
	('07-3333-12345', 'Ernesto Arosemena', 'San Antonio ')

select * from Instructor

insert into Categoria
(
	cod_categoria,
	nombre,
	Dia,
	ced_instructor
) values 
	(1, 'Maquina', 'lunes', '07-3333-12345')

insert into Categoria
(
	cod_categoria,
	nombre,
	ced_instructor
) values 
	(2, 'Baile', '08-0775-02222')

insert into Categoria
(
	cod_categoria,
	nombre,
	Dia,
	ced_instructor
) values 
	(3, 'Speeding ', 'miercoles', '04-9555-98989')

insert into Categoria
(
	cod_categoria,
	nombre,
	Dia,
	ced_instructor
) values 
	(4, 'pesas', 'viernes', '07-3333-12345')

select * from Categoria

insert into Inscripcion
(
	ced_socio,
	cod_categoria,
	matricula,
	monto
) values 
	('08-0987-09876', 1, 's', 35)

insert into Inscripcion
(
	ced_socio,
	cod_categoria,
	matricula,
	monto
) values 
	('09-0076-06554', 1, 'n', 35)

insert into Inscripcion
(
	ced_socio,
	cod_categoria,
	matricula,
	monto
) values 
	('07-0987-98769', 2, 's', 100)

insert into Inscripcion
(
	ced_socio,
	cod_categoria,
	matricula,
	monto
) values 
	('08-1111-22222', 4, 's', 150)

insert into Inscripcion
(
	ced_socio,
	cod_categoria,
	matricula,
	monto
) values 
	('09-7777-00023', 3, 's', 75)

insert into Inscripcion
(
	ced_socio,
	cod_categoria,
	matricula,
	monto
) values 
	('07-0987-98769', 1, 'n', 35)

insert into Inscripcion
(
	ced_socio,
	cod_categoria,
	matricula,
	monto
) values 
	('08-0987-09876', 2, 's', 100)

-- no hecho, error
insert into Inscripcion
(
	ced_socio,
	cod_categoria,
	matricula,
	monto
) values 
	('03-0096-00344', 1, 's', 150)


insert into Inscripcion
(
	ced_socio,
	cod_categoria,
	matricula,
	monto
) values 
	('07-0987-98769', 4, 's', 100)
	
insert into Inscripcion
(
	ced_socio,
	cod_categoria,
	matricula,
	monto
) values 
	('08-0987-09876', 4, 's', 145)

select * from Inscripcion

update Instructor
	set 
		cedula='03-3333-33333',
		nombre='Carlos Gómez',
		domicilio='Villa Verónica'
	where cedula='04-9555-98989'

select * from Categoria
select * from Instructor

delete from Socios
	where cedula='08-0987-09876'

select * from Socios
select * from Inscripcion