-- start D:SQL\KUETBANK(database_project)\commandoutput.sql

--Aggregate function

--count
select count(*) from branch;
select count(address) as location from customer;
select count(distinct address) as distinct_location from customer;
--avg
select avg(salary) from employee;
--sum
select sum(salary) from employee;
--max
select max(salary) from employee;
--min
select min(salary) from employee;

--groupby and having

select account_type,avg(balance) from account group by account_type;
select account_type,avg(balance) from account group by account_type having avg(balance)>3500;

--nested subquery

select first_name,last_name from customer where 
customer_id=(select customer_id from account where 
account_no=(select to_acc_no from transaction where 
from_acc_no=105));

--set membership(and,or,not)

--and
select * from account where interest_rate>5 and account_no in (select account_no from customer where address='Khagrachari');
--or
select * from account where interest_rate>5 or account_no in (select account_no from customer where address='Khagrachari');
--not
select * from account where interest_rate>5 and account_no in (select account_no from customer where address not like 'B%');

--some/all/exists/unique

--some
select * from account where balance> some(select balance from account where balance>=2000);
--all
select * from account where balance> all(select balance from account where balance<2000);
--exists
select * from account where balance>4000 and exists(select * from customer where first_name like 'D%');
--unique
select unique last_name from customer;

--string operation

select * from customer where address like '%chari';
select * from customer where address like '_____mati';
select * from customer where address like 'Bandar___';
select * from customer where address like '_____mati' or address like 'B%';
select * from customer where last_name like 'T%' and address like '%i';

--join operation

--natural join
select * from employee natural join branch;
--join using
select first_name,balance from customer join account using(customer_id);
--join on
select account_no,to_acc_no,amount from account join transaction on account.account_no=transaction.from_acc_no;
--left outer join
select * from customer left outer join account using(customer_id);
--right outer join
select * from customer right outer join account using(customer_id);
--full outer join
select * from customer full outer join account using(customer_id);

--view

--view from table
drop view customer_view;
drop view customer_view_view;
create view customer_view as select first_name,address from customer;
select * from customer_view;
--view from view
create view customer_view_view as select * from customer_view where address='Khagrachari';
select * from customer_view_view;


--cascading actions in referential integrity

drop table account2;
drop table customer2;

create table customer2(
customer_id number(20),
first_name varchar(20),
last_name varchar(20),
address varchar(20),
phone_no varchar(11),
primary key(customer_id)
);
create table account2(
account_no number(20),
customer_id number(20),
account_type varchar(20),
balance number(10,2),
interest_rate number(4,2),
primary key(account_no),
foreign key(customer_id) references customer2(customer_id)
on delete cascade
--on delete set null
--on delete set default
--on deletee no action
);
insert into customer2 values(1,'Doniel','Tripura','Khagrachari','01893097217');
insert into customer2 values(2,'Souymo','Chakma','Khagrachari','01521535035');
insert into customer2 values(3,'Usha','Roaza','Rangamati','01823456789');
insert into customer2 values(4,'Aditi','Chakma','Khagrachari','01521535036');
insert into customer2 values(5,'Prasanta','Dewan','Khagrachari','01893097215');
insert into customer2 values(6,'Boishakhi','Tripura','Bandarban','01521535076');

insert into account2 values(101,1,'Savings',1000.00,4.00);
insert into account2 values(102,2,'Checking',2000.00,5.00);
insert into account2 values(103,3,'Savings',3000.00,6.00);
insert into account2 values(104,4,'Checking',4000.00,7.00);
insert into account2 values(105,5,'Savings',5000.00,8.00);
insert into account2 values(106,6,'Checking',6000.00,9.00);

select * from customer2;
select * from account2;

delete from customer2 where customer_id=1;

select * from customer2;
select * from account2;

--constraints on a single relation
drop table branch2;
drop table branch3;

create table branch2(
branch_id integer primary key,
branch_name varchar(20) not null,
email varchar(20) unique not null,
age integer check(age>=18)
);
create table branch3(
branch_id integer primary key,
branch_name varchar(20) not null,
email varchar(20) unique not null,
age integer check(age>=18 and age<=120),
status varchar(20) check (status in('active','inactive','pending')),
start_date date not null,
end_date date not null,
constraint check_age_status check(
(status = 'active' AND age >= 18 AND age <= 65) OR
        (status = 'inactive' AND age >= 18 AND age <= 120) OR
        (status = 'pending' AND age >= 18 AND age <= 100) OR
        (end_date > start_date)
    )
);

describe branch2;
describe branch3;