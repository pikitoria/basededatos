CREATE DATABASE DeliveryComida;
USE DeliveryComida;


CREATE TABLE RESTAURANTES (
    id_rest INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    zona VARCHAR(50)
);

CREATE TABLE PLATOS (
    id_plato INT AUTO_INCREMENT PRIMARY KEY,
    nombre_p VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL, 
    id_rest INT,
    FOREIGN KEY (id_rest) REFERENCES RESTAURANTES(id_rest) ON DELETE CASCADE 
);

CREATE TABLE PEDIDOS (
    id_ped INT AUTO_INCREMENT PRIMARY KEY,
    id_plato INT,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_plato) REFERENCES PLATOS(id_plato)
);


INSERT INTO RESTAURANTES (nombre, zona) VALUES ('Pizza House', 'Centro'), ('Sushi Zen', 'Norte'), ('Burger King', 'Sur'), ('Pasta Grill', 'Oeste'), ('Pizza Planet', 'Centro');
INSERT INTO PLATOS (nombre_p, precio, id_rest) VALUES ('Pizza Muzzarella', 1200, 1), ('Roll Dragon', 1800, 2), ('Whopper', 900, 3), ('Ravioles', 1600, 4), ('Pizza Pepperoni', 1400, 5);
INSERT INTO PEDIDOS (id_plato, cantidad) VALUES (1, 50), (2, 30), (3, 100), (4, 45), (5, 60);


SELECT R.nombre, SUM(PE.cantidad) AS TotalVentas
FROM RESTAURANTES R
INNER JOIN PLATOS P ON R.id_rest = P.id_rest
INNER JOIN PEDIDOS PE ON P.id_plato = PE.id_plato
GROUP BY R.id_rest
HAVING COUNT(DISTINCT P.id_plato) > 5 AND SUM(PE.cantidad) > 200; 

SELECT R.nombre, AVG(P.precio * PE.cantidad) AS PromedioIngresos
FROM RESTAURANTES R
INNER JOIN PLATOS P ON R.id_rest = P.id_rest
INNER JOIN PEDIDOS PE ON P.id_plato = PE.id_plato
WHERE P.precio > 15000
GROUP BY R.id_rest;

SELECT P.nombre_p, R.nombre AS Restaurante
FROM PLATOS P
INNER JOIN RESTAURANTES R ON P.id_rest = R.id_rest
WHERE R.nombre LIKE '%Pizza%'
LIMIT 10;