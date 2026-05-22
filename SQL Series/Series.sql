CREATE DATABASE SQL_Series;
USE SQL_Series;

CREATE TABLE Series (
    IDSerie INT AUTO_INCREMENT PRIMARY KEY, -- Clave primaria autoincremental [4, 5]
    Nombre VARCHAR(100) NOT NULL,
    Genero VARCHAR(50),
    Año_de_Lanzamiento INT NOT NULL,
    Presupuesto DECIMAL(15, 2), -- Decimal para dinero [3]
    Plataforma ENUM('Netflix', 'Disney+', 'Max', 'Prime Video', 'Apple TV'), -- Lista cerrada [3]
    Director VARCHAR(100),
    Edad_Director INT,
    Sueldo_Director DECIMAL(15, 2)
);

CREATE TABLE Temporadas (
    ID_Temporada INT AUTO_INCREMENT PRIMARY KEY,
    Numero_Temporada INT NOT NULL,
    Nombre_Temporada VARCHAR(100),
    Descripcion_Temporada TEXT,
    IDSerie INT,
    FOREIGN KEY (IDSerie) REFERENCES Series(IDSerie) ON DELETE CASCADE -- Integridad referencial [2, 6]
);

CREATE TABLE Personajes (
    IdPersonaje INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Edad INT,
    genero ENUM('Masculino', 'Femenino', 'Otro'),
    IDSerie INT,
    FOREIGN KEY (IDSerie) REFERENCES Series(IDSerie)
);

CREATE TABLE Episodios (
    ID_Episodio INT AUTO_INCREMENT PRIMARY KEY,
    Numero_de_episodio INT,
    Nombre_Episodio VARCHAR(100),
    Descripcion_Puntuacion TEXT,
    Puntuacion DECIMAL(3, 1),
    IDTemporada INT,
    FOREIGN KEY (IDTemporada) REFERENCES Temporadas(ID_Temporada)
);

INSERT INTO Series (Nombre, Genero, Año_de_Lanzamiento, Presupuesto, Plataforma, Director, Edad_Director, Sueldo_Director) 
VALUES 
('Stranger Things', 'Sci-Fi', 2016, 30000000, 'Netflix', 'Duffer Brothers', 40, 500000),
('The Bear', 'Drama', 2022, 12000000, 'Disney+', 'Christopher Storer', 43, 350000),
('The Boys', 'Acción', 2019, 11000000, 'Prime Video', 'Eric Kripke', 50, 400000);

INSERT INTO Personajes (Nombre, Edad, genero, IDSerie) 
VALUES ('Eleven', 14, 'Femenino', 1), ('Carmy Berzatto', 28, 'Masculino', 2); 


    SELECT genero, COUNT(*) FROM Personajes GROUP BY genero;

    SELECT DISTINCT Director FROM Series WHERE Plataforma = 'Prime Video';

    SELECT P.Nombre, P.Edad FROM Personajes P JOIN Series S ON P.IDSerie = S.IDSerie WHERE S.Plataforma = 'Disney+' ORDER BY P.Edad DESC;

    SELECT S.Nombre, COUNT(T.ID_Temporada) AS Total_Temporadas FROM Series S JOIN Temporadas T ON S.IDSerie = T.IDSerie GROUP BY S.IDSerie ORDER BY Total_Temporadas DESC LIMIT 1;

    SELECT P.Nombre FROM Personajes P JOIN Series S ON P.IDSerie = S.IDSerie WHERE S.Nombre = 'Hora de Aventura';

SELECT Nombre, Presupuesto FROM Series ORDER BY Presupuesto DESC LIMIT 1;
    SELECT E.Nombre_Episodio, E.Puntuacion FROM Episodios E JOIN Temporadas T ON E.IDTemporada = T.ID_Temporada JOIN Series S ON T.IDSerie = S.IDSerie WHERE S.Año_de_Lanzamiento <= 2020 ORDER BY E.Puntuacion DESC LIMIT 1;
