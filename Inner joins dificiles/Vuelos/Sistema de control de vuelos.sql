CREATE DATABASE ControlVuelos;
USE ControlVuelos;

CREATE TABLE AVIONES (
    id_avion INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(50),
    capacidad INT
);

CREATE TABLE VUELOS (
    nro_vuelo INT PRIMARY KEY,
    origen VARCHAR(50),
    destino VARCHAR(50),
    id_avion INT,
    FOREIGN KEY (id_avion) REFERENCES AVIONES(id_avion)
);

CREATE TABLE PASAJEROS_VUELO (
    id_ticket INT AUTO_INCREMENT PRIMARY KEY,
    nro_vuelo INT,
    precio_ticket DECIMAL(10,2),
    dni_pasajero VARCHAR(20),
    FOREIGN KEY (nro_vuelo) REFERENCES VUELOS(nro_vuelo)
);

SELECT A.modelo, SUM(P.precio_ticket) AS TotalRecaudado
FROM AVIONES A
INNER JOIN VUELOS V ON A.id_avion = V.id_avion
INNER JOIN PASAJEROS_VUELO P ON V.nro_vuelo = P.nro_vuelo
GROUP BY A.id_avion
HAVING SUM(P.precio_ticket) > 2000000 AND COUNT(P.id_ticket) > 100;
