CREATE DATABASE tp1_ej1;
USE tp1_ej1;

CREATE TABLE Region (
  id INT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL
);

CREATE TABLE Provincia (
  id INT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  region_id INT,
  FOREIGN KEY (region_id) REFERENCES Region(id)
);

CREATE TABLE Departamento (
  id INT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  provincia_id INT,
  FOREIGN KEY (provincia_id) REFERENCES Provincia(id)
);


CREATE TABLE Ciudad (
  id INT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  departamento_id INT,
  FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

CREATE TABLE Unidad (
  id INT PRIMARY KEY,
  nombre VARCHAR(5) NOT NULL
);

CREATE TABLE VariableClimatica (
  id INT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL
);  

CREATE TABLE Estacion (
  id INT PRIMARY KEY,
  latitud FLOAT NOT NULL,
  longitud FLOAT NOT NULL,
  calle VARCHAR(30),
  nro_calle INT,
  ciudad_id INT NOT NULL,
  FOREIGN KEY (ciudad_id) REFERENCES Ciudad(id)
);

CREATE TABLE Sensor (
  id INT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL, 
  coeficiente_correcion FLOAT NOT NULL,
  unidad_id INT NOT NULL,
  variable_climatica_id INT NOT NULL,
  estacion_id INT NOT NULL,
  FOREIGN KEY (unidad_id) REFERENCES Unidad(id),
  FOREIGN KEY (variable_climatica_id) REFERENCES VariableClimatica(id),
  FOREIGN KEY (estacion_id) REFERENCES Estacion(id)
);

CREATE TABLE Medicion (
  id INT PRIMARY KEY,
  valor FLOAT NOT NULL,
  fecha_hora DATETIME NOT NULL,
  sensor_id INT NOT NULL,
  FOREIGN KEY (sensor_id) REFERENCES Sensor(id)
);
