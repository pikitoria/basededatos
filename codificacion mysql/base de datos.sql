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

delimiter //
create procedure sp_iniciarsesion(in p_idpet int)
begin
    insert into sessions (idpet, inicio, fin, duracion)
    values (p_idpet, now(), null, 0);

    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    values ((select max(idsession) from sessions), now(), 50, 50, 50, 50, 80);

    insert into sessionresults (idsession, felicidad_promedio, duracion_total, estado_final)
    values ((select max(idsession) from sessions), 0, 0, 'jugando');

    select max(idsession) as idsession from sessions;
end //
delimiter ;

delimiter //
create procedure sp_alimentar(in p_idsession int)
begin
    insert into actionlogs (idsession, idaction, timestamp)
    values (p_idsession, 1, now());

    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    select p_idsession, now(), hambre - 30, diversion, higiene, energia, salud + 10
    from petstatelogs
    where idsession = p_idsession
    order by idlog desc limit 1;
end //
delimiter ;

delimiter //
create procedure sp_jugar(in p_idsession int)
begin
    insert into actionlogs (idsession, idaction, timestamp)
    values (p_idsession, 2, now());

    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    select p_idsession, now(), hambre + 10, diversion + 40, higiene - 10, energia - 20, salud + 5
    from petstatelogs
    where idsession = p_idsession
    order by idlog desc limit 1;
end //
delimiter ;

delimiter //
create procedure sp_asear(in p_idsession int)
begin
    insert into actionlogs (idsession, idaction, timestamp)
    values (p_idsession, 3, now());

    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    select p_idsession, now(), hambre, diversion, higiene + 50, energia - 10, salud + 5
    from petstatelogs
    where idsession = p_idsession
    order by idlog desc limit 1;
end //
delimiter ;

delimiter //
create procedure sp_dormir(in p_idsession int)
begin
    insert into actionlogs (idsession, idaction, timestamp)
    values (p_idsession, 4, now());

    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    select p_idsession, now(), hambre - 10, diversion, higiene, energia + 50, salud + 10
    from petstatelogs
    where idsession = p_idsession
    order by idlog desc limit 1;
end //
delimiter ;

delimiter //
create procedure sp_pasartiempo(in p_idsession int)
begin
    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    select p_idsession, now(), hambre + 5, diversion - 5, higiene - 3, energia - 4, salud
    from petstatelogs
    where idsession = p_idsession
    order by idlog desc limit 1;
end //
delimiter ;

delimiter //
create procedure sp_enfermar(in p_idsession int)
begin
    insert into eventlogs (idsession, idevent, timestamp)
    values (p_idsession, 1, now());

    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    select p_idsession, now(), hambre, diversion, higiene, energia, salud - 30
    from petstatelogs
    where idsession = p_idsession
    order by idlog desc limit 1;
end //
delimiter ;

delimiter //
create procedure sp_encontrarjuguete(in p_idsession int)
begin
    insert into eventlogs (idsession, idevent, timestamp)
    values (p_idsession, 2, now());

    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    select p_idsession, now(), hambre, diversion + 20, higiene, energia, salud
    from petstatelogs
    where idsession = p_idsession
    order by idlog desc limit 1;
end //
delimiter ;

delimiter //
create procedure sp_estadisticas()
begin
    select count(*) as total_sesiones, avg(felicidad_promedio) as promedio_felicidad
    from sessionresults;
end //
delimiter ;
