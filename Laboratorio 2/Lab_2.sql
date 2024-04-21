create database LAB_2;

use LAB_2;

CREATE TABLE LIBROS(
	cod_lib INT 
		CONSTRAINT pk_LIBROS PRIMARY KEY,
	espec varchar(15),
	titulo varchar(30) not null,
	autor varchar(20),
	editorial varchar(15),
	precio float
)

-- 2
INSERT INTO LIBROS VALUES
	(100, 'sistemas', 'Fundamentos de Bases de datos', 'Elmarsi', 'McGraw Hill', 45.00),
	(101, 'sistemas', 'Sistemas de Bases de datos', 'Connolly', 'Pearson', 30.00),
	(302, 'literatura', 'Cervantes y el Quijote', 'Borges', 'Elmerce', 25.00),
	(204, 'matemáticas', 'Cálculo Diferencial e Integral', 'Hernández', 'Pearson', 35.25),
	(106, 'literatura', 'Aprenda Sql ya', 'Riordan', 'McGraw Hill', 90.99);

-- 3
UPDATE LIBROS
	SET autor = 'Connolly y Begg'
	WHERE autor = 'Connolly';

select * from LIBROS;

-- 4
UPDATE LIBROS
	SET espec = 'sistemas'
	WHERE cod_lib = 106;

select * from LIBROS;

-- 5

UPDATE LIBROS
	SET precio = 27
	WHERE autor = 'Borges';

select * from LIBROS;

-- 6
UPDATE LIBROS
	SET editorial = 'MGH'
	WHERE editorial = 'McGraw Hill';

select * from LIBROS;

-- 7
CREATE TABLE EDITORIALES (
	Cod_edit INT IDENTITY
		CONSTRAINT pk_EDITORIALES PRIMARY KEY,
	Nombre_edit VARCHAR(15) UNIQUE
);

INSERT EDITORIALES (Nombre_edit)
	SELECT DISTINCT editorial FROM LIBROS;

SELECT * FROM EDITORIALES

-- 8
CREATE TABLE ESPECIALIDADES 
(
	Cod_espec INT IDENTITY
		CONSTRAINT pk_ESPECIALIDADES PRIMARY KEY,
	Nombre_espec VARCHAR(15) UNIQUE
);

INSERT ESPECIALIDADES (Nombre_espec)
	SELECT DISTINCT espec FROM LIBROS;

SELECT * FROM ESPECIALIDADES;

-- 9
SELECT * FROM LIBROS;

ALTER TABLE LIBROS
	ADD Cod_espec INT
		CONSTRAINT FK_ESPEC_LIBROS FOREIGN KEY
		REFERENCES ESPECIALIDADES (Cod_espec),
	Cod_edit INT
		CONSTRAINT FK_EDITORIAL_LIBROS FOREIGN KEY
		REFERENCES EDITORIALES (Cod_edit);

SELECT * FROM LIBROS;
SELECT * FROM ESPECIALIDADES;

UPDATE LIBROS
	SET Cod_espec = CASE espec
		WHEN 'literatura' THEN 1
		WHEN 'matemáticas' THEN 2
		WHEN 'sistemas' THEN 3
	END;

SELECT * FROM LIBROS;
SELECT * FROM EDITORIALES;

UPDATE LIBROS
	SET Cod_edit = CASE editorial
		WHEN 'Elmerce' THEN 1
		WHEN 'MGH' THEN 2
		WHEN 'Pearson' THEN 3
	END;


-- 10
ALTER TABLE LIBROS
	DROP COLUMN editorial, espec;

SELECT * FROM LIBROS;

-- 11

-- 12
ALTER TABLE LIBROS
	NOCHECK CONSTRAINT FK_EDITORIAL_LIBROS;

DELETE EDITORIALES;

SELECT * FROM EDITORIALES;
SELECT * FROM LIBROS;


-- 13

INSERT EDITORIALES (Nombre_edit)
	VALUES
	('Elmerce'),
	('MGH'),
	('Pearson');

SELECT * FROM EDITORIALES;

-- 14
ALTER TABLE LIBROS
	DROP CONSTRAINT FK_EDITORIAL_LIBROS;

TRUNCATE TABLE EDITORIALES;

SELECT * FROM EDITORIALES;

-- 15
INSERT EDITORIALES (Nombre_edit)
	VALUES
	('Elmerce'),
	('MGH'),
	('Pearson');

SELECT * FROM EDITORIALES;

-- 16
ALTER TABLE LIBROS
	DROP CONSTRAINT FK_ESPEC_LIBROS;

DROP TABLE LIBROS, EDITORIALES, ESPECIALIDADES;

-- 17 
DROP DATABASE LAB_2;