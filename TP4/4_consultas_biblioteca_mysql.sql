-- a) Aquellos ejemplares que jamás hayan sido retirados.

select distinct isbn from ejemplar e
left join prestamo p on p.idinventario=e.idinventario
where p.idinventario  is null;

select distinct isbn from ejemplar e
where not exists (
	select 1 from prestamo p
	where p.idinventario=e.idinventario
);

-- b) Los libros pertenecientes a la categoría Marketing para los que haya habido pedidos insatisfechos.

select p.isbn from pedidoinsatisfecho p
inner join categorialibro cl on cl.isbn=p.isbn 
inner join categoria cat on cat.idcategoria=cl.idcategoria
where cat.categoria='Marketing';

-- c) Los alumnos de Concordia que hayan retirado al menos dos libros durante el año 1999.

start transaction;

insert into usuario (dni, nombre, direccion, sexo, telefono, idlocalidad) 
values (46151103,'Emmanuel Díaz','Perú 707','M','3455465213',3200);

insert into alumno (dni,legajo,fingreso) 
values (46151103,9999,'1980-01-01');

insert into prestamo (fechaprestamo,idinventario,fechalimite,dni) values 
  ('1999-03-20',1006,'1999-04-01',46151103),
  ('1999-06-20',1007,'1999-07-01',46151103);

select 
  a.dni,
  u.nombre,
  count(p.dni) as cantidad
from alumno a
inner join usuario u on u.dni=a.dni
inner join localidad l on u.idlocalidad=l.idlocalidad
inner join prestamo p on p.dni=a.dni
where l.localidad='CONCORDIA' and year(p.fechaprestamo)=1999
group by a.dni, u.nombre
having count(p.dni)>=2;

rollback;

-- d) Listar los departamentos de los cuales dependen todos aquellos investigadores que hayan retirado libros editados por 'Sudamericana'.

select distinct departamento from departamento d 
inner join proyecto pr on pr.iddepartamento=d.iddepartamento
inner join participa pa on pa.idproyecto=pr.idproyecto
inner join prestamo p on p.dni=pa.dni 
inner join ejemplar e on e.idinventario=p.idinventario 
inner join libro l on l.isbn=e.isbn
where editorial='Sudamericana';

-- e) El título de aquellos libros que hayan sido retirados tanto por docentes que dictan una determinada materia como por alumnos que cursan la misma.

select distinct l.titulo from libro l
inner join ejemplar e_doc on e_doc.isbn=l.isbn 
inner join prestamo p_doc on p_doc.idinventario=e_doc.idinventario 
inner join dicta d on d.dni=p_doc.dni 
inner join ejemplar e_a on e_a.isbn=l.isbn 
inner join prestamo p_a on p_a.idinventario=e_a.idinventario 
inner join cursa c on c.dni=p_a.dni 
where d.idmateria=c.idmateria;

-- f) El nombre de los usuarios a los que se les ha vencido el plazo para devolver algún libro, y que con posterioridad a la fecha de vencimiento hayan retirado algún otro.



-- g) Los docentes que dictan alguna materia que se dicte en todas las carreras.



-- h) Aquellos libros para los que existe más de un ejemplar, tal que al menos dos de esos ejemplares se hayan encontrado prestados en forma simultánea en un determinado momento. 
-- Para simplificar, considerar solamente aquellos préstamos en los que el libro ya haya sido devuelto.


