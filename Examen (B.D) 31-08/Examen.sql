Create database Tecno;
Use Tecno;

Create table Empresas (
id_empresa int primary key auto_increment,
Nombre Varchar (20)
);

Create table Tecnicos (
id_tecnico int primary key auto_increment,
Nombre Varchar (20),
Apellido Varchar (20)
);

Create table Muestras (
id_muestra int primary key auto_increment,
Foreign key (id_empresa) References Empresas(id_empresa),
Tipo_muestra Varchar (20)
);

Create table Analisis (
id_analisi int primary key auto_increment,
Foreign key (id_muestra) References Muestras(id_muestra),
Foreign key (id_empresa) References Empresas(id_empresa),
Tipo_analisis Varchar (20),
Resultado Int,
Fecha date
);

Create table Analisis_compuestos (
id_analisiscomp int primary key auto_increment,
Foreign key (id_compuesto) References Compuestos(id_compuesto)
);

Create table Compuestos (
id_compuesto int primary key auto_increment,
Nombre Varchar (20)
);

Insert into Empresas(Nombre) values ('YPF'), ('Coca-Cola'), ('Pepsi');
Insert into Tecnicos(Nombre, Apellido) values ('', ''), ('Coca-Cola', ''), ('Pepsi', '');
Insert into Muestras(id_empresa, Tipo_muestra) values (1, 'Agua'), (2, ''), (3, '');
Insert into Empresa(nombre) values ('YPF'), ('Coca-Cola'), ('Pepsi');
Insert into Empresa(nombre) values ('YPF'), ('Coca-Cola'), ('Pepsi');
Insert into Empresa(nombre) values ('YPF'), ('Coca-Cola'), ('Pepsi');

SELECT m.id_muestra, m.Tipo_muestra, e.Nombre AS Empresa
FROM Muestras.m
INNER JOIN Empresas.e ON m.id_empresa = e.id_muestra
INNER JOIN Analisis.a ON m.id_muestra = a.Muestras 
INNER JOIN Tecnico.t ON a.id_tecnico = t.id_tecnico;