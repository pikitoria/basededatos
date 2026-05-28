CREATE DATABASE EcommerceTech;
USE EcommerceTech;


CREATE TABLE CATEGORIAS (
    id_cat INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cat VARCHAR(50) NOT NULL
);

CREATE TABLE PRODUCTOS (
    id_prod INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL, 
    id_cat INT,
    FOREIGN KEY (id_cat) REFERENCES CATEGORIAS(id_cat)
);

CREATE TABLE DETALLE_VENTA (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_prod INT,
    cantidad INT NOT NULL,
    precio_unit DECIMAL(10, 2),
    FOREIGN KEY (id_prod) REFERENCES PRODUCTOS(id_prod)
);


INSERT INTO CATEGORIAS (nombre_cat) VALUES ('Celulares', 'Laptops', 'Audio', 'Periféricos', 'Monitores');
INSERT INTO PRODUCTOS (nombre, precio, id_cat) VALUES 
('iPhone 15', 1200000, 1), ('MacBook Air', 1500000, 2), ('Sony WH1000', 350000, 3), 
('Mouse Logi', 45000, 4), ('Monitor LG 27', 400000, 5);
INSERT INTO DETALLE_VENTA (id_prod, cantidad, precio_unit) VALUES 
(1, 10, 1200000), (2, 5, 1500000), (3, 12, 350000), (4, 15, 45000), (5, 8, 400000);


SELECT C.nombre_cat, P.nombre, SUM(D.cantidad) AS TotalVendido
FROM CATEGORIAS C
INNER JOIN PRODUCTOS P ON C.id_cat = P.id_cat
INNER JOIN DETALLE_VENTA D ON P.id_prod = D.id_prod
GROUP BY P.id_prod
HAVING SUM(D.cantidad) > 500; 

SELECT C.nombre_cat, AVG(P.precio) AS PrecioPromedio
FROM CATEGORIAS C
INNER JOIN PRODUCTOS P ON C.id_cat = P.id_cat
INNER JOIN DETALLE_VENTA D ON P.id_prod = D.id_prod
GROUP BY C.id_cat
HAVING AVG(P.precio) > 1500 AND SUM(D.cantidad) >= 10;


SELECT C.nombre_cat, SUM(D.cantidad * D.precio_unit) AS Recaudacion
FROM CATEGORIAS C
INNER JOIN PRODUCTOS P ON C.id_cat = P.id_cat
INNER JOIN DETALLE_VENTA D ON P.id_prod = D.id_prod
WHERE P.precio < 100 
GROUP BY C.id_cat
HAVING SUM(D.cantidad * D.precio_unit) < 5000;