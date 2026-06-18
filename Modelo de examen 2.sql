CREATE DATABASE CartoonNET;
USE CartoonNET;

CREATE TABLE Series
(
id_serie INT AUTO_INCREMENT PRIMARY KEY,
 nombre_serie VARCHAR (30), 
 año_estreno DATE, 
 creador VARCHAR (30)
 ) ;
 
 CREATE TABLE Personajes
 (
 id_personaje INT AUTO_INCREMENT PRIMARY KEY,
 FOREIGN KEY (id_serie) REFERENCES Series,
 nombre_personaje VARCHAR (30),
 rol VARCHAR (30), 
 nivel_energia INT (3)
 );
 
 CREATE TABLE Episodios
 (
 id_episodio INT AUTO_INCREMENT PRIMARY KEY, 
 FOREIGN KEY (id_serie) REFERENCES Series,
 titulo_episodio VARCHAR (30), 
 duracion_minutos INT (4),
 rating_audiencia INT (1)
 );
 
 CREATE TABLE Habilidades_especiales 
 (
 id_habilidad INT AUTO_INCREMENT PRIMARY KEY, 
 FOREIGN KEY (id_personaje) REFERENCES Personajes, 
 nombre_habilidad VARCHAR (20),
 tipo_habilidad INT (20)
 );
 
 CREATE TABLE Enemigos_historicos
 (
 id_rivalidad INT AUTO_INCREMENT PRIMARY KEY , 
 FOREIGN KEY (id_heroe) REFERENCES Personajes,
 FOREIGN KEY (id_villano) REFERENCES Personajes, 
encuentros_totales INT (3)
);

CREATE TABLE Objetos_Misticos
(
id_objeto INT AUTO_INCREMENT PRIMARY KEY, 
nombre_objeto VARCHAR (20), 
FOREIGN KEY (id_personaje_dueño) REFERENCES Personajes,
 valor_subasta INT (5)
);

INSERT INTO PERSONAJES (nombre_personaje, id_serie, rol, nivel_energia)
VALUES ("Finn el Humano", "Hora de Aventura", "Protagonista", "85") , ("Jake el Perro", "Hora de Aventura", "Protagonista", "90"), ("Rey Helado", "Hora de Aventura", "Antagonista", "75"), ("Ben Tennyson", "Ben 10", "Protagonista", "95"), ("Vilgax", "Ben 10", "Antagonista", "98"), ("Puro Hueso", "Billy y Mandy", "Secundario", "80"), ("Mordecai", "Un Show Más", "Protagonista", "60"), ("Rigby", "Un Show Más", "Protagonista", "55"), ("Coraje", "Coraje el Perro Cobarde", "Protagonista", "40"), ("Dexter", "El laboratorio de Dexter", "Protagonista", "70");


SELECT nombre_serie, creador FROM SERIES ORDER BY nombre_serie ASC;
SELECT nombre_personaje, rol FROM PERSONAJES WHERE nombre_personaje LIKE 'B%' OR nombre_personaje LIKE 'F%';
SELECT * FROM EPISODIOS WHERE duracion_minutos > 11 AND rating_audiencia > 8.5;
SELECT * FROM OBJETOS_MISTICOS WHERE nombre_objeto LIKE '%Espada%' OR nombre_objeto LIKE '%Anillo%';
SELECT MIN(nivel_energia), MAX(nivel_energia) FROM PERSONAJES WHERE rol = 'Antagonista';
SELECT tipo_habilidad, COUNT(*) FROM HABILIDADES_ESPECIALES GROUP BY tipo_habilidad;
SELECT nombre_personaje, nivel_energia FROM PERSONAJES ORDER BY nivel_energia DESC, nombre_personaje ASC;
SELECT id_personaje_dueño, SUM(valor_subasta) FROM OBJETOS_MISTICOS WHERE valor_subasta > 5000 GROUP BY id_personaje_dueño ORDER BY SUM(valor_subasta) DESC;
SELECT id_serie, AVG(rating_audiencia) FROM EPISODIOS GROUP BY id_serie HAVING AVG(rating_audiencia) > 7.5;
SELECT id_serie, COUNT(*) FROM PERSONAJES WHERE nivel_energia > 50 GROUP BY id_serie;
SELECT AVG(E.duracion_minutos) FROM EPISODIOS E JOIN SERIES S ON E.id_serie = S.id_serie WHERE S.año_estreno > 2010;
SELECT id_personaje, COUNT(*) FROM HABILIDADES_ESPECIALES GROUP BY id_personaje HAVING COUNT(*) > 3;
SELECT * FROM ENEMIGOS_HISTORICOS WHERE encuentros_totales > 15 ORDER BY encuentros_totales DESC;
SELECT id_personaje_dueño, MAX(valor_subasta) FROM OBJETOS_MISTICOS GROUP BY id_personaje_dueño HAVING MAX(valor_subasta) > 100000;
SELECT id_serie, COUNT(*) FROM EPISODIOS GROUP BY id_serie ORDER BY COUNT(*) DESC;