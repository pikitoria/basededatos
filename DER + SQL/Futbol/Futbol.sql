CREATE DATABASE CAMPEONATO;
USE CAMPEONATO;

CREATE TABLE EQUIPOS (
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_equipo VARCHAR(50) NOT NULL
);

CREATE TABLE JUGADORES (
    id_jugador INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    posicion ENUM('Arquero', 'Defensor', 'Mediocampista', 'Delantero'),
    id_equipo INT,
    FOREIGN KEY (id_equipo) REFERENCES EQUIPOS(id_equipo)
);

CREATE TABLE PARTIDOS (
    id_partido INT AUTO_INCREMENT PRIMARY KEY,
    id_local INT,
    id_visitante INT,
    estadio VARCHAR(100),
    goles_local INT DEFAULT 0,
    goles_visitante INT DEFAULT 0,
    FOREIGN KEY (id_local) REFERENCES EQUIPOS(id_equipo),
    FOREIGN KEY (id_visitante) REFERENCES EQUIPOS(id_equipo)
);

SELECT * FROM PARTIDOS;
SELECT nombre, posicion FROM JUGADORES;
