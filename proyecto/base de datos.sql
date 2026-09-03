create database mascotavirtual;
use mascotavirtual;

create table players (
    IDplayer int auto_increment primary key,
    nombre varchar(50) not null,
    email varchar(100) unique not null
);

create table pets (
    IDpet int auto_increment primary key,
    IDplayer int not null,
    nombre varchar(50) not null,
    tipo varchar(30) not null,
    fecha_creacion date not null,
    foreign key (IDplayer) references players(IDplayer)
);

create table sessions (
    IDsession int auto_increment primary key,
    IDpet int not null,
    inicio datetime not null,
    fin datetime,
    duracion int,
    foreign key (IDpet) references pets(IDpet)
);

create table petstatelogs (
    IDlog int auto_increment primary key,
    IDsession int not null,
    timestamp datetime not null,
    hambre int check(hambre between 0 and 100),
    diversion int check(diversion between 0 and 100),
    higiene int check(higiene between 0 and 100),
    energia int check(energia between 0 and 100),
    salud int check(salud between 0 and 100),
    foreign key (IDsession) references sessions(IDsession)
);

create table actiontypes (
    IDaction int auto_increment primary key,
    nombre varchar(50) not null,
    efecto_hambre int,
    efecto_diversion int,
    efecto_higiene int,
    efecto_energia int,
    efecto_salud int
);

create table actionlogs (
    IDlog int auto_increment primary key,
    IDsession int not null,
    IDaction int not null,
    timestamp datetime not null,
    foreign key (IDsession) references sessions(IDsession),
    foreign key (IDaction) references actiontypes(IDaction)
);

create table events (
    IDevent int auto_increment primary key,
    nombre varchar(50) not null,
    efecto varchar(100)
);

create table eventlogs (
    IDlog int auto_increment primary key,
    IDsession int not null,
    IDevent int not null,
    timestamp datetime not null,
    foreign key (IDsession) references sessions(IDsession),
    foreign key (IDevent) references events(IDevent)
);

create table sessionresults (
    IDresult int auto_increment primary key,
    IDsession int not null,
    felicidad_promedio int,
    duracion_total int,
    estado_final varchar(30),
    foreign key (IDsession) references sessions(IDsession)
);

insert into players (nombre, email) values
('luciana', 'luciana@mail.com'),
('juan', 'juan@mail.com');

insert into pets (IDplayer, nombre, tipo, fecha_creacion) values
(1, 'firulais', 'perro', '2026-08-01'),
(2, 'michi', 'gato', '2026-08-02');

insert into sessions (IDpet, inicio, fin, duracion) values
(1, '2026-08-05 10:00:00', '2026-08-05 12:00:00', 120),
(2, '2026-08-05 14:00:00', '2026-08-05 15:30:00', 90);

insert into actiontypes (nombre, efecto_hambre, efecto_diversion, efecto_higiene, efecto_energia, efecto_salud) values
('alimentar', -30, 0, 0, 0, +10),
('jugar', +10, +40, -10, -20, +5),
('asear', 0, 0, +50, -10, +5),
('dormir', -10, 0, 0, +50, +10);

insert into actionlogs (IDsession, IDaction, timestamp) values
(1, 1, '2026-08-05 10:15:00'),
(1, 2, '2026-08-05 10:45:00'),
(2, 4, '2026-08-05 14:20:00');

insert into events (nombre, efecto) values
('se enferma', 'salud -30'),
('encuentra juguete', 'diversion +20');

insert into eventlogs (IDsession, IDevent, timestamp) values
(1, 1, '2026-08-05 11:00:00'),
(2, 2, '2026-08-05 14:40:00');

insert into sessionresults (IDsession, felicidad_promedio, duracion_total, estado_final) values
(1, 75, 120, 'feliz'),
(2, 60, 90, 'enfermo');
