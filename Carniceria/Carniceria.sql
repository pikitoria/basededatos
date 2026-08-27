Create DataBase Carniceria;
use Carniceria;

CREATE TABLE Carniceros
 (
    id_Carnicero INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (id_Cliente) REFERENCES Clientes(id_Cliente),
    Nombre Varchar (20),
    Apellido Varchar (20)
   );
   
  CREATE TABLE Clientes
 (
    id_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre Varchar (20),
    Apellido Varchar (20),
    Telefono int (20)
   );
   
   CREATE TABLE Pedidos
 (
    id_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (id_Cliente) REFERENCES Clientes(id_Cliente),
    FOREIGN KEY (id_Carnicero) REFERENCES Carniceros(id_Carnicero),
    FOREIGN KEY (id_Corte) REFERENCES Cortes(id_Corte),
    Fecha Date
   );
   
   CREATE TABLE Cortes
 (
    id_Corte INT AUTO_INCREMENT PRIMARY KEY,
    Corte varchar (20),
    Animal varchar (20),
    Precio Int
   );
   
      CREATE TABLE Pagos
 (
    id_Pago INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_pago varchar (20)
   );
   
INSERT INTO Carniceros (id_Carnicero, id_Cliente, Nombre, Apellido) VALUES (1, 1, 'Rogelio', 'Lopez'), (2, 2, 'Guada', 'Lupe'), (3, 3, 'Maduro', 'Oso');
INSERT INTO Clientes (id_Cliente, Nombre, Apellido, Teléfono) VALUES (1, 'Luna', 'Soy'), (2, 'Tomas', 'Albillaga'), (3, 'Michael', 'Jackson' );
INSERT INTO Cortes (id_Corte, Corte, Animal, Precio) VALUES (1, 'Tapa', 'Vaca', '3900'), (2, 'Pechuga', 'Pollo', '4000'), (3, 'Vacio', 'Vaca', '15000');
INSERT INTO Pedidos (id_Pedido, id_Cliente, id_Carnicero, id_Corte, Fecha) VALUES (1, 1, 1, 1, '20-10-2023'), (2, 2, 2, 2, '15-06-2025'), (3, 3, 3, 3, '17-10-2009');
INSERT INTO Pagos (id_Pago, Tipo_pago) VALUES (1, 'Digital'), (2, 'Efectivo'), (3, 'Tarjeta de credito');

SELECT Corte, COUNT(*) AS Total
FROM Pedido
GROUP BY Corte
HAVING COUNT(*) = (
    SELECT MAX(conteo) 
    FROM (SELECT COUNT(*) AS conteo FROM Pedido GROUP BY Corte) AS subquery
);

SELECT Nombre 
FROM Cliente 
WHERE ID_Clientes = (
    SELECT ID_Clientes 
    FROM Pedido 
    GROUP BY ID_Clientes 
    ORDER BY COUNT(*) DESC 
    LIMIT 1
);


SELECT Nombre, Apellido 
FROM Carnicero 
WHERE IDCarnicero = (
    SELECT IDCarnicero 
    FROM Pedido 
    GROUP BY IDCarnicero 
    ORDER BY COUNT(*) DESC 
    LIMIT 1
);


SELECT 
    (SELECT C.Nombre FROM Cliente C WHERE C.ID_Clientes = P.ID_Clientes) AS Cliente,
    P.Corte,
    (SELECT Car.Nombre FROM Carnicero Car WHERE Car.ID_Carnicero = P.ID_Carnicero) AS Carnicero
FROM Pedido P
WHERE P.Precio = (SELECT MAX(Precio) FROM Pedido);

SELECT DISTINCT Corte, 
    (SELECT COUNT(*) FROM Pedido P2 WHERE P2.Corte = P1.Corte) AS Cantidad_Ventas
FROM Pedido P1;
