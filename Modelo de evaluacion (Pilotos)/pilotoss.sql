Create database CarrerasAutos;
Use CarrerasAutos;

Create Table Carreras
(
id_carrera int primary key auto_increment,
Nombre Varchar (20),
id_circuito int,
Fecha date,
Vueltas Int,
Foreign key (id_circuito) References Circuitos(id_circuito)
);

Create Table Pilotos
(
id_piloto int primary key auto_increment,
Nombre Varchar (20),
Apellido varchar (20),
DNI Int
);

Create Table Participaciones
(
id_participacion int primary key auto_increment,
id_carrera int,
id_piloto int,
id_auto int,
Puesto int,
Puntos Int,
Foreign key (id_carrera) References Carreras(id_carrera),
Foreign key (id_piloto) References Pilotos(id_piloto),
Foreign key (id_auto) References Autos(id_auto),
Tiempo datetime
);

Create Table Escuderias
(
id_escuderia int primary key auto_increment,
Nombre Varchar (20)
);

Create Table Circuitos
(
id_circuito int primary key auto_increment,
Nombre Varchar (20),
Ciudad varchar (20),
Pais varchar (20),
Longitud Int
);

Create Table Autos
(
id_auto int primary key auto_increment,
id_escuderia int,
Foreign key (id_escuderia) References Escuderias(id_escuderia),
Marca Varchar (20),
Modelo varchar (20),
Precio Int,
Año_fabricacion date,
Potencia int
);

INSERT INTO Escuderias (Nombre)
VALUES 
('Ferrari'),
('Mercedes'),
('McLaren');


INSERT INTO Circuitos (Nombre, Ciudad, Pais, Longitud)
VALUES 
('Monza', 'Monza', 'Italia', 5793),
('Silverstone', 'Silverstone', 'Inglaterra', 5891),
('Interlagos', 'Sao Paulo', 'Brasil', 4309);


INSERT INTO Pilotos (Nombre, Apellido, DNI)
VALUES 
('Carlos', 'Sainz', 40123456),
('Lewis', 'Hamilton', 38987654),
('Lando', 'Norris', 42567890);


INSERT INTO Autos (id_escuderia, Marca, Modelo, Precio, Año_fabricacion, Potencia)
VALUES 
(1, 'Ferrari', 'SF-24', 20000000, '2024-01-15', 1000),
(2, 'Mercedes', 'W15', 18000000, '2024-02-20', 1020),
(3, 'McLaren', 'MCL38', 19000000, '2024-03-10', 1010);


INSERT INTO Carreras (Nombre, id_circuito, Fecha, Vueltas)
VALUES 
('Gran Premio Italia', 1, '2025-09-07', 53),
('Gran Premio Reino', 2, '2025-07-06', 52),
('Gran Premio Brasil', 3, '2025-11-09', 71);


INSERT INTO Participaciones (id_carrera, id_piloto, id_auto, Puesto, Puntos, Tiempo)
VALUES 
(1, 1, 1, 1, 25, '2025-09-07 01:20:35'),
(2, 2, 2, 2, 18, '2025-07-06 01:25:42'),
(3, 3, 3, 3, 15, '2025-11-09 01:30:18');

Select P.Nombre, P.Apellido, E.Nombre AS Escuderia
From Pilotos P
Inner Join Participaciones PA On P.id_piloto = PA.id_piloto
Inner Join Autos A On PA.id_auto = A.id_auto
Inner Join Escuderias E On A.id_escuderia = E.id_escuderia;

