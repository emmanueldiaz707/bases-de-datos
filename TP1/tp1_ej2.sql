create database tp1_ej2;

use tp1_ej2;

create table Autor (
	id int primary key,
	nombre varchar(50)
);

create table Editorial (
	id int primary key,
	nombre varchar(50),
	telefono varchar(20),
	direccion varchar(100)
);

create table CategoriaLibro (
	id int primary key, 
	nombre varchar(30)
);

create table Libro (
	isbn varchar(13) primary key,
	titulo varchar(50),
	fecha_publicacion date,
	cantidad_paginas int,
	id_editorial int not null,
	foreign key (id_editorial) references Editorial(id)
);

create table LibroAutor (
	libro_isbn varchar(13),
	autor_id int,
	foreign key (libro_isbn) references Libro(isbn),
	foreign key (autor_id) references Autor(id),
	primary key (libro_isbn, autor_id)
);

create table Libro_CategoriaLibro (
	libro_isbn varchar(13),
	categoria_id int,
	foreign key (libro_isbn) references Libro(isbn),
	foreign key (categoria_id) references CategoriaLibro(id),
	primary key (libro_isbn, categoria_id)
);

create table EjemplarLibro (
	id int primary key,
	libro_isbn varchar(13) not null,
	fecha_alta date,
	codigo_inventario int,
	codigo_ubicacion int,
	foreign key (libro_isbn) references Libro(isbn) on delete cascade
);

create table CategoriaUsuario (
	id int primary key,
	nombre varchar(20),
	dias_plazo_devolucion int
);

create table Usuario (
 	id int primary key,
 	nombre varchar(40),
 	direccion varchar(100),
 	telefono varchar(20)
);

create table Pedido (
	id int primary key,
	libro_isbn varchar(13) not null,
	usuario_id int not null,
	fecha date not null,
	satisfecho boolean not null default false,
	foreign key (libro_isbn) references Libro(isbn),
	foreign key (usuario_id) references Usuario(id)
);


create table Prestamo ( 
 	id int primary key,
 	ejemplar_id int not null,
 	usuario_id int not null,
 	fecha date not null,
	fecha_limite_devolucion date not null,
	fecha_devolucion date,
	foreign key (ejemplar_id) references EjemplarLibro(id),
	foreign key (usuario_id) references Usuario(id)
);

create table Usuario_CategoriaUsuario (
  	usuario_id int,
  	categoria_id int,
  	foreign key (usuario_id) references Usuario(id),
  	foreign key (categoria_id) references CategoriaUsuario(id),
  	primary key (usuario_id, categoria_id)
);
 	

create table Materia (
	id int primary key,
	nombre varchar(50)
);

create table Estudiante (
	legajo int primary key,
	fecha_ingreso date,
	usuario_id int not null,
	foreign key (usuario_id) references Usuario(id)
);

create table EstudianteMateria (
	estudiante_legajo int,
	materia_id int, 
	foreign key (estudiante_legajo) references Estudiante(legajo),
	foreign key (materia_id) references Materia(id),
	primary key (estudiante_legajo, materia_id)
);

create table Carrera (
	id int primary key,
	nombre varchar(50)
);

create table Docente (
	legajo int primary key,
	anios_antiguedad int,
	usuario_id int not null,
	foreign key (usuario_id) references Usuario(id)
);

create table DocenteCarrera (
	docente_legajo int,
	carrera_id int,
	foreign key (docente_legajo) references Docente(legajo),
	foreign key (carrera_id) references Carrera(id),
	primary key (docente_legajo, carrera_id)
);

create table CategoriaInvestigador (
	id int primary key,
	nombre varchar(50)
);

create table DepartamentoInvestigacion (
	id int primary key,
	nombre varchar(50)
);

create table ProyectoInvestigacion (
 	id int primary key,
 	nombre varchar(50),
 	departamento_id int not null,
 	foreign key (departamento_id) references DepartamentoInvestigacion(id)
);

create table Investigador ( 
	id int primary key,
	categoria_id int,
	usuario_id int,
	foreign key (categoria_id) references CategoriaInvestigador(id),
	foreign key (usuario_id) references Usuario(id)
);

create table InvestigadorProyecto ( 
 	investigador_id int,
 	proyecto_id int,
 	foreign key (investigador_id) references Investigador(id),
 	foreign key (proyecto_id) references ProyectoInvestigacion(id),
 	primary key (investigador_id, proyecto_id)
);
