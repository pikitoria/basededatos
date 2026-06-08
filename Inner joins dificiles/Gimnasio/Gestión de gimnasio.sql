CREATE TABLE SOCIOS 

(id_socio INT PRIMARY KEY, 
nombre VARCHAR(50), 
fecha_alta DATE);

CREATE TABLE PLANES
  
(id_plan INT PRIMARY KEY, 
tipo VARCHAR(50), 
costo DECIMAL(10,2));

CREATE TABLE PAGOS

(id_pago INT PRIMARY KEY, 
id_socio INT, 
id_plan INT, 
monto DECIMAL(10,2), 
fecha DATE,
FOREIGN KEY (id_socio) REFERENCES SOCIOS(id_socio),
FOREIGN KEY (id_plan) REFERENCES PLANES(id_plan)
);

SELECT S.nombre,
COUNT(P.id_pago)
FROM SOCIOS S
INNER JOIN PAGOS P ON S.id_socio = P.id_socio
GROUP BY S.id_socio
HAVING SUM(P.monto) > (SELECT costo FROM PLANES WHERE tipo = 'Premium'); 

SELECT PL.nombre, SUM(PL.tipo) AS RecaudacionTotaL
FROM PLANES PL
INNER JOIN SOCIOS S ON PLA.id_plan=  S.id_plan
INNER JOIN PAGOS PA  ON S.id_socio = PA.id_socio
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

