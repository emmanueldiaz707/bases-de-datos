-- a) ¿Qué modelos de PC tienen una velocidad de al menos 2.8?
SELECT model
FROM pc
WHERE speed >= 2.8;

-- b) ¿Qué fabricantes hacen laptops con un disco duro de al menos 120 gigabyte?
select distinct p.maker as fabricante
from 
  laptop l
  inner join product p on l.model=p.model
where l.hd>=120;

-- c) Hallar el número de modelo y el precio de todos los productos 
-- (de cualquier tipo) hechos por el fabricante B.
select l.model as modelo, price as precio
from laptop l
inner join product p on l.model=p.model
where p.maker='B'
union
select pc.model as modelo, price as precio
from pc
inner join product p on pc.model=p.model
where p.maker='B'
union
select i.model as modelo, price as precio
from printer i
inner join product p on i.model=p.model
where p.maker='B';

-- d) Hallar el número de modelo de todas las impresoras color.
select model as modelo from printer where color=1;

-- e) Hallar los fabricantes que venden laptops pero no PCs.
select distinct p1.maker as fabricante
from product p1
where p1.type='laptop'
  and not exists (
    select * from product p2
    where p1.maker=p2.maker and p2.type='pc'
  );

-- f) Hallar aquellos tamaños de discos que ocurren en dos o más PCs.
select hd as 'tamaño de disco'
from pc
group by hd
having count(*)>=2;

-- g) Hallar pares de modelos de PC tales que ambos posean el mismo tamaño de disco y RAM. 
-- Un par debe ser listado una sola vez: (i,j) pero no (j,i)
select 
  pc1.model as modelo_i,
  pc2.model as modelo_j
from pc pc1
inner join pc pc2 on
  pc1.model<pc2.model
  and pc1.hd = pc2.hd 
  and pc1.ram = pc2.ram;

-- h) Hallar aquellos fabricantes que ofrezcan computadoras (sean PC o laptop) con velocidades de al menos 1.8.
select distinct p.maker
from product p 
inner join (
  select model, speed from laptop
  union
  select model, speed from pc
  ) c
  on p.model=c.model and c.speed>=1.8;

-- Otra forma:
select distinct p.maker
from product p 
inner join (
  select model from laptop where speed>=1.8
  union
  select model from pc where speed>=1.8
  ) c
  on p.model=c.model;

-- Otra más
select distinct p.maker from product p
inner join laptop l on p.model=l.model and l.speed>=1.8
union
select distinct p.maker from product p
inner join pc on p.model=pc.model and pc.speed>=1.8;

-- Y otra más
select distinct p.maker from product p
where exists (
    select * from laptop l
    where p.model=l.model and l.speed>=1.8)
  or exists (
    select * from pc
    where p.model=pc.model and pc.speed>=1.8);


-- i) Hallar los fabricantes de la computadora (PC o laptop) con la máxima velocidad disponible
select distinct pr.maker,speed from ( 
  select model, speed from laptop 
  union  
  select model, speed from pc) c1
inner join product pr on pr.model=c1.model
where c1.speed = ( 
  select max(c2.speed) from (
    select speed from laptop
    union 
    select speed from pc) c2);
