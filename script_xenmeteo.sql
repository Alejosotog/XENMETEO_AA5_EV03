DROP SCHEMA IF EXISTS xenmeteo;
CREATE SCHEMA xenmeteo;
USE xenmeteo;

CREATE TABLE estacion (
    id_estacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL UNIQUE,
    ubicacion VARCHAR(65),
    latitud DECIMAL(10,6),
    longitud DECIMAL(10,6),
    fecha_instalacion DATE,
    estado VARCHAR(35)
);

CREATE TABLE sensor (
    id_sensor INT AUTO_INCREMENT PRIMARY KEY,
    id_estacion INT NOT NULL,
    tipo_sensor VARCHAR(45),
    modelo VARCHAR(45),
    unidad_medida VARCHAR(45),
    intervalo_medicion_segundos INT,
    estado VARCHAR(45),
    FOREIGN KEY (id_estacion) 
        REFERENCES estacion(id_estacion)
        ON DELETE CASCADE
);

-- =====================================
-- TABLA LECTURA
-- =====================================
CREATE TABLE lectura (
    id_lectura INT AUTO_INCREMENT PRIMARY KEY,
    id_sensor INT NOT NULL,
    fecha_hora DATETIME,
    valor DECIMAL(10,2),
    FOREIGN KEY (id_sensor) 
        REFERENCES sensor(id_sensor)
        ON DELETE CASCADE
);

-- =====================================
-- TABLA USUARIO
-- =====================================
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(35),
    apellido VARCHAR(35),
    correo VARCHAR(55) UNIQUE,
    password VARCHAR(100)
);

-- =====================================
-- TABLA TIPO_ALERTA
-- =====================================
CREATE TABLE tipo_alerta (
    id_tipo_alerta INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45) UNIQUE,
    descripcion VARCHAR(100),
    operador VARCHAR(20),
    valor_umbral DECIMAL(10,2)
);

-- =====================================
-- TABLA ALERTA
-- =====================================
CREATE TABLE alerta (
    id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    id_lectura INT NOT NULL,
    id_tipo_alerta INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_generada DATETIME,
    estado VARCHAR(20),
    FOREIGN KEY (id_lectura) 
        REFERENCES lectura(id_lectura),
    FOREIGN KEY (id_tipo_alerta) 
        REFERENCES tipo_alerta(id_tipo_alerta),
    FOREIGN KEY (id_usuario) 
        REFERENCES usuario(id_usuario)
);

-- =====================================
-- TABLA INTERMEDIA (Muchos a Muchos)
-- =====================================
CREATE TABLE tipo_alerta_usuario (
    id_tipo_alerta INT,
    id_usuario INT,
    PRIMARY KEY (id_tipo_alerta, id_usuario),
    FOREIGN KEY (id_tipo_alerta) 
        REFERENCES tipo_alerta(id_tipo_alerta),
    FOREIGN KEY (id_usuario) 
        REFERENCES usuario(id_usuario)
);

-- =====================================
-- INSERTAR DATOS
-- =====================================

-- 1️⃣ Estaciones
INSERT INTO estacion 
(nombre, ubicacion, latitud, longitud, fecha_instalacion, estado)
VALUES
('GIR-SERE', 'Girardota', 6.3778, -75.4483, '2023-03-15', 'Activa'),
('MED-SGWI', 'Medellín', 6.2442, -75.5812, '2023-06-10', 'Activa'),
('MED-SVOR', 'Medellín', 6.2000, -75.5700, '2024-01-20', 'Mantenimiento');

-- 2️⃣ Sensores
INSERT INTO sensor 
(id_estacion, tipo_sensor, modelo, unidad_medida, intervalo_medicion_segundos, estado)
VALUES
(1, 'Temperatura', 'TX100', '°C', 60, 'Activo'),
(1, 'Humedad', 'HX200', '%', 120, 'Activo'),
(2, 'Presion', 'PX300', 'hPa', 180, 'Activo'),
(3, 'Viento', 'VX400', 'km/h', 90, 'Mantenimiento');

-- 3️⃣ Lecturas
INSERT INTO lectura 
(id_sensor, fecha_hora, valor)
VALUES
(1, '2025-02-20 10:00:00', 22.5),
(1, '2025-02-20 11:00:00', 23.1),
(2, '2025-02-20 10:00:00', 65.3),
(3, '2025-02-20 10:00:00', 1012.8),
(4, '2025-02-20 10:00:00', 15.6);

-- 4️⃣ Usuarios
INSERT INTO usuario 
(nombre, apellido, correo, password)
VALUES
('Alejandro', 'Lopez', 'alejandro@email.com', '123456'),
('Maria', 'Gomez', 'maria@email.com', '123456'),
('Carlos', 'Ramirez', 'carlos@email.com', '123456');

-- 5️⃣ Tipos de alerta
INSERT INTO tipo_alerta
(nombre, descripcion, operador, valor_umbral)
VALUES
('Alta Temperatura', 'Temperatura superior al limite', '>', 30),
('Baja Temperatura', 'Temperatura inferior al limite', '<', 5),
('Alta Humedad', 'Humedad superior al limite', '>', 80);

-- 6️⃣ Alertas
INSERT INTO alerta
(id_lectura, id_tipo_alerta, id_usuario, fecha_generada, estado)
VALUES
(1, 1, 1, NOW(), 'Activa'),
(3, 3, 2, NOW(), 'Revisada');

-- 7️⃣ Relación tipo_alerta - usuario
INSERT INTO tipo_alerta_usuario
(id_tipo_alerta, id_usuario)
VALUES
(1,1),
(1,2),
(2,1),
(3,3);

-- =====================================
-- VERIFICAR
-- =====================================
SHOW TABLES;
SELECT * FROM estacion;
SELECT * FROM sensor;
SELECT * FROM lectura;
SELECT * FROM usuario;
SELECT * FROM tipo_alerta;
SELECT * FROM alerta;
SELECT * FROM tipo_alerta_usuario;
USE xenmeteo;

SHOW DATABASES;
USE xenmeteo;
SHOW TABLES;
SELECT VERSION();
SELECT @@hostname, @@port;
DROP SCHEMA IF EXISTS xenmeteo;
CREATE SCHEMA xenmeteo;
USE xenmeteo;
SHOW TABLES;
SELECT * FROM users;
SELECT * FROM users;