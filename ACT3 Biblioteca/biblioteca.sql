CREATE DATABASE CONCESIONARIO;
USE CONCESIONARIO;

CREATE TABLE CLIENTES (
    dni INT PRIMARY KEY, -- DNI como PK fija según video [5]
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
    tipo ENUM('Nuevo', 'Usado'), -- Uso de ENUM según teoría [3]
    unidades INT DEFAULT 0, -- Para coches nuevos
    kilometros INT DEFAULT 0, -- Para coches usados
    dni_cliente INT,
    FOREIGN KEY (dni_cliente) REFERENCES CLIENTES(dni)
);

CREATE TABLE MECANICOS (
    dni INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    fecha_contratacion DATE,
    salario DECIMAL(10, 2) -- Decimal para dinero [3]
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
(10, 'Carlos', 'Gomez', 'Av 1', '111'), (20, 'Lucia', 'Paz', 'Av 2', '222'),
(30, 'Marcos', 'Sosa', 'Av 3', '333'), (40, 'Elena', 'Ruiz', 'Av 4', '444'),
(50, 'Pedro', 'Díaz', 'Av 5', '555');

INSERT INTO COCHES (matricula, modelo, marca, color, tipo, kilometros, dni_cliente) VALUES 
('AAA111', 'Fiesta', 'Ford', 'Azul', 'Usado', 50000, 10),
('BBB222', 'Corolla', 'Toyota', 'Blanco', 'Nuevo', 0, 20)
