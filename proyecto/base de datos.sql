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

use mascotavirtual;

-- sp = stored procedure, o sea procedimiento almacenado
-- p_ = parametro, es lo que entra o sale del procedimiento
-- v_ = variable, es algo que guardo adentro para usarlo un ratoa
-- in = entra, out = sale
-- delimiter // = cambio el ; por // para que no se corte antes

delimiter //
create procedure sp_realizaraccion(
    in p_idsession int,
    in p_idaction int,
    out p_mensaje varchar(100)
)
begin
    -- v_hambre etc son variables para guardar el estado actual
    declare v_hambre int;
    declare v_diversion int;
    declare v_higiene int;
    declare v_energia int;
    declare v_salud int;
    -- v_ef = variable de efecto, cuanto sube o baja cada cosa
    declare v_ef_hambre int;
    declare v_ef_diversion int;
    declare v_ef_higiene int;
    declare v_ef_energia int;
    declare v_ef_salud int;
    -- v_existe = variable para saber si existe o no, 0 es que no existe, 1 es que si
    declare v_existe int;

    -- p_idsession = parametro con el id de la sesion
    select count(*) into v_existe from sessions where idsession = p_idsession;
    if v_existe = 0 then
        -- signal = tira un error a proposito
        -- sqlstate '45000' = codigo de error inventado por nosotros
        signal sqlstate '45000'
        set message_text = 'error: esa sesion no existe';
    end if;

    -- p_idaction = parametro con el id de la accion
    select count(*) into v_existe from actiontypes where idaction = p_idaction;
    if v_existe = 0 then
        signal sqlstate '45000'
        set message_text = 'error: esa accion no existe';
    end if;

    select efecto_hambre, efecto_diversion, efecto_higiene, efecto_energia, efecto_salud
    into v_ef_hambre, v_ef_diversion, v_ef_higiene, v_ef_energia, v_ef_salud
    from actiontypes where idaction = p_idaction;

    select hambre, diversion, higiene, energia, salud
    into v_hambre, v_diversion, v_higiene, v_energia, v_salud
    from petstatelogs
    where idsession = p_idsession
    order by idlog desc limit 1;

    -- coalesce = si viene vacio (null), pone 50
    set v_hambre = coalesce(v_hambre, 50);
    set v_diversion = coalesce(v_diversion, 50);
    set v_higiene = coalesce(v_higiene, 50);
    set v_energia = coalesce(v_energia, 50);
    set v_salud = coalesce(v_salud, 50);

    if v_salud <= 0 then
        signal sqlstate '45000'
        set message_text = 'error: la mascota esta muerta, no puede hacer acciones';
    end if;

    -- greatest = el mas grande, least = el mas chico
    -- esto es para que no se pase de 0 a 100
    set v_hambre = greatest(0, least(100, v_hambre + v_ef_hambre));
    set v_diversion = greatest(0, least(100, v_diversion + v_ef_diversion));
    set v_higiene = greatest(0, least(100, v_higiene + v_ef_higiene));
    set v_energia = greatest(0, least(100, v_energia + v_ef_energia));
    set v_salud = greatest(0, least(100, v_salud + v_ef_salud));

    insert into actionlogs (idsession, idaction, timestamp)
    values (p_idsession, p_idaction, now());

    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    values (p_idsession, now(), v_hambre, v_diversion, v_higiene, v_energia, v_salud);

    -- p_mensaje = parametro de salida, devuelve un texto
    -- concat = une textos
    set p_mensaje = 'accion guardada, salud actual: ';
    set p_mensaje = concat(p_mensaje, v_salud);
end //
delimiter ;

-- sp_alimentar = procedimiento para alimentar, usa el id 1
delimiter //
create procedure sp_alimentar(in p_idsession int, out p_mensaje varchar(100))
begin
    call sp_realizaraccion(p_idsession, 1, p_mensaje);
end //
delimiter ;

-- sp_jugar = procedimiento para jugar, usa el id 2
delimiter //
create procedure sp_jugar(in p_idsession int, out p_mensaje varchar(100))
begin
    call sp_realizaraccion(p_idsession, 2, p_mensaje);
end //
delimiter ;

-- sp_asear = procedimiento para asear, usa el id 3
delimiter //
create procedure sp_asear(in p_idsession int, out p_mensaje varchar(100))
begin
    call sp_realizaraccion(p_idsession, 3, p_mensaje);
end //
delimiter ;

-- sp_dormir = procedimiento para dormir, usa el id 4
delimiter //
create procedure sp_dormir(in p_idsession int, out p_mensaje varchar(100))
begin
    call sp_realizaraccion(p_idsession, 4, p_mensaje);
end //
delimiter ;

-- sp_pasartiempo = hace que pase el tiempo solo, sin tocar nada
delimiter //
create procedure sp_pasartiempo(in p_idsession int, out p_mensaje varchar(100))
begin
    declare v_hambre int;
    declare v_diversion int;
    declare v_higiene int;
    declare v_energia int;
    declare v_salud int;
    declare v_existe int;

    select count(*) into v_existe from sessions where idsession = p_idsession;
    if v_existe = 0 then
        signal sqlstate '45000'
        set message_text = 'error: esa sesion no existe';
    end if;

    select hambre, diversion, higiene, energia, salud
    into v_hambre, v_diversion, v_higiene, v_energia, v_salud
    from petstatelogs where idsession = p_idsession
    order by idlog desc limit 1;

    -- +5, -5 etc son cuanto cambia cada cosa con el tiempo
    set v_hambre = greatest(0, least(100, coalesce(v_hambre, 50) + 5));
    set v_diversion = greatest(0, least(100, coalesce(v_diversion, 50) - 5));
    set v_higiene = greatest(0, least(100, coalesce(v_higiene, 50) - 3));
    set v_energia = greatest(0, least(100, coalesce(v_energia, 50) - 4));
    set v_salud = coalesce(v_salud, 50);

    if v_hambre >= 90 or v_higiene <= 10 or v_energia <= 10 then
        set v_salud = greatest(0, v_salud - 10);
    end if;

    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    values (p_idsession, now(), v_hambre, v_diversion, v_higiene, v_energia, v_salud);

    set p_mensaje = concat('paso el tiempo, salud actual: ', v_salud);
end //
delimiter ;

-- sp_iniciarsesion = crea una sesion nueva
-- p_idpet = id de la mascota, p_idsession = id nuevo que devuelve
delimiter //
create procedure sp_iniciarsesion(in p_idpet int, out p_idsession int, out p_mensaje varchar(100))
begin
    declare v_existe int;

    select count(*) into v_existe from pets where idpet = p_idpet;
    if v_existe = 0 then
        signal sqlstate '45000'
        set message_text = 'error: esa mascota no existe';
    end if;

    insert into sessions (idpet, inicio, fin, duracion) values (p_idpet, now(), null, 0);
    -- last_insert_id() = el ultimo id que se creo solo
    set p_idsession = last_insert_id();

    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    values (p_idsession, now(), 50, 50, 50, 50, 80);

    insert into sessionresults (idsession, felicidad_promedio, duracion_total, estado_final)
    values (p_idsession, 0, 0, 'jugando');

    set p_mensaje = 'sesion creada';
end //
delimiter ;

-- sp_estadisticas = devuelve totales
-- p_total_sesiones = cantidad de sesiones, p_promedio_felicidad = promedio
-- decimal(5,2) = numero con 2 decimales, avg = promedio
delimiter //
create procedure sp_estadisticas(out p_total_sesiones int, out p_promedio_felicidad decimal(5,2))
begin
    select count(*) into p_total_sesiones from sessionresults;
    select avg(felicidad_promedio) into p_promedio_felicidad from sessionresults;
end //
delimiter ;

-- sp_aplicarevento = aplica un evento
-- p_idevent = id del evento, 1 = se enferma, 2 = encuentra juguete
delimiter //
create procedure sp_aplicarevento(in p_idsession int, in p_idevent int, out p_mensaje varchar(100))
begin
    declare v_hambre int;
    declare v_diversion int;
    declare v_higiene int;
    declare v_energia int;
    declare v_salud int;

    select hambre, diversion, higiene, energia, salud
    into v_hambre, v_diversion, v_higiene, v_energia, v_salud
    from petstatelogs where idsession = p_idsession
    order by idlog desc limit 1;

    insert into eventlogs (idsession, idevent, timestamp)
    values (p_idsession, p_idevent, now());

    if p_idevent = 1 then
        set v_salud = greatest(0, v_salud - 30);
    end if;

    if p_idevent = 2 then
        set v_diversion = least(100, v_diversion + 20);
    end if;

    insert into petstatelogs (idsession, timestamp, hambre, diversion, higiene, energia, salud)
    values (p_idsession, now(), v_hambre, v_diversion, v_higiene, v_energia, v_salud);

    set p_mensaje = 'evento aplicado';
end //
delimiter ;
