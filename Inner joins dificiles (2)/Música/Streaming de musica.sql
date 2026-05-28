CREATE DATABASE StreamingMusica;
USE StreamingMusica;

CREATE TABLE ARTISTAS (
    id_art INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE ALBUMES (
    id_alb INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    id_art INT,
    FOREIGN KEY (id_art) REFERENCES ARTISTAS(id_art)
);

CREATE TABLE REPRODUCCIONES (
    id_rep INT AUTO_INCREMENT PRIMARY KEY,
    id_alb INT,
    cant_repro INT NOT NULL,
    FOREIGN KEY (id_alb) REFERENCES ALBUMES(id_alb)
);

INSERT INTO ARTISTAS (nombre) VALUES ('Coldplay'), ('Taylor Swift'), ('Bad Bunny'), ('The Weeknd'), ('Dua Lipa');
INSERT INTO ALBUMES (titulo, id_art) VALUES ('A Rush of Blood', 1), ('Midnights', 2), ('Un Verano Sin Ti', 3), ('After Hours', 4), ('Future Nostalgia', 5);
INSERT INTO REPRODUCCIONES (id_alb, cant_repro) VALUES (1, 600000), (2, 1200000), (3, 2000000), (4, 1500000), (5, 900000);

SELECT A.nombre, SUM(R.cant_repro) AS TotalPlays
FROM ARTISTAS A
INNER JOIN ALBUMES AL ON A.id_art = AL.id_art
INNER JOIN REPRODUCCIONES R ON AL.id_alb = R.id_alb
GROUP BY A.id_art
HAVING COUNT(DISTINCT AL.id_alb) > 3 AND SUM(R.cant_repro) > 1000000; 

SELECT AL.titulo, A.nombre AS Artista, AVG(R.cant_repro) AS Promedio
FROM ALBUMES AL
INNER JOIN ARTISTAS A ON AL.id_art = A.id_art
INNER JOIN REPRODUCCIONES R ON AL.id_alb = R.id_alb
GROUP BY AL.id_alb
HAVING AVG(R.cant_repro) > 50000;

SELECT A.nombre, SUM(R.cant_repro) AS TotalReproducciones
FROM ARTISTAS A
INNER JOIN ALBUMES AL ON A.id_art = AL.id_art
INNER JOIN REPRODUCCIONES R ON AL.id_alb = R.id_alb
GROUP BY A.id_art
ORDER BY TotalReproducciones ASC 
LIMIT 1;