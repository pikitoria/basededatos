CREATE DATABASE VETERINARIA;
USE VETERINARIA;

CREATE TABLE DUEÑOS (
    DNI INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20)
);

CREATE TABLE MASCOTAS (
    id_mascota INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Especie VARCHAR(30),
    Edad INT,
    Raza VARCHAR(30),
    DNI_Dueño INT,
    FOREIGN KEY (DNI_Dueño) REFERENCES DUEÑOS(DNI)
);

CREATE TABLE VETERINARIOS (
    Legajo INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Especialidad VARCHAR(50),
    Turno ENUM('Mañana', 'Tarde')
);

CREATE TABLE TURNOS (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Motivo TEXT,
    id_mascota INT,
    Legajo_Vet INT,
    FOREIGN KEY (id_mascota) REFERENCES MASCOTAS(id_mascota),
    FOREIGN KEY (Legajo_Vet) REFERENCES VETERINARIOS(Legajo)
);

INSERT INTO DUEÑOS VALUES (111, 'Juan', 'Pérez', '4444-5555'), (222, 'Ana', 'Gómez', '4444-6666');

INSERT INTO MASCOTAS (Nombre, Especie, Edad, Raza, DNI_Dueño) 
VALUES ('Firulais', 'Perro', 5, 'Labrador', 111), ('Michi', 'Gato', 3, 'Siamés', 222);

INSERT INTO VETERINARIOS VALUES (1001, 'Dr. Dolittle', 'Cirugía', 'Mañana'), (1002, 'Dra. Quinn', 'Clínica', 'Tarde');

INSERT INTO TURNOS (Fecha, Hora, Motivo, id_mascota, Legajo_Vet)
VALUES ('2024-05-10', '10:00:00', 'Vacunación', 1, 1001), ('2024-05-15', '16:30:00', 'Control', 2, 1002);

SELECT * FROM MASCOTAS;

SELECT Nombre, Apellido FROM DUEÑOS;

SELECT * FROM TURNOS WHERE Fecha > '2024-05-01';
