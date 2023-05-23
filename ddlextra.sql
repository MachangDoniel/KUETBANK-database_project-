-- start D:SQL\KUETBANK(database_project)\ddlextra.sql;

--add column

alter table branch add location varchar(20);
describe branch;

--modify column

alter table branch modify location varchar(50);
describe branch;

--rename column

alter table branch rename column location to location2;
describe branch;

--drop column

alter table branch drop column location2;
describe branch;
