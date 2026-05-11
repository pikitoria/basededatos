create database empresa;

use testempresa;

create table Empleados( -- Create table Entidad 
ID_empleados int auto_increment primary key not null,
Nombre varchar(18),
Apellido varchar (20) not null,
Sector enum ('adn','ventas','compras','RRHH'),
Edad int not null default 35,
Sexo enum ('F','M') not null,
Barrio_vivienda varchar (100) default 'Belgrano',
CodigoPostal int  (4),
sueldo decimal (12,2) not null,
Antiguedad decimal (12,2) not null default 250.00,
Celular varchar (20) not null
);


use Empresa;

insert into Empleados (Nombre, Apellido, Sector, Edad, Sexo, Barrio_vivienda, CodPostal, Ingreso, Sueldo, Celular)
values
('Juan', 'García', 'RRHH', 30, 'M', 'Belgrano', '1428', 2011, 55000.00, '1544440001'),
('Ana', 'López', 'RRHH', 28, 'F', 'Almagro', '1111', 2011, 56000.00, '1544440002'),
('Luis', 'Pérez', 'RRHH', 35, 'M', 'Flores', '1406', 2011, 54000.00, '1544440003'),
('Marta', 'Rodríguez', 'Adm', 40, 'F', 'Belgrano', '1428', 2011, 60000.00, '1544440004'),
('Pedro', 'Gómez', 'Ventas', 22, 'M', 'Almagro', '1111', 2011, 45000.00, '1544440005'),
('Sofía', 'Martínez', 'Compras', 33, 'F', 'Flores', '1406', 2010, 58000.00, '1544440006'),
('Carlos', 'Sánchez', 'Ventas', 45, 'M', 'Belgrano', '1428', 2012, 62000.00, '1544440007'),
('Lucía', 'Díaz', 'Adm', 29, 'F', 'Almagro', '1111', 2013, 53000.00, '1544440008'),
('Jorge', 'Torres', 'Ventas', 38, 'M', 'Flores', '1406', 2010, 57000.00, '1544440009'),
('Elena', 'Ruiz', 'Compras', 27, 'F', 'Caballito', '1405', 2014, 51000.00, '1544440100'),
('Raúl', 'Castro', 'Adm', 50, 'M', 'Palermo', '1425', 2009, 70000.00, '1544440101'),
('Silvia', 'Blanco', 'Ventas', 31, 'F', 'Almagro', '1111', 2012, 49000.00, '1544440102'),
('Oscar', 'Vidal', 'Compras', 42, 'M', 'Flores', '1406', 2015, 65000.00, '1544440103'),
('Victoria', 'Sosa', 'RRHH', 26, 'F', 'Boedo', '1210', 2011, 55000.00, '1544440104'),
('Andrés', 'Morales', 'Ventas', 36, 'M', 'Belgrano', '1428', 2011, 58000.00, '1544440105');


SELECT * FROM EMPLEADOS;
SELECT Nombre, Apellido FROM Empleados WHERE Barrio_vivienda = 'Belgrano';
SELECT Apellido, Edad FROM EMPLEADOS WHERE Ingreso BETWEEN 2010 AND 2012;
SELECT COUNT(*) FROM Empleados WHERE Sexo = 'F' AND Sector = 'RRHH';
SELECT Apellido, Sector, Celular FROM Empleados;
SELECT Nombre, Apellido, Sueldo FROM Empleados WHERE Barrio_vivienda IN ('Almagro', 'Flores') ORDER BY Apellido DESC;
SELECT COUNT(*) FROM Empleados;
SELECT Nombre, Apellido FROM Empleados ORDER BY Edad ASC LIMIT 1; 
SELECT AVG(Edad) FROM Empleados;
SELECT AVG(Edad) FROM Empleados WHERE Sector = 'RRHH';

