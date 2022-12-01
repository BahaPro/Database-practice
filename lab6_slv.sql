-- 1 a)
select * from dealer cross join client;


-- b)
select d.name, c.name, c.city, c.priority, 
       (select count(*) from sell s where s.client_id = c.id and s.dealer_id = d.id), 
       s.id, s.date, s.amount from dealer d
         join client c on d.id = c.dealer_id
         join sell s on d.id = s.dealer_id and c.id = s.client_id; 

--c)
select *
from dealer d
         join client c on c.city = d.location; 

--d)
select s.id, s.amount, c.name, c.city
from sell s, client c
where s.client_id = c.id
and s.amount between 100 AND 500; 

--e)
select *
from dealer d full join client c on d.id = c.dealer_id; 

--f)
select c.name, c.city, d.name, d.charge
from dealer d join client c on d.id = c.dealer_id; 
--g)
select c.name, c.city, d.*, d.charge
from client c join dealer d on c.dealer_id = d.id
where d.charge > .12; 

--h)

select c.name, c.city, s.id, s.amount, d.name, d.charge
from client c
         left join dealer d on c.dealer_id = d.id
         left join sell s on s.dealer_id = d.id
                                 and s.client_id = c.id; 

-- i)

select c.name, c.priority, d.name, s.id, s.amount
from dealer d join client c on c.dealer_id = d.id
         left join sell s on d.id = s.dealer_id and c.id = s.client_id
where s.amount > 2000  and c.priority is not null;  

-- 2 a)

create or replace view exercise2a as
select count(distinct s.client_id), avg(amount), sum(amount), s.date from sell s group by s.date;

select * from exercise2a; 

-- b) f

create or replace view exercise2b as select count(distinct s.client_id), sum(amount), s.date
from sell s group by s.date order by sum(amount) desc limit 5; -- лимит чтобы вывело первые 5 order by чтобы соритровать

select * from exercise2b;

-- c)
create or replace view exercise2с as select count(s.dealer_id), avg(s.amount), sum(s.amount), s.dealer_id
from sell s group by dealer_id;

select * from exercise2с;

-- d)
create or replace view exercise2d as
select d.location, sum(s.amount * d.charge) from dealer d join sell s
on d.id = s.dealer_id group by d.location;

select * from exercise2d;

-- e)
create or replace view exercise2e as
select count(*), avg(s.amount), sum(s.amount)
from dealer d join sell s on d.id = s.dealer_id group by d.location; 

select * from exercise2e;

-- f)
create or replace view exercise2f as
select  count(*), avg(s.amount), sum(s.amount)
from client c join sell s on s.client_id = c.id group by c.city;

select * from exercise2f;


