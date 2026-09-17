CREATE DATABASE Pokem;
USE Pokem;

CREATE TABLE Region (
    id_region INT not null PRIMARY KEY,
    nombre_region VARCHAR(50)
);
INSERT INTO Region (id_region, nombre_region) VALUES 
(1, 'Kanto'), (2, 'Johto'), (3, 'Hoenn');

CREATE TABLE Equipos (
    ID_equipo INT not null PRIMARY KEY,
    equipo VARCHAR(50)
);
INSERT INTO Equipos (ID_equipo, equipo) VALUES 
(1, 'Team Rocket'), (2, 'Team Aqua'), (3, 'Team Magma');

CREATE TABLE Ciudades (
    id_ciudades INT not null PRIMARY KEY,
    ciudad VARCHAR(50)
);
INSERT INTO Ciudades (id_ciudades, ciudad) VALUES 
(1, 'Pueblo Paleta'), (2, 'Ciudad Verde'), (3, 'Ciudad Plateada');

CREATE TABLE IF NOT EXISTS Elementos (
    id_elemento INT not null PRIMARY KEY,
    elemento VARCHAR(50)
);
INSERT INTO Elementos (id_elemento, elemento) VALUES 
(1, 'Piedra Trueno'), (2, 'Piedra Fuego'), (3, 'Piedra Agua');

CREATE TABLE Evoluciones (
    id_evolución INT not null PRIMARY KEY,
    evolucion VARCHAR(50)
);
INSERT INTO Evoluciones (id_evolución, evolucion) VALUES 
(1, 'Raichu'), (2, 'Charmeleon'), (3, 'Wartortle');

CREATE TABLE Especies (
    id_especie INT not null PRIMARY KEY,
    especie VARCHAR(50)
);
INSERT INTO Especies (id_especie, especie) VALUES 
(1, 'Ratón'), (2, 'Llama'), (3, 'Marisco');

CREATE TABLE Gimnasios (
    id_gimnasio INT not null PRIMARY KEY,
    Nombre VARCHAR(50),
    Ciudad VARCHAR(50),
    Lider VARCHAR(20)
);
INSERT INTO Gimnasios (id_gimnasio, Nombre, Ciudad, Lider) VALUES 
(1, 'Gimnasio Roca', 'Pewter', 'Brock'),
(2, 'Gimnasio Cascada', 'Cerulean', 'Misty'),
(3, 'Gimnasio Trueno', 'Vermilion', 'Lt. Surge');

CREATE TABLE Entrenadores (
    id_entrenador INT not null PRIMARY KEY,
    id_gimnasio INT,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Ciudad VARCHAR(20),
    FOREIGN KEY (id_gimnasio) REFERENCES Gimnasios(id_gimnasio)
);
INSERT INTO Entrenadores (id_entrenador, id_gimnasio, Nombre, Apellido, Ciudad) VALUES 
(1, 1, 'Ash', 'Ketchum', 'Pallet'),
(2, 2, 'Gary', 'Oak', 'Pewter'),
(3, 3, 'Misty', 'Waterflower', 'Cerulean');

CREATE TABLE Tipos (
    id_tipo INT not null PRIMARY KEY,
    Nombre_tipo VARCHAR(50)
);
INSERT INTO Tipos (id_tipo, Nombre_tipo) VALUES 
(1, 'Eléctrico'), (2, 'Fuego'), (3, 'Agua'), (4, 'Planta'), (5, 'Tierra');

CREATE TABLE Pokemons (
    id_pokemon INT not null PRIMARY KEY,
    Nombre VARCHAR(50),
    Nivel INT, 
    Poder VARCHAR(20),
    id_tipo INT,
    id_entrenador INT,
    FOREIGN KEY (id_tipo) REFERENCES Tipos(id_tipo),
    FOREIGN KEY (id_entrenador) REFERENCES Entrenadores(id_entrenador)
);

INSERT INTO Pokemons (id_pokemon, Nombre, Nivel, Poder, id_tipo, id_entrenador) VALUES 
(1, 'Pikachu', 25, 'Impactrueno', 1, 1),
(2, 'Charizard', 40, 'Lanzallamas', 2, 1),
(3, 'Blastoise', 38, 'Hidrobomba', 3, 2),
(4, 'Starmie', 30, 'Rayo Burbuja', 3, 3),
(5, 'Venusaur', 42, 'Rayo Solar', 4, 4);

CREATE TABLE Batallas (
    id_batalla INT not null PRIMARY KEY,
    fecha DATE,
    pokemon1 INT,
    pokemon2 INT,
    ganador INT,
    FOREIGN KEY (pokemon1) REFERENCES Pokemons(id_pokemon),
    FOREIGN KEY (pokemon2) REFERENCES Pokemons(id_pokemon),
    FOREIGN KEY (ganador) REFERENCES Pokemons(id_pokemon)
);

INSERT INTO Batallas (id_batalla, fecha, pokemon1, pokemon2, ganador) VALUES 
(1, '2026-03-15', 1, 3, 1),
(2, '2026-03-16', 2, 4, 2),
(3, '2026-03-17', 5, 1, 5);

SELECT e.Nombre, e.Ciudad, g.Nombre AS Gimnasio 
FROM Entrenadores e 
JOIN Gimnasios g ON e.id_gimnasio = g.id_gimnasio;

SELECT p.Nombre, t.Nombre_tipo 
FROM Pokemons p 
JOIN Tipos t ON p.id_tipo = t.id_tipo;

SELECT * FROM Pokemons WHERE Nivel > 50;

SELECT p.Nombre, p.Poder, e.Nombre AS entrenador 
FROM Pokemons p 
JOIN Tipos t ON p.id_tipo = t.id_tipo 
JOIN Entrenadores e ON p.id_entrenador = e.id_entrenador 
WHERE t.Nombre_tipo = 'Fuego' 
ORDER BY p.Poder ASC;

SELECT p.Nombre 
FROM Pokemons p 
WHERE id_entrenador IN (
    SELECT id_entrenador FROM Entrenadores WHERE Ciudad = 'Celadon'
);

SELECT Nombre, Nivel 
FROM Pokemons 
WHERE Nivel > ( SELECT AVG(Nivel) FROM Pokemons );

SELECT Nombre 
FROM Pokemons 
WHERE id_pokemon IN ( SELECT ganador FROM Batallas );

DELIMITER //

CREATE PROCEDURE SubirNivel(IN IdEntrenador INT)
BEGIN
    UPDATE Pokemon
    SET nivel = nivel + 1
    WHERE id_entrenador = IdEntrenador;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE RegistrarBatalla(
    IN Pokemon1 INT,
    IN Pokemon2 INT,
    IN Ganador INT,
    IN Fecha DATE
)
BEGIN
    INSERT INTO Batalla(fecha, pokemon1, pokemon2, ganador)
    VALUES (Fecha, Pokemon1, Pokemon2, Ganador);
END //

DELIMITER ;
