CREATE DATABASE CLINICA;
USE CLINICA;

CREATE TABLE ESPECIALIDADES (
    id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_esp VARCHAR(50) NOT NULL
);

CREATE TABLE MEDICOS (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_especialidad INT,
    FOREIGN KEY (id_especialidad) REFERENCES ESPECIALIDADES(id_especialidad)
);

CREATE TABLE TURNOS (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    estado ENUM('Confirmado', 'Cancelado', 'Realizado'),
    id_medico INT,
    FOREIGN KEY (id_medico) REFERENCES MEDICOS(id_medico)
);

INSERT INTO ESPECIALIDADES (nombre_esp) VALUES ('Pediatría'), ('Cardiología'), ('Traumatología');
INSERT INTO MEDICOS (nombre, id_especialidad) VALUES ('Dr. House', 3), ('Dra. Grey', 2), ('Dr. Meléndez', 1);
INSERT INTO TURNOS (fecha, estado, id_medico) VALUES ('2024-06-01', 'Confirmado', 1), ('2024-06-02', 'Cancelado', 2), ('2024-06-03', 'Realizado', 3);

SELECT M.nombre, E.nombre_esp FROM MEDICOS M JOIN ESPECIALIDADES E ON M.id_especialidad = E.id_especialidad;
SELECT * FROM TURNOS;
