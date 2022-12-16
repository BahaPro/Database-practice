-- №1
-- a)

create or replace function incrementByOne(number integer) returns integer
as
$$
begin
    return number + 1;
end;
$$
    language plpgsql;

select incrementByOne(5);

-- b) Returns sum of 2 numbers.
create or replace function sum(number1 integer, number2 integer) returns integer
as
$$
begin
    return number1 + number2;
end;
$$
    language plpgsql;

select sum(3, 5);

-- c)
create or replace function divisible(number integer) returns boolean
as
$$
begin
    if number % 2 = 0 then
        return true;
    else if number % 2 != 0 then
            return false;
        end if;
    end if;
    end;
$$
    language plpgsql;

select divisible(53);
select divisible(54);

-- d)

create or replace function validaty(password character varying)
    returns boolean
as
$$
begin
    if length(password) >= 8 and
       password ~* '[0-9]' and
       password ~* '[a-z]' and
       password ~* '[A-Z]'
    then
        return true;
    else
        return false;
    end if;
end;
$$
    language plpgsql;

select validaty('Password123'); -- all
select validaty('Password'); -- number
select validaty('123456d'); --size

-- e)

create or replace function one_e(inout input_check int, out check_with_one int)
as
$$
begin
    check_with_one := input_check + 1;
    raise notice '% + 1 = %', input_check, check_with_one;
end
$$
    language plpgsql;

select one_e(2);

-- №2
-- a)

create or replace function timestamp_function()
    returns trigger
    language plpgsql
as
$$
begin
    raise notice 'timestamp is %', now();
    return new;
end;
$$;

create table test
(
    testvar int
);

create trigger timestamp_worker_trigger
    after insert or delete or update
    on test
    for each row
execute procedure timestamp_function();

insert into test (testvar) values (1);


-- b)

create table table1
(
    id              integer primary key,
    name            varchar,
    date_of_birth   date,
    age             integer,
    salary          integer,
    work_experience integer,
    discount        integer
);

create or replace function count_age()
    returns trigger
    language plpgsql
as
$$
begin
    new.age = date_part('year', age(current_date, new.date_of_birth));
    return new;
end;
$$;


create trigger count_age_trigger
    before insert
    on table1
    for each row
execute procedure count_age();

insert into table1 (id, name, date_of_birth, salary, work_experience, discount)
VALUES (1, 'Adriana', '2000-08-09', 400000, 1, 10);

select * from table1;

-- c)

create table item_table
(
    price float
);

create or replace function add_tax()
    returns trigger
    language plpgsql
as
$$
begin
    new.price := cast((new.price * 1.12) as float);
    return new;
end;
$$;

create trigger add_tax_trigger
    before insert
    on item_table
    for each row
execute procedure add_tax();

insert into item_table ( price)
VALUES (10000);

select * from item_table;

-- d)

create or replace function prevent_delete()
    returns trigger
    language plpgsql
as
$$
begin
    return null;
end;
$$;


create trigger prevent_delete_trigger
    before delete
    on test
    for each row
execute procedure prevent_delete();

delete
from test where testvar = 1;

select * from test;

-- d)

create or replace function one_d_one_e()
    returns trigger
    language plpgsql
as
$$
begin
    perform validaty('passwordhey123');
    perform one_e(1);
    return new;
end
$$;

create trigger one_d_one_e_trigger
    before insert
    on test
    for each row
execute procedure one_d_one_e();



insert into test (testvar) values (1);

-- №3
-- a)

create or replace procedure three_a()
    language plpgsql
as
$$
begin
    update table1
    set salary = salary + (salary * (work_experience / 2 * 0.1)),
    discount = 10 + (work_experience / 5 * 0.1);
end;
$$;

select *
from table1;

call three_a();

-- b)

create or replace procedure three_b()
    language plpgsql
as
$$
begin
    update table1
    set salary = salary * 1.15
    where age >= 40;

    update table1
    set salary   = salary * 1.15,
        discount = 20
    where work_experience > 8;
end;
$$;

select *
from table1;

call three_b();


