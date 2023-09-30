
# KUET_BANK
A project on database management system using oracle database.



# Installation
Download this tools.

1. [Oracle Database 21c Express Edition](https://www.oracle.com/database/technologies/xe-downloads.html) and for better GUI, use [Toad](https://pesktop.com/en/windows/toad_for_oracle).
2. Remember the password during the installation because this password is needed to connect the database system account.

![installation](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/f41bf990-2574-4db7-9c91-ed59d1d883e6)

3. Open the SQL Plus. Write "system" as user-name or just write "connect system" and use the password that you set in the installation process.
```bash
connect system
```

![system login](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/a4c80e6e-2008-4a8b-a5a3-e97f4a4fe2be)
4. You can create a new user because we use the system(administrator) as a user. Then, we will give the new user all privileges to perform all SQL tasks.
```bash
    create user machang identified by 1907121;
    grant all privileges to machang;
```

You may face [ORA-65096: invalid common user or role name](https://stackoverflow.com/questions/33330968/error-ora-65096-invalid-common-user-or-role-name-in-oracle-database).
just alter your session.
```bash
alter session set "_ORACLE_SCRIPT"=true;  
```
Now create user again.
![error solve](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/f9d164eb-00ac-43ee-a104-06c01d5fd66d)

## Project Demo
### UML diagram
![uml](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/08e2f42a-d2ea-49b0-ac22-d4e0ccf768d5)

### ER diagram

![ERD](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/ca4a253b-997d-43bf-9095-0d56f4a09d2d)






## Important SQL code
### Disconnect
```bash
disconnect
```
### LineSize & PageSize

```bash
show pagesize
show linesize
```
To change pagesize & linesize
```bash
set pagesize 200
set linesize 200
```

### Check User

```bash
show user
```

### Comment

```bash
--This is oracle single line comment
```

### Oracle DataTypes

Checkout oracle [datatype](https://www.w3resource.com/oracle/oracle-data-types.php)


## How to run
Paste your file location and run it.
```bash
start D:SQL\KUETBANK(database_project)\ddl.sql;
```

## Check all existing table
Commands for checking all the existing table.
```bash
select table_name from user_tables;
```

# DDL(Data Definition Language)
## Drop existing table
Commands for deleting a table "table_name"
```bash
drop table table_name;
```
## Create table
Commands for creating a table.
```bash
create table branch(
branch_id number(20),
branch_name varchar(20),
address varchar(20),
phone_no varchar(11),
primary key(branch_id)
);

```

## Describe table
Commands for describing a table.
```bash
describe branch;
```
Check out that the primary key is branch_id because it uniquely identifies each row in the table.

![image](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/94438ea0-9ac5-4fa3-9819-1d36d7f6ebcd)

### Create more table

```bash
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
create table customer(
customer_id number(20),
first_name varchar(20),
last_name varchar(20),
address varchar(20),
phone_no varchar(11),
branch_id number(20),
primary key(customer_id),
foreign key(branch_id) references branch
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
```
### Describe them.

```bash
describe customer;
describe account;
describe transaction;
describe branch;
describe employee;
```

## Add column in the table
We add a column in the branch table which is location.
```bash
alter table branch add location char(20);
```

## Modify column definition in the table
We modify the location data types char(20) to varchar(23);
```bash
alter table branch modify location varchar(23);
```

## Rename the column name
We modify the location data types char(20) to varchar(23);
```bash
alter table branch rename column location to location2;
```

## Drop the column from table
We modify the location data types char(20) to varchar(23);
```bash
alter table branch drop column location2;
```


# DML(Data Manipulation Language)

## Insert the data in the table
We can insert data in this way.
```bash
insert into branch(branch_id,branch_name,address,phone_no) values(10001,'kuet1','telighati','01234567890');
```
![image](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/0dec5dc3-c9a7-4cbe-94d0-ef6ca184afd7)

Here, "branch" refers to the table name, and we also insert values according to table columns.

## Insert the data in tha table
Data insertion alternative way.

```bash
insert into branch values(10002,'kuet2','boira','01234567891');
```
Here we don't need to mention the column_name.
![image](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/a9737a2a-dae0-43c8-aeef-233787d968ce)

### Add more data
```bash
insert into branch values(10003,'kuet3','fulbari','01234567892');
insert into branch values(10004,'kuet4','daulotpur','01234567893');
insert into branch values(10005,'kuet5','fultola','01234567894');
insert into branch values(10006,'kuet6','newmarket','01234567859');
insert into branch values(10007,'kuet7','fulbari2','01234567895');
insert into branch values(10008,'kuet8','daulotpur2','01234567894');
insert into branch values(10009,'kuet9','fultola2','01234567892');
insert into branch values(10010,'kuet10','newmarket2','01234567851');

insert into employee values(11,'Wasif','Zahin','Banker',20000.00,10001);
insert into employee values(12,'Sheikh','Sadia','Manager',10000.00,10002);
insert into employee values(13,'Karim','Talha','Banker',20000.00,10003);
insert into employee values(14,'Lal','Mahmud','Manager',10000.00,10004);
insert into employee values(15,'Mainul','Islam','Banker',20000.00,10005);
insert into employee values(16,'Md','Fahim','Manager',10000.00,10006);
insert into employee values(17,'Sami','Sazid','Banker',20000.00,10007);
insert into employee values(18,'Kafi','Ahmed','Manager',10000.00,10008);
insert into employee values(19,'Akash','Ahmed','Banker',20000.00,10009);
insert into employee values(20,'Sheikh','Nibir','Manager',10000.00,10010);

insert into customer values(1,'Doniel','Tripura','Khagrachari','01893097217',10001);
insert into customer values(2,'Souymo','Chakma','Khagrachari','01521535035',10002);
insert into customer values(3,'Usha','Roaza','Rangamati','01823456789',10003);
insert into customer values(4,'Aditi','Chakma','Khagrachari','01521535036',10004);
insert into customer values(5,'Prasanta','Dewan','Khagrachari','01893097215',10005);
insert into customer values(6,'Boishakhi','Tripura','Bandarban','01521535076',10006);
insert into customer values(7,'Rimi','Chakma','Khagrachari','01521535039',10007);
insert into customer values(8,'Prasanta','Chakma','Khagrachari','01893097216',10008);
insert into customer values(9,'Boishali','Chakma','Rangamati','01521535073',10009);
insert into customer values(10,'Sejuti','Chakma','Rangamati','01521535031',10010);

insert into account values(101,1,'Savings',1000.00,4.00);
insert into account values(102,2,'Checking',2000.00,5.00);
insert into account values(103,3,'Savings',3000.00,6.00);
insert into account values(104,4,'Checking',4000.00,7.00);
insert into account values(105,5,'Savings',5000.00,8.00);
insert into account values(106,6,'Checking',6000.00,9.00);
insert into account values(107,7,'Savings',3000.00,6.00);
insert into account values(108,8,'Checking',4000.00,7.00);
insert into account values(109,9,'Savings',5000.00,8.00);
insert into account values(110,10,'Checking',6000.00,9.00);

insert into transaction values(1001,'debit',10.00,101,102);
insert into transaction values(1002,'credit',20.00,102,101);
insert into transaction values(1003,'debit',30.00,101,103);
insert into transaction values(1004,'credit',40.00,102,104);
insert into transaction values(1005,'debit',50.00,101,104);
insert into transaction values(1006,'credit',60.00,104,106);
insert into transaction values(1007,'debit',70.00,102,103);
insert into transaction values(1008,'credit',80.00,103,104);
insert into transaction values(1009,'debit',90.00,106,105);
insert into transaction values(1010,'credit',100.00,105,106);
```

## Show table
Commands for showing table

```bash
select * from customer;
select * from account;
select * from transaction;
select * from branch;
select * from employee;
```

![image](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/45667374-5816-4c6f-888f-794a8acbd06e)

![image](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/905b1518-527b-4799-a679-eafe0eed492d)

![image](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/1ab24831-a361-4273-9706-f4fe76fb707a)

![image](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/c1971c92-2f08-4bd6-96fe-7ed0ae33fdcd)

![image](https://github.com/MachangDoniel/KUETBANK-database_project-/assets/114639828/9ecbfe37-39df-4b5b-97cb-0b63ec5cf70a)

## Update row in a table

```bash
insert into branch values(10007,'kuet7','14 Mile','01234567859');
```
```bash
select * from branch;
```
```bash
update branch set branch_name='cuet1' where branch_id=10007;
```
```bash
select * from branch;
```
```bash
update branch set address='pahartoli' where branch_id=10007;
```
```bash
select * from branch;
```
## Delete row in a table

```bash
delete from branch where branch_id=10007;
```
```bash
select * from branch;
```
## Union, Intersect and Except
```bash
select * from customer where address like 'K%' union select * from customer where address like 'R%';
```
```bash
select * from customer where address like '%i' intersect select * from customer where address like 'R%';
```
```bash
select * from customer where address like '%i' except select * from customer where address like 'R%';
```

## With clause
```bash
with max_balance(val) as (select max(balance) from account)
select * from account,max_balance where account.balance=max_balance.val;
```






