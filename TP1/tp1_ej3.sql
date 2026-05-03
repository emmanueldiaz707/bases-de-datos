DROP DATABASE IF EXISTS tp1_ej3;
CREATE DATABASE tp1_ej3;
USE tp1_ej3;

CREATE TABLE TipoSocio (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    valor_cuota DECIMAL(10,2) NOT NULL
);

CREATE TABLE Socio (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    telefono VARCHAR(15), -- un niño (adherido) puede no tener telefono, se usaría el del titular
    domicilio_calle VARCHAR(50),
    domicilio_nro_calle INT,
    socio_titular INT,
    tipo_socio INT NOT NULL,
    FOREIGN KEY (socio_titular) REFERENCES Socio(id),
    FOREIGN KEY (tipo_socio) REFERENCES TipoSocio(id),
    CHECK (id <> socio_titular)
);

CREATE TABLE Profesor (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL
);

CREATE TABLE Deporte (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    precio_mes DECIMAL(10,2) NOT NULL,
    profesor_id INT NOT NULL,
    FOREIGN KEY (profesor_id) REFERENCES Profesor(id)
);

CREATE TABLE InscripcionDeporte (
    id INT PRIMARY KEY,
    socio_id INT NOT NULL,
    deporte_id INT NOT NULL, 
    fecha_inscripcion DATE NOT NULL,
    fecha_baja DATE,
    FOREIGN KEY (socio_id) REFERENCES Socio(id),
    FOREIGN KEY (deporte_id) REFERENCES Deporte(id),
    CHECK ((fecha_baja IS NULL) OR (fecha_baja>=fecha_inscripcion))
);

CREATE TABLE Instalacion (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    precio_hora DECIMAL(10,2) NOT NULL
);

CREATE TABLE Evento (
    id INT PRIMARY KEY,
    fecha_hora DATETIME NOT NULL,
    importe DECIMAL(10,2) NOT NULL,
    instalacion_id INT NOT NULL,
    socio_id INT NOT NULL,
    FOREIGN KEY (instalacion_id) REFERENCES Instalacion(id),
    FOREIGN KEY (socio_id) REFERENCES Socio(id)
);

CREATE TABLE Factura (
    id INT PRIMARY KEY,
    fecha DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    socio_id INT NOT NULL,
    tipo_socio_id INT NOT NULL,
    FOREIGN KEY (socio_id) REFERENCES Socio(id),
    FOREIGN KEY (tipo_socio_id) REFERENCES TipoSocio(id)
);

CREATE TABLE LineaFactura (
    id INT PRIMARY KEY,
    importe DECIMAL(10,2) NOT NULL,
    factura_id INT NOT NULL,
    inscripcion_id INT,
    evento_id INT,
    FOREIGN KEY (factura_id) REFERENCES Factura(id) ON DELETE CASCADE,
    FOREIGN KEY (inscripcion_id) REFERENCES InscripcionDeporte(id),
    FOREIGN KEY (evento_id) REFERENCES Evento(id),
    -- CHECK (inscripcion_id IS NOT NULL OR evento_id IS NOT NULL) AND (inscripcion_id IS NULL OR evento_id IS NULL)
    CHECK ((inscripcion_id IS NULL) <> (evento_id IS NULL)) -- línea es por deporte o bien por evento
);

