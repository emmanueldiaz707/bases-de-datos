CREATE DATABASE parcial1_B_Diaz;
USE parcial1_B_Diaz;

CREATE TABLE Ciudad (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);

CREATE TABLE Sucursal (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    ciudad_id INT NOT NULL,
    FOREIGN KEY (ciudad_id) REFERENCES Ciudad(id)
);

CREATE TABLE Actividad (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);

CREATE TABLE Sala (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    capacidad INT NOT NULL CHECK (capacidad>0),
    actividad_id INT NOT NULL,
    sucursal_id INT NOT NULL,
    FOREIGN KEY (actividad_id) REFERENCES Actividad(id),
    FOREIGN KEY (sucursal_id) REFERENCES Sucursal(id) ON DELETE CASCADE
);

CREATE TABLE Clase (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    duracion_minutos INT NOT NULL,
    actividad_id INT NOT NULL,
    FOREIGN KEY (actividad_id) REFERENCES Actividad(id)
);

CREATE TABLE TipoMembresia (
    id INT PRIMARY KEY,
    tipo VARCHAR(30) NOT NULL UNIQUE,
    precio_actual DECIMAL(10,2) NOT NULL
);

CREATE TABLE Cliente (
    id INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    telefono VARCHAR(15)
);

CREATE TABLE Membresia (
    id INT PRIMARY KEY,
    precio DECIMAL(10,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    tipo_id INT NOT NULL,
    cliente_id INT NOT NULL,
    FOREIGN KEY (tipo_id) REFERENCES TipoMembresia(id),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    CHECK ((fecha_fin IS NULL) OR (fecha_fin>fecha_inicio))
);

CREATE TABLE EspecialidadEntrenador (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE Entrenador (
    id INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    especialidad_id INT NOT NULL,
    sucursal_id INT NOT NULL,
    FOREIGN KEY (especialidad_id) REFERENCES EspecialidadEntrenador(id),
    FOREIGN KEY (sucursal_id) REFERENCES Sucursal(id)
);

CREATE TABLE DiaSemana (
    id INT PRIMARY KEY,
    nombre VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE SesionClase (
    id INT PRIMARY KEY,
    horario_inicio TIME NOT NULL,
    clase_id INT NOT NULL,
    dia_semana_id INT NOT NULL,
    sala_id INT NOT NULL,
    entrenador_id INT NOT NULL,
    FOREIGN KEY (clase_id) REFERENCES Clase(id),
    FOREIGN KEY (dia_semana_id) REFERENCES DiaSemana(id),
    FOREIGN KEY (sala_id) REFERENCES Sala(id),
    FOREIGN KEY (entrenador_id) REFERENCES Entrenador(id)
);

CREATE TABLE InscripcionClase (
    id INT PRIMARY KEY,
    sesion_clase_id INT NOT NULL,
    cliente_id INT NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    fecha_baja DATE,
    FOREIGN KEY (sesion_clase_id) REFERENCES SesionClase(id),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    CHECK ((fecha_baja IS NULL) OR (fecha_baja>fecha_inscripcion))
);

CREATE TABLE AsistenciaClase (
    id INT PRIMARY KEY,
    fecha DATE NOT NULL,
    presente BOOLEAN DEFAULT FALSE,
    inscripcion_id INT NOT NULL,
    FOREIGN KEY (inscripcion_id) REFERENCES InscripcionClase(id)
);