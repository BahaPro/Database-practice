create table Warehouses
(
    code     int primary key,
    location varchar,
    capacity int
);

create table Boxes
(
    code       char(4) primary key,
    contents   varchar,
    value      real,
    warehouses int,
    foreign key (warehouses)  references Warehouses

);

select * from Warehouses;

select * from Boxes where value > 150;

select distinct on (contents) * from boxes;

select warehouses, count(*) from boxes group by warehouses order by warehouses;

select warehouses, count(*) from boxes group by warehouses having count(*) > 2;

insert into warehouses (location, capacity) VALUES ('New York', 3);

insert into boxes (code, contents, value, warehouses)
values ('H5RT', 'Papers', 200, 2);

update boxes
set value = value * 0.75
where value =
      (select distinct on (value) from boxes order by value desc nulls last limit 1 offset 2);

delete from boxes where value < 150;

delete from boxes where warehouses in (select code from warehouses where location = 'New York')
                  returning *;