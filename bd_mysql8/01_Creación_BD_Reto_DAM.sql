----------------------------------------------------------------------------------------------------
-- Proyecto: Reto segundo DAM: Sistema de Gestión de Vacantes de Empleo y Solicitudes de Usuarios --
-- Grupo: 11																					  --
-- Script: 01_Creación_BD_Reto_DAM.sql														      --
-- Creacion de la BD, tablas, campos y datos de prueba                                            --
----------------------------------------------------------------------------------------------------

-- Creación de la BD
CREATE DATABASE reto_dam;
USE reto_dam;

-- Tabla de categorias
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(2000)
);

-- Tabla de empresas
CREATE TABLE empresas (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(45),
    direccion_fiscal VARCHAR(45),
    pais VARCHAR(45)
);

-- Tabla de perfiles
CREATE TABLE perfiles (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Tabla de usuarios
CREATE TABLE usuarios (
    username VARCHAR(45) PRIMARY KEY,
    nombre VARCHAR(45),
	apellidos VARCHAR(100),
	email VARCHAR(100),
	password VARCHAR(100),
	enabled INT,
	fecha_registro DATE
);

-- Tabla intermedia usuarios-perfil
CREATE TABLE usuario_perfil (
	username VARCHAR(45),
	id_perfil INT,
	CONSTRAINT fk_usuario_perfil_usuarios FOREIGN KEY (username) REFERENCES usuarios(username) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_usuario_perfil_perfiles FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla de vacantes
CREATE TABLE vacantes (
    id_vacante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200),
	descripcion TEXT,
	fecha DATE,
	salario DOUBLE,
	estatus ENUM('CREADA','CANCELADA','ASIGNADA','ADJUDICADA'),
	destacado TINYINT,
	imagen VARCHAR(250),
	detalles TEXT,
	id_categoria INT,
	id_empresa INT,
	CONSTRAINT fk_vacantes_categorias FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_vacantes_empresas FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla de solicitudes
CREATE TABLE solicitudes (
    id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
	archivo VARCHAR(250),
	comentarios VARCHAR(2000),
	estado TINYINT,
	id_vacante INT,
	username VARCHAR(45),
	CONSTRAINT fk_solicitudes_vacantes FOREIGN KEY (id_vacante) REFERENCES vacantes(id_vacante) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_solicitudes_usuarios FOREIGN KEY (username) REFERENCES usuarios(username) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insertando datos en la tabla de empresas
INSERT INTO empresas (razon_social, direccion_fiscal, pais) VALUES
('Tech Solutions', 'Calle 123, Madrid', 'España'),
('Innovatech', 'Avenida 456, Ecatepec de Morelos', 'México'),
('Global IT', 'Calle 789, Rosario', 'Argentina'),
('SoftDev Corp', 'Carrera 321, Medellín', 'Colombia'),
('NextGen Systems', 'Glorieta 654, Valparaíso', 'Chile');

-- Insertando datos en la tabla de categorias
INSERT INTO categorias (nombre, descripcion) VALUES
('Desarrollo Web', 'Ofertas relacionadas con desarrollo y programación web.'),
('Ciberseguridad', 'Ofertas para especialistas en seguridad informática.'),
('Análisis de Datos', 'Vacantes para expertos en análisis y ciencia de datos.'),
('Administración de Sistemas', 'Puestos para administradores de sistemas y redes.'),
('Soporte Técnico', 'Vacantes para soporte y atención a usuarios.');

-- Insertando datos en la tabla de perfiles
INSERT INTO perfiles (nombre) VALUES
('Empresa'),
('Administrador'),
('Usuario');

-- Insertando datos en la tabla de vacantes
INSERT INTO vacantes (nombre, descripcion, fecha, salario, estatus, destacado, imagen, detalles, id_categoria, id_empresa) VALUES
('Desarrollador Full Stack', 'Se busca desarrollador con experiencia en MERN Stack.', '2025-03-01', 35000, 'CREADA', 1, 'img1.jpg', 'Trabajo remoto con flexibilidad horaria.', 1, 1),
('Analista de Seguridad', 'Experto en pentesting y auditorías de seguridad.', '2025-02-15', 40000, 'ASIGNADA', 0, 'img2.jpg', 'Se requiere certificación OSCP.', 2, 2),
('Científico de Datos', 'Experiencia en Machine Learning y Big Data.', '2025-01-10', 45000, 'CREADA', 1, 'img3.jpg', 'Trabajo presencial en Ciudad B.', 3, 3),
('Administrador de Sistemas', 'Experiencia en Linux y redes.', '2025-03-05', 38000, 'ADJUDICADA', 0, 'img4.jpg', 'Contrato indefinido con beneficios.', 4, 4),
('Soporte Técnico Nivel 2', 'Atención a clientes y resolución de incidencias.', '2025-02-20', 25000, 'CREADA', 1, 'img5.jpg', 'Turno rotativo, trabajo híbrido.', 5, 5);

-- Insertando datos en la tabla de usuarios
INSERT INTO usuarios (username, nombre, apellidos, email, password, enabled, fecha_registro) VALUES
('mgarcia', 'Miguel', 'García García', 'mgarcia@gmail.com', 'contraseña1', 1, '2025-03-07'),
('mdesantos', 'María', 'De Santos Ruiz', 'mdesantos@gmail.com', 'contraseña2', 1, '2025-05-10'),
('rlopez', 'Raúl', 'Peralta Jiménez', 'rlopeza@gmail.com', 'contraseña3', 1, '2025-08-15'),
('csanchez', 'Cristina', 'Sánchez Rodríguez', 'csanchez@gmail.com', 'contraseña4', 1, '2025-01-05'),
('fpavon', 'Fernando', 'Pavon López', 'fpavon@gmail.com', 'contraseña5', 1, '2025-09-30');

-- Insertando datos en la tabla de usuario_perfil
INSERT INTO usuario_perfil (username, id_perfil) VALUES
('mgarcia', 3),
('mdesantos', 3),
('rlopez', 3),
('csanchez', 2),
('fpavon', 1);

-- Insertando datos en la tabla de solicitudes
INSERT INTO solicitudes (fecha, archivo, comentarios, estado, id_vacante, username) VALUES
('2025-03-15', 'cv_mgarcia', 'Me interesa la vacante.', 1, 1, 'mgarcia'),
('2025-03-16', 'cv_mdesantos', 'Cuento con experiencia relevante.', 1, 2, 'mdesantos'),
('2025-03-17', 'cv_rlopez', 'Disposición inmediata.', 1, 3, 'rlopez'),
('2025-03-18', 'cv_csanchez', 'Experiencia en sector financiero.', 1, 4, 'csanchez'),
('2025-03-19', 'cv_fpavon', 'Interesado en trabajo remoto.', 1, 5, 'fpavon');

COMMIT;
