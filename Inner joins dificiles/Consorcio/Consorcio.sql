CREATE DATABASE Consorcios;
USE Consorcios;

CREATE TABLE EDIFICIOS (
    id_edif INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(150)
);

CREATE TABLE UNIDADES (
    id_unit INT PRIMARY KEY AUTO_INCREMENT,
    nro_piso INT,
    id_edif INT,
    FOREIGN KEY (id_edif) REFERENCES EDIFICIOS(id_edif)
);

CREATE TABLE EXPENSAS (
    id_exp INT PRIMARY KEY AUTO_INCREMENT,
    id_unit INT,
    monto DECIMAL(10, 2) NOT NULL,
    estado ENUM('Pago', 'Impago'),
    FOREIGN KEY (id_unit) REFERENCES UNIDADES(id_unit)
);

INSERT INTO EDIFICIOS (nombre, direccion) VALUES ('Torre A', 'Av. 1'), ('Torre B', 'Av. 2'), ('Edif. Sur', 'Calle 5'), ('Edif. Norte', 'Calle 8'), ('Altos', 'Ruta 9');
INSERT INTO UNIDADES (nro_piso, id_edif) VALUES (1, 1), (2, 1), (1, 2), (5, 3), (10, 4);
INSERT INTO EXPENSAS (id_unit, monto, estado) VALUES 
(1, 50000, 'Impago'), (2, 60000, 'Pago'), (3, 45000, 'Impago'), (4, 30000, 'Pago'), (5, 120000, 'Impago');

SELECT E.nombre, SUM(EX.monto) AS DeudaTotal
FROM EDIFICIOS E
INNER JOIN UNIDADES U ON E.id_edif = U.id_edif
INNER JOIN EXPENSAS EX ON U.id_unit = EX.id_unit
WHERE EX.estado = 'Impago'
GROUP BY E.id_edif
HAVING SUM(EX.monto) > 1000000 AND COUNT(U.id_unit) > 5;

SELECT E.nombre, AVG(EX.monto) AS PromedioPagado
FROM EDIFICIOS E
INNER JOIN UNIDADES U ON E.id_edif = U.id_edif
INNER JOIN EXPENSAS EX ON U.id_unit = EX.id_unit
WHERE EX.estado = 'Pago'
GROUP BY E.id_edif
HAVING AVG(EX.monto) >= 20000;

SELECT E.nombre, SUM(EX.monto) AS RecaudacionReal
FROM EDIFICIOS E
INNER JOIN UNIDADES U ON E.id_edif = U.id_edif
INNER JOIN EXPENSAS EX ON U.id_unit = EX.id_unit
WHERE EX.estado = 'Pago'
GROUP BY E.id_edif
ORDER BY RecaudacionReal DESC 
LIMIT 3;