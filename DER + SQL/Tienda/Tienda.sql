CREATE DATABASE TIENDA;
USE TIENDA;

CREATE TABLE ROPA (
    id_ropa INT AUTO_INCREMENT PRIMARY KEY,
    prenda VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE VENDEDORES (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE VENTAS (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_ropa INT,
    id_vendedor INT,
    estado_pedido ENUM('Pendiente', 'Enviado', 'Entregado'),
    FOREIGN KEY (id_ropa) REFERENCES ROPA(id_ropa),
    FOREIGN KEY (id_vendedor) REFERENCES VENDEDORES(id_vendedor)
);


INSERT INTO ROPA (prenda, precio) VALUES ('Remera', 1500), ('Pantalón', 3000), ('Buzo', 4500);
INSERT INTO VENDEDORES (nombre) VALUES ('Marcos'), ('Julia'), ('Roberto');
INSERT INTO VENTAS (id_ropa, id_vendedor, estado_pedido) VALUES (1, 2, 'Entregado'), (2, 1, 'Pendiente'), (3, 3, 'Enviado');

SELECT prenda, precio FROM ROPA;

SELECT V.id_venta, VEN.nombre FROM VENTAS V JOIN VENDEDORES VEN ON V.id_vendedor = VEN.id_vendedor;