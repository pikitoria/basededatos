CREATE DATABASE CONCESIONARIO;
USE CONCESIONARIO;

CREATE TABLE CLIENTES (
    dni INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE COCHES (
    id_coche INT AUTO_INCREMENT PRIMARY KEY,
    matricula CHAR(7) UNIQUE NOT NULL,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    color VARCHAR(20),
    tipo ENUM('Nuevo', 'Usado'), 
    unidades INT DEFAULT 0,
    kilometros INT DEFAULT 0, 
    dni_cliente INT,
    FOREIGN KEY (dni_cliente) REFERENCES CLIENTES(dni)
);

CREATE TABLE MECANICOS (
    dni INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    fecha_contratacion DATE,
    salario DECIMAL(10, 2) 
);

CREATE TABLE REPARACIONES (
    id_reparacion INT AUTO_INCREMENT PRIMARY KEY,
    dni_mecanico INT,
    id_coche INT,
    fecha_reparacion DATE,
    horas_trabajo DECIMAL(5, 2),
    FOREIGN KEY (dni_mecanico) REFERENCES MECANICOS(dni),
    FOREIGN KEY (id_coche) REFERENCES COCHES(id_coche)
);


INSERT INTO CLIENTES (dni, nombre, apellidos, direccion, telefono) VALUES 
('10', 'Carlos', 'Gomez', 'Av 1', '111'), ('20', 'Lucia', 'Paz', 'Av 2', '222'),
('30', 'Marcos', 'Sosa', 'Av 3', '333'), ('40', 'Elena', 'Ruiz', 'Av 4', '444'),
('50', 'Pedro', 'Díaz', 'Av 5', '555');

INSERT INTO COCHES (matricula, modelo, marca, color, tipo, kilometros, dni_cliente) VALUES 
('AAA111', 'Territory', 'Ford', 'Negro', 'Nuevo', '20', '95752916'), ('BBB222', 'Corolla', 'Toyota', 'Blanco', 'Nuevo', '0', '39859485'),
('AA1506', 'Veneno', 'Lamborghini', 'Negro', 'Nuevo', '20' , '95573013'), ('WEBO15', 'RS6', 'Mercedes', 'Negro', 'Nuevo', '0', '94854903'),
('BBB222', 'Hot wheels', 'Toyota', 'Rosa fluor', 'Nuevo', '0', '49761533');


INSERT INTO MECANICOS ( dni, nombre, apellidos, fecha_contratacion, salario) VALUES
('10989574', 'Carlos', 'Gomez', '23-08-1998', '4'), ('20345634', 'Lucia', 'Paz', 'Av 2', '20000'),
('30256634', 'Marcos', 'Sosa', 'Av 3', '2'), ('40564535', 'Elena', 'Luanez', 'Av 4', '40000'),
('50565423', 'Pedro', 'Díaz', 'Av 5', '3');

INSERT INTO REPARACIONES (dni_mecanico, id_coche, fecha_reparacion, horas_trabajo) VALUES
('10', 'Carlos', 'Gomez', '2-4-2026', '78'), ('20', 'Lucia', 'Paz', '23-10-2025', '2'),
('30', 'Marcos', 'Sosa', '15-06-2026', '23'), ('40', 'Elena', 'Luanez', '07-8-2005', '4'),
('50', 'Pedro', 'Díaz', '06-07-2025', '24');
