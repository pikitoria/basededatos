CREATE DATABASE MascotaVirtual;
USE MascotaVirtual;

CREATE TABLE Players(
    IDplayer INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Pets(
    IDpet INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    fecha_creacion DATE NOT NULL
);

CREATE TABLE Sessions(
    IDsession INT AUTO_INCREMENT PRIMARY KEY,
    IDplayer INT NOT NULL,
    IDpet INT NOT NULL,
    inicio DATETIME NOT NULL,
    fin DATETIME,
    duracion INT,
    FOREIGN KEY(IDplayer) REFERENCES Players(IDplayer),
    FOREIGN KEY(IDpet) REFERENCES Pets(IDpet)
);

CREATE TABLE PetStateLogs(
    IDlog INT AUTO_INCREMENT PRIMARY KEY,
    IDsession INT NOT NULL,
    timestamp DATETIME NOT NULL,
    hambre INT CHECK(hambre BETWEEN 0 AND 100),
    diversion INT CHECK(diversion BETWEEN 0 AND 100),
    higiene INT CHECK(higiene BETWEEN 0 AND 100),
    energia INT CHECK(energia BETWEEN 0 AND 100),
    salud INT CHECK(salud BETWEEN 0 AND 100),
    FOREIGN KEY(IDsession) REFERENCES Sessions(IDsession)
);

CREATE TABLE ActionTypes(
    IDaction INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Effects(
    IDeffect INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);

CREATE TABLE ActionEffects(
    IDactionEffect INT AUTO_INCREMENT PRIMARY KEY,
    IDaction INT NOT NULL,
    IDeffect INT NOT NULL,
    valor INT NOT NULL,
    FOREIGN KEY(IDaction) REFERENCES ActionTypes(IDaction),
    FOREIGN KEY(IDeffect) REFERENCES Effects(IDeffect)
);

CREATE TABLE ActionLogs(
    IDlog INT AUTO_INCREMENT PRIMARY KEY,
    IDsession INT NOT NULL,
    IDaction INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY(IDsession) REFERENCES Sessions(IDsession),
    FOREIGN KEY(IDaction) REFERENCES ActionTypes(IDaction)
);

CREATE TABLE Events(
    IDevent INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE EventLogs(
    IDlog INT AUTO_INCREMENT PRIMARY KEY,
    IDsession INT NOT NULL,
    IDevent INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY(IDsession) REFERENCES Sessions(IDsession),
    FOREIGN KEY(IDevent) REFERENCES Events(IDevent)
);

CREATE TABLE SessionResults(
    IDresult INT AUTO_INCREMENT PRIMARY KEY,
    IDsession INT NOT NULL,
    felicidad_promedio INT,
    duracion_total INT,
    estado_final VARCHAR(30),
    FOREIGN KEY(IDsession) REFERENCES Sessions(IDsession)
);

INSERT INTO Players(nombre,email)
VALUES
('Luciana','luciana@mail.com'),
('Juan','juan@mail.com'),
('Ana','ana@mail.com');

INSERT INTO Pets(nombre,tipo,fecha_creacion)
VALUES
('Firulais','Perro','2026-08-01'),
('Michi','Gato','2026-08-02'),
('Pipo','Conejo','2026-08-03');

INSERT INTO ActionTypes(nombre)
VALUES
('Alimentar'),
('Jugar'),
('Asear'),
('Dormir');

INSERT INTO Effects(nombre)
VALUES
('Hambre'),
('Diversion'),
('Higiene'),
('Energia'),
('Salud');

INSERT INTO ActionEffects(IDaction,IDeffect,valor)
VALUES
(1,1,-30),
(1,5,10),

(2,1,10),
(2,2,40),
(2,3,-10),
(2,4,-20),
(2,5,5),

(3,3,50),
(3,4,-10),
(3,5,5),

(4,1,-10),
(4,4,50),
(4,5,10);

INSERT INTO Events(nombre,descripcion)
VALUES
('Se enferma','Disminuye la salud'),
('Encuentra juguete','Aumenta la diversion'),
('Se ensucia','Disminuye la higiene'),
('Visita al veterinario','Mejora la salud');

INSERT INTO Sessions(IDplayer,IDpet,inicio,fin,duracion)
VALUES
(1,1,'2026-08-05 10:00:00','2026-08-05 12:00:00',120),
(2,2,'2026-08-05 14:00:00','2026-08-05 15:30:00',90);

INSERT INTO PetStateLogs(
    IDsession,
    timestamp,
    hambre,
    diversion,
    higiene,
    energia,
    salud
)
VALUES
(1,'2026-08-05 10:00:00',50,50,50,50,80),
(2,'2026-08-05 14:00:00',50,50,50,50,80);

INSERT INTO SessionResults(
    IDsession,
    felicidad_promedio,
    duracion_total,
    estado_final
)
VALUES
(1,75,120,'Feliz'),
(2,60,90,'Cansado');

DELIMITER //

CREATE PROCEDURE sp_iniciarsesion(
    IN p_idplayer INT,
    IN p_idpet INT
)
BEGIN

    INSERT INTO Sessions(
        IDplayer,
        IDpet,
        inicio,
        fin,
        duracion
    )
    VALUES(
        p_idplayer,
        p_idpet,
        NOW(),
        NULL,
        0
    );

    INSERT INTO PetStateLogs(
        IDsession,
        timestamp,
        hambre,
        diversion,
        higiene,
        energia,
        salud
    )
    VALUES(
        LAST_INSERT_ID(),
        NOW(),
        50,
        50,
        50,
        50,
        80
    );

    SELECT
        LAST_INSERT_ID() AS NuevaSesion,
        p_idplayer AS Jugador,
        p_idpet AS Mascota;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_alimentar(
    IN p_idsession INT,
    IN p_porciones INT
)
BEGIN

    INSERT INTO ActionLogs(
        IDsession,
        IDaction,
        timestamp
    )
    VALUES(
        p_idsession,
        1,
        NOW()
    );

    INSERT INTO PetStateLogs(
        IDsession,
        timestamp,
        hambre,
        diversion,
        higiene,
        energia,
        salud
    )
    SELECT
        p_idsession,
        NOW(),
        hambre - (30 * p_porciones),
        diversion,
        higiene,
        energia + (5 * p_porciones),
        salud + (10 * p_porciones)
    FROM PetStateLogs
    WHERE IDsession = p_idsession
    ORDER BY IDlog DESC
    LIMIT 1;

    SELECT *
    FROM PetStateLogs
    WHERE IDsession = p_idsession
    ORDER BY IDlog DESC
    LIMIT 1;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_jugar(
    IN p_idsession INT,
    IN p_minutos INT
)
BEGIN

    INSERT INTO ActionLogs(
        IDsession,
        IDaction,
        timestamp
    )
    VALUES(
        p_idsession,
        2,
        NOW()
    );

    INSERT INTO PetStateLogs(
        IDsession,
        timestamp,
        hambre,
        diversion,
        higiene,
        energia,
        salud
    )
    SELECT
        p_idsession,
        NOW(),
        hambre + (p_minutos / 3),
        diversion + p_minutos,
        higiene - (p_minutos / 4),
        energia - (p_minutos / 2),
        salud + 5
    FROM PetStateLogs
    WHERE IDsession = p_idsession
    ORDER BY IDlog DESC
    LIMIT 1;

    SELECT *
    FROM PetStateLogs
    WHERE IDsession = p_idsession
    ORDER BY IDlog DESC
    LIMIT 1;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_asear(
    IN p_idsession INT,
    IN p_intensidad INT
)
BEGIN

    INSERT INTO ActionLogs(
        IDsession,
        IDaction,
        timestamp
    )
    VALUES(
        p_idsession,
        3,
        NOW()
    );

    INSERT INTO PetStateLogs(
        IDsession,
        timestamp,
        hambre,
        diversion,
        higiene,
        energia,
        salud
    )
    SELECT
        p_idsession,
        NOW(),
        hambre,
        diversion,
        higiene + (50 * p_intensidad),
        energia - (10 * p_intensidad),
        salud + (5 * p_intensidad)
    FROM PetStateLogs
    WHERE IDsession = p_idsession
    ORDER BY IDlog DESC
    LIMIT 1;

    SELECT *
    FROM PetStateLogs
    WHERE IDsession = p_idsession
    ORDER BY IDlog DESC
    LIMIT 1;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_dormir(
    IN p_idsession INT,
    IN p_horas INT
)
BEGIN

    INSERT INTO ActionLogs(
        IDsession,
        IDaction,
        timestamp
    )
    VALUES(
        p_idsession,
        4,
        NOW()
    );

    INSERT INTO PetStateLogs(
        IDsession,
        timestamp,
        hambre,
        diversion,
        higiene,
        energia,
        salud
    )
    SELECT
        p_idsession,
        NOW(),
        hambre - (10 * p_horas),
        diversion,
        higiene,
        energia + (50 * p_horas),
        salud + (10 * p_horas)
    FROM PetStateLogs
    WHERE IDsession = p_idsession
    ORDER BY IDlog DESC
    LIMIT 1;

    SELECT *
    FROM PetStateLogs
    WHERE IDsession = p_idsession
    ORDER BY IDlog DESC
    LIMIT 1;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_buscarjugador(
    IN p_nombre VARCHAR(50),
    IN p_email VARCHAR(100)
)
BEGIN

    SELECT *
    FROM Players
    WHERE nombre = p_nombre
       OR email = p_email;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_buscarmascota(
    IN p_tipo VARCHAR(30),
    IN p_fecha DATE
)
BEGIN

    SELECT *
    FROM Pets
    WHERE tipo = p_tipo
    AND fecha_creacion >= p_fecha;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_buscarevento(
    IN p_nombre VARCHAR(50),
    IN p_descripcion VARCHAR(100)
)
BEGIN

    SELECT *
    FROM Events
    WHERE nombre = p_nombre
       OR descripcion = p_descripcion;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_sesionesmascota(
    IN p_idpet INT,
    IN p_duracion INT
)
BEGIN

    SELECT *
    FROM Sessions
    WHERE IDpet = p_idpet
    AND duracion >= p_duracion;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_veracciones(
    IN p_idsession INT,
    IN p_idaction INT
)
BEGIN

    SELECT
        al.IDlog,
        a.nombre,
        al.timestamp
    FROM ActionLogs al
    INNER JOIN ActionTypes a
        ON al.IDaction = a.IDaction
    WHERE al.IDsession = p_idsession
    AND al.IDaction = p_idaction;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_estadisticas(
    IN p_estado VARCHAR(30),
    IN p_felicidad INT,
    IN p_duracion INT
)
BEGIN

    SELECT *
    FROM SessionResults
    WHERE estado_final = p_estado
    AND felicidad_promedio >= p_felicidad
    AND duracion_total >= p_duracion;

END //

DELIMITER ;
