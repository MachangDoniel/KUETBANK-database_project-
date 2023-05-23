-- start D:SQL\KUETBANK(database_project)\dml.sql;

--table creation

insert into customer values(1,'Doniel','Tripura','Khagrachari','01893097217');
insert into customer values(2,'Souymo','Chakma','Khagrachari','01521535035');
insert into customer values(3,'Usha','Roaza','Rangamati','01823456789');
insert into customer values(4,'Aditi','Chakma','Khagrachari','01521535036');
insert into customer values(5,'Prasanta','Dewan','Khagrachari','01893097215');
insert into customer values(6,'Boishakhi','Tripura','Bandarban','01521535076');

insert into account values(101,1,'Savings',1000.00,4.00);
insert into account values(102,2,'Checking',2000.00,5.00);
insert into account values(103,3,'Savings',3000.00,6.00);
insert into account values(104,4,'Checking',4000.00,7.00);
insert into account values(105,5,'Savings',5000.00,8.00);
insert into account values(106,6,'Checking',6000.00,9.00);

insert into transaction values(1001,'debit',10.00,101,102);
insert into transaction values(1002,'credit',20.00,102,101);
insert into transaction values(1003,'debit',30.00,101,103);
insert into transaction values(1004,'credit',40.00,102,104);
insert into transaction values(1005,'debit',50.00,101,105);
insert into transaction values(1006,'credit',60.00,105,106);

insert into branch values(10001,'kuet1','telighati','01234567890');
insert into branch values(10002,'kuet2','boira','01234567891');
insert into branch values(10003,'kuet3','fulbari','01234567892');
insert into branch values(10004,'kuet4','daulotpur','01234567893');
insert into branch values(10005,'kuet5','fultola','01234567894');
insert into branch values(10006,'kuet6','newmarket','01234567859');

insert into employee values(10,'Sheikh','Nibir','Manager',10000.00,10001);
insert into employee values(11,'Wasif','Zahin','Banker',20000.00,10002);
insert into employee values(12,'Sheikh','Sadia','Manager',10000.00,10003);
insert into employee values(13,'Karim','Talha','Banker',20000.00,10004);
insert into employee values(14,'Lal','Mahmud','Manager',10000.00,10005);
insert into employee values(15,'Mainul','Islam','Banker',20000.00,10006);

--show table

select * from customer;
select * from account;
select * from transaction;
select * from branch;
select * from employee;