-- start D:SQL\KUETBANK(database_project)\ddl.sql;

--set

set pagesize 200;
set linesize 200;

--drop initial tables

drop table transaction;
drop table account;
drop table customer;
drop table employee;
drop table branch;

--table creation

create table customer(
customer_id number(20),
first_name varchar(20),
last_name varchar(20),
address varchar(20),
phone_no varchar(11),
primary key(customer_id)
);
create table account(
account_no number(20),
customer_id number(20),
account_type varchar(20),
balance number(10,2),
interest_rate number(4,2),
primary key(account_no),
foreign key(customer_id) references customer
);
create table transaction(
transaction_id number(20),
transaction_type varchar(20),
amount number(10,2),
from_acc_no number(20),
to_acc_no number(20),
primary key(transaction_id),
foreign key(from_acc_no) references account(account_no),
foreign key(to_acc_no) references account(account_no)
);
create table branch(
branch_id number(20),
branch_name varchar(20),
address varchar(20),
phone_no varchar(11),
primary key(branch_id)
);
create table employee(
employee_id number(20),
first_name varchar(20),
last_name varchar(20),
position varchar(20),
salary number(10,2),
branch_id number(20),
primary key(employee_id),
foreign key(branch_id) references branch
);

--describe table

describe customer;
describe account;
describe transaction;
describe branch;
describe employee;
