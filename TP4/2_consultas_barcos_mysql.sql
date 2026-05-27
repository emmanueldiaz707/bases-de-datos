use tp4_ej2;
-- a) Los nombres y los países de las clases que llevaban cañones de al menos 16 pulgadas de calibre.
select classa, country from classes where bore>=16;


-- b) Hallar los barcos botados antes de 1921
select sname from ships where launched<1921;

-- c) Hallar los barcos hundidos en la batalla del Atlántico Norte
select ship from outcomes where battle='North Atlantic' and oresult='sunk';


-- d) El tratado de Washington de 1921 prohibió los barcos de más de 35000 toneladas. Listar los barcos que violaron el tratado de Washington.
select s.sname as nombre
from ships s
inner join classes c on s.sclass=c.classa
where c.displacement>35000;

-- e) Listar el nombre, el desplazamiento y el número de cañones de los barcos que participaron de la batalla de Guadalcanal
select 
  o.ship as 'Nombre',
  c.displacement as 'Desplazamiento',
  c.numguns as 'Número de cañones'
from ships s
inner join classes c on s.sclass=c.classa
right join outcomes o on o.ship=s.sname
where o.battle='Guadalcanal';

-- f) Hallar los países que tuvieron tanto cruceros como acorazados

-- Asumiendo bb para acorazado (battleship) y bc para crucero (battlecruiser)...
select country from classes where typess in ('bb','bc');


-- g) Hallar los barcos que, siendo dañados en alguna batalla, participaron posteriormente de alguna otra.
select o1.ship from outcomes o1 
inner join battles b1 on o1.battle=b1.bname
where o1.oresult='damaged' and exists (
	select 1 
	from outcomes o2 
	inner join battles b2 on o2.battle=b2.bname
	where o1.ship = o2.ship and b2.date>b1.date
);





