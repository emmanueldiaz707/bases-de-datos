DROP DATABASE IF EXISTS tp1_ej4;
CREATE DATABASE tp1_ej4;
USE tp1_ej4;

CREATE TABLE GrupoSanguineo (
    id INT PRIMARY KEY,
    tipo VARCHAR(3) UNIQUE NOT NULL
);

CREATE TABLE Persona (
    id INT PRIMARY KEY,
    dni INT NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    domicilio VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    grupo_sanguineo INT NOT NULL,
    FOREIGN KEY (grupo_sanguineo) REFERENCES GrupoSanguineo(id)
);

CREATE TABLE CategoriaRegistro (
    id INT PRIMARY KEY,
    nombre VARCHAR(5) UNIQUE NOT NULL
);

CREATE TABLE TipoVehiculo (
    id INT PRIMARY KEY,
    nombre VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE CategoriaRegistro_TipoVehiculo (
    categoria_registro_id INT NOT NULL,
    tipo_vehiculo_id INT NOT NULL,
    PRIMARY KEY (categoria_registro_id, tipo_vehiculo_id),
    FOREIGN KEY (categoria_registro_id) REFERENCES CategoriaRegistro(id),
    FOREIGN KEY (tipo_vehiculo_id) REFERENCES TipoVehiculo(id)
);

CREATE TABLE Vehiculo (
    id INT PRIMARY KEY,
    patente VARCHAR(7) UNIQUE NOT NULL,
    anio_fabricacion INT NOT NULL,
    tipo_id INT NOT NULL,
    FOREIGN KEY (tipo_id) REFERENCES TipoVehiculo(id)
);

CREATE TABLE Propietario (
    id INT PRIMARY KEY,
    persona_id INT NOT NULL,
    vehiculo_id INT NOT NULL,
    fecha_desde DATE NOT NULL,
    fecha_hasta DATE,
    FOREIGN KEY (persona_id) REFERENCES Persona(id),
    FOREIGN KEY (vehiculo_id) REFERENCES Vehiculo(id),
    CHECK ((fecha_hasta IS NULL) OR (fecha_hasta>=fecha_desde))
);

CREATE TABLE RegistroConducir(
    id INT PRIMARY KEY,
    persona_id INT NOT NULL,
    domicilio VARCHAR(100) NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    FOREIGN KEY (persona_id) REFERENCES Persona(id),
    CHECK (fecha_vencimiento>fecha_emision)
);

CREATE TABLE Registro_CategoriaRegistro (
    registro_id INT NOT NULL,
    categoria_registro_id INT NOT NULL,
    PRIMARY KEY (registro_id,categoria_registro_id),
    FOREIGN KEY (registro_id) REFERENCES RegistroConducir(id),
    FOREIGN KEY (categoria_registro_id) REFERENCES CategoriaRegistro(id)
);

CREATE TABLE TipoInfraccion (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE Infraccion (
    id INT PRIMARY KEY,
    fecha_hora DATETIME NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    pagada BOOLEAN NOT NULL DEFAULT FALSE,
    domicilio_infractor VARCHAR(100) NOT NULL,
    observaciones VARCHAR(200),
    tipo_id INT NOT NULL,
    registro_id INT NOT NULL,
    persona_id INT NOT NULL,
    vehiculo_id INT NOT NULL,
    FOREIGN KEY (tipo_id) REFERENCES TipoInfraccion(id),
    FOREIGN KEY (registro_id) REFERENCES RegistroConducir(id),
    FOREIGN KEY (persona_id) REFERENCES Persona(id),
    FOREIGN KEY (vehiculo_id) REFERENCES Vehiculo(id)
);