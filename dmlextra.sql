-- start D:SQL\KUETBANK(database_project)\dmlextra.sql;

--update row in a table

insert into branch values(10007,'kuet7','14 Mile','01234567859');
select * from branch;
update branch set branch_name='cuet1' where branch_id=10007;
select * from branch;
update branch set address='pahartoli' where branch_id=10007;
select * from branch;

--delete row in a table

delete from branch where branch_id=10007;
select * from branch;

--union,intersect and except

select * from customer where address like 'K%' union select * from customer where address like 'R%';
select * from customer where address like '%i' intersect select * from customer where address like 'R%';
select * from customer where address like '%i' except select * from customer where address like 'R%';

--with clause

with max_balance(val) as (select max(balance) from account)
select * from account,max_balance where account.balance=max_balance.val;
