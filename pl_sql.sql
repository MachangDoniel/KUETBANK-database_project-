-- start D:SQL\KUETBANK(database_project)\pl_sql.sql;

--PL/SQL variable declaration and print value
set serverout on
declare
name CUSTOMER.FIRST_NAME%type;
address CUSTOMER.ADDRESS%type;
phone CUSTOMER.PHONE_NO%type;

begin
select first_name,address,phone_no into name,address,phone from customer where customer_id=1;

dbms_output.put_line('Name: ' || name || ' Address: ' || address || ' Phone No: ' || phone);
end;
/

--Insert and set default value

set serverout on
declare
id BRANCH.BRANCH_ID%type:=10010;
name BRANCH.BRANCH_NAME%type:='ruet1';
address BRANCH.address%type:='RU road';
phone BRANCH.phone_no%type:='01987654321';
begin
insert into branch values(id,name,address,phone);
end;
/

--Row Type

set serveroutput on
declare
customer_row customer%rowtype;
begin
select customer_id,FIRST_NAME,ADDRESS,PHONE_NO into customer_row.customer_id,customer_row.FIRST_NAME,customer_row.ADDRESS,customer_row.PHONE_NO from customer where customer_id=4;
dbms_output.put_line('ID: ' || customer_row.customer_id || ' Name: ' || customer_row.FIRST_NAME || ' Address: ' || customer_row.ADDRESS || ' Phone: ' || customer_row.PHONE_NO);
end;
/

--Cursor and row count

set serveroutput on
declare
    cursor emp_cursor is select * from employee;
    emp_row EMPLOYEE%rowtype;
    begin
        open emp_cursor;
        fetch emp_cursor into emp_row.employee_id,emp_row.first_name,emp_row.last_name,emp_row.position,emp_row.salary,emp_row.branch_id;
        while emp_cursor%found loop
        dbms_output.put_line('Id: ' || emp_row.employee_id ||' Name: ' || emp_row.first_name);
        fetch emp_cursor into emp_row.employee_id,emp_row.first_name,emp_row.last_name,emp_row.position,emp_row.salary,emp_row.branch_id;
        end loop;
    end;
/


--FOR LOOP/WHILE LOOP/ARRAY with extend() function

set serveroutput on
declare
counter number;
name customer.first_name%type;
type namearray is varray(5) of customer.first_name%type;
a_name namearray:=namearray();
begin
    counter:=1;
    for x in 2..5
    loop
    select first_name into name from customer where customer_id=x; 
    a_name.extend();
    a_name(counter):=name;
    counter:=counter+1;
    end loop;
    counter:=1;
    while counter<=a_name.count
    loop
    dbms_output.put_line(a_name(counter));
    counter:=counter+1;
    end loop;
end;
/

--ARRAY without extend() function

set serveroutput on
declare
counter number:=1;
name customer.first_name%type;
type namearray is varray(5) of customer.first_name%type;
a_name namearray:=namearray('Friend 1','Friend 2','Friend 3','Friend 4','Friend 5');
--varray with a fixed size of 5 elements and initilized with Friend number
begin
    counter:=1;
    for x in 2..5
    loop
    select first_name into name from customer where customer_id=x; 
    
    a_name(counter):=name;
    counter:=counter+1;
    end loop;
    counter:=1;
    while counter<=a_name.count
    loop
    dbms_output.put_line(a_name(counter));
    counter:=counter+1;
    end loop;
end;
/

--IF /ELSEIF /ELSE

set serveroutput on
declare
counter number:=1;
name customer.first_name%type;
address CUSTOMER.ADDRESS%type;
type namearray is varray(5) of customer.first_name%type;
a_name namearray:=namearray();
begin
    counter:=1;
    for x in 2..5
    loop
    select first_name into name from customer where customer_id=x; 
    a_name.extend();
    a_name(counter):=name;
    counter:=counter+1;
    end loop;
    counter:=1;
    while counter<=a_name.count
    loop
    select address into address from customer where first_name=(a_name(counter));
    if address='Khagrachari'
        then
            dbms_output.put_line(a_name(counter) || ' is from Khagrachari ');
    elsif address='Rangamati'
        then
            dbms_output.put_line(a_name(counter) || ' is from Rangamati ');
    elsif address='Bandarban'
        then
            dbms_output.put_line(a_name(counter) || ' is from Bandarban ');
    else
            dbms_output.put_line(a_name(counter) || ' is not from Hill Tracts ');

    end if;
    counter:=counter+1;
    
    end loop;
end;
/

--Procedure

--find_account
CREATE OR REPLACE PROCEDURE find_account(
  acc_no IN NUMBER,
  acc_id OUT NUMBER,
  acc_type OUT varchar,
  acc_balance OUT NUMBER,
  acc_rate OUT NUMBER
)
AS
  t_show CHAR(30);
BEGIN
  t_show := 'From procedure: ';
  select customer_id,account_type,balance,interest_rate into acc_id,acc_type,acc_balance,acc_rate from account where account_no=acc_no;
  DBMS_OUTPUT.PUT_LINE(t_show);
  DBMS_OUTPUT.PUT_LINE('Customer ID: ' || acc_id || ', Account Type: ' || acc_type || ', Balance: ' || acc_balance || ', Interest Rate: ' || acc_rate);
END;
/

set serveroutput on
declare
acc_no ACCOUNT.ACCOUNT_NO%type:=101;
acc_id ACCOUNT.CUSTOMER_ID%type;
acc_type ACCOUNT.ACCOUNT_TYPE%type;
acc_balance ACCOUNT.BALANCE%type;
acc_rate ACCOUNT.INTEREST_RATE%type;
begin
    acc_no:=101;
    find_account(acc_no,acc_id,acc_type,acc_balance,acc_rate);
end;
/

--find_customer
CREATE OR REPLACE PROCEDURE find_customer(
  cus_id IN NUMBER,
  cus_first_name OUT varchar,
  cus_last_name OUT varchar,
  cus_address OUT varchar,
  cus_phone OUT varchar
)
AS
  t_show CHAR(30);
BEGIN
  t_show := 'From procedure: ';
  select first_name,last_name,address,phone_no into cus_first_name,cus_last_name,cus_address,cus_phone from customer where customer_id=cus_id;
  DBMS_OUTPUT.PUT_LINE(t_show);
  DBMS_OUTPUT.PUT_LINE('First Name: ' || cus_first_name || ', Last Name: ' || cus_last_name || ', Address: ' || cus_address || ', Phone No: ' || cus_phone);
END;
/

set serveroutput on
declare
cus_id CUSTOMER.CUSTOMER_ID%type:=1;
cus_first_name CUSTOMER.FIRST_NAME%type;
cus_last_name CUSTOMER.LAST_NAME%type;
cus_address CUSTOMER.ADDRESS%type;
cus_phone CUSTOMER.PHONE_NO%type;
begin
    cus_id:=1;
    find_customer(cus_id,cus_first_name,cus_last_name,cus_address,cus_phone);
end;
/

--find_branch
CREATE OR REPLACE PROCEDURE find_branch(
  bra_id IN NUMBER,
  bra_name OUT varchar,
  bra_address OUT varchar,
  bra_phone OUT varchar
)
AS
  t_show CHAR(30);
BEGIN
  t_show := 'From procedure: ';
  select branch_name,address,phone_no into bra_name,bra_address,bra_phone from branch where branch_id=bra_id;
  DBMS_OUTPUT.PUT_LINE(t_show);
  DBMS_OUTPUT.PUT_LINE('Name: ' || bra_name || ', Address: ' || bra_address || ', Phone No: ' || bra_phone);
END;
/

set serveroutput on
declare
branch_id BRANCH.BRANCH_ID%type:=10001;
branch_name BRANCH.BRANCH_NAME%type;
branch_address BRANCH.ADDRESS%type;
branch_phone BRANCH.PHONE_NO%type;
begin
    branch_id:=10001;
    find_branch(branch_id,branch_name,branch_address,branch_phone);
end;
/


--find_employee
CREATE OR REPLACE PROCEDURE find_employee(
  emp_id IN NUMBER,
  emp_first_name OUT varchar,
  emp_last_name OUT varchar,
  emp_position OUT varchar,
  emp_salary OUT NUMBER,
  emp_branch_id OUT NUMBER
)
AS
  t_show CHAR(30);
BEGIN
  t_show := 'From procedure: ';
  select first_name,last_name,position,salary,branch_id into emp_first_name,emp_last_name,emp_position,emp_salary,emp_branch_id from employee where employee_id=emp_id;
  DBMS_OUTPUT.PUT_LINE(t_show);
  DBMS_OUTPUT.PUT_LINE('First Name: ' || emp_first_name || ', Last Name: ' || emp_last_name || ', Position: ' || emp_position || ', Salary: ' || emp_salary || ', Branch Id: '|| emp_branch_id);
END;
/

set serveroutput on
declare
emp_id EMPLOYEE.EMPLOYEE_ID%type:=10;
emp_first_name EMPLOYEE.FIRST_NAME%type;
emp_last_name EMPLOYEE.LAST_NAME%type;
emp_position EMPLOYEE.POSITION%type;
emp_salary EMPLOYEE.SALARY%type;
emp_branch_id EMPLOYEE.BRANCH_ID%type;
begin
    emp_id:=10;
    find_employee(emp_id,emp_first_name,emp_last_name,emp_position,emp_salary,emp_branch_id);
end;
/


--find_transaction
CREATE OR REPLACE PROCEDURE find_transaction(
  tra_id IN NUMBER,
  tra_type OUT varchar,
  tra_amount OUT varchar,
  tra_from OUT varchar,
  tra_to OUT varchar
)
AS
  t_show CHAR(30);
BEGIN
  t_show := 'From procedure: ';
  select transaction_type,amount,from_acc_no,to_acc_no into tra_type,tra_amount,tra_from,tra_to from transaction where transaction_id=tra_id;
  DBMS_OUTPUT.PUT_LINE(t_show);
  DBMS_OUTPUT.PUT_LINE('Transaction Type: ' || tra_type || ', Amount: ' || tra_amount || ', From Account No: ' || tra_from || ', To Account No: ' || tra_to);
END;
/

set serveroutput on
declare
tra_id TRANSACTION.TRANSACTION_ID%type:=1001;
tra_type TRANSACTION.TRANSACTION_TYPE%type;
tra_amount TRANSACTION.AMOUNT%type;
tra_from TRANSACTION.FROM_ACC_NO%type;
tra_to TRANSACTION.TO_ACC_NO%type;
begin
    tra_id:=1001;
    find_transaction(tra_id,tra_type,tra_amount,tra_from,tra_to);
end;
/


--send_money procedure
CREATE OR REPLACE PROCEDURE send_money(
  from_acc_no IN NUMBER,
  to_acc_no IN NUMBER,
  amount IN NUMBER
)
AS
  sender_balance NUMBER;
BEGIN
  -- Check if the sender account has sufficient balance
  SELECT balance INTO sender_balance
  FROM account
  WHERE account_no = from_acc_no;

  IF sender_balance >= amount THEN
    -- Deduct the amount from the sender's account
    UPDATE account
    SET balance = balance - amount
    WHERE account_no = from_acc_no;

    -- Add the amount to the receiver's account
    UPDATE account
    SET balance = balance + amount
    WHERE account_no = to_acc_no;

    -- Insert transaction record
    INSERT INTO transaction (transaction_id, transaction_type, amount, from_acc_no, to_acc_no)
    VALUES (transaction_seq.NEXTVAL, 'Transfer', amount, from_acc_no, to_acc_no);

    -- Print success message
    DBMS_OUTPUT.PUT_LINE('Money transferred successfully.');
  ELSE
    -- Print error message if sender has insufficient balance
    DBMS_OUTPUT.PUT_LINE('Insufficient balance.');
  END IF;
END;
/

SET SERVEROUTPUT ON;

DECLARE
  from_account_no NUMBER;
  to_account_no NUMBER;
  transfer_amount NUMBER;
BEGIN
  -- Set the values for testing
  from_account_no := 101; -- Replace with actual account number
  to_account_no := 106;   -- Replace with actual account number
  transfer_amount := 10; -- Replace with the desired transfer amount

  -- Call the send_money procedure
  send_money(from_account_no, to_account_no, transfer_amount);
END;
/


--deposite procedure
CREATE OR REPLACE PROCEDURE deposit (
  account_no IN NUMBER,
  amount IN NUMBER
)
AS
BEGIN
  -- Add the amount to the specified account
  UPDATE account
  SET balance = balance + amount
  WHERE account_no = account_no;

  -- Insert transaction record
  INSERT INTO transaction (transaction_id, transaction_type, amount, from_acc_no, to_acc_no)
  VALUES (transaction_seq.NEXTVAL, 'Deposit', amount, NULL, account_no);

  -- Print success message
  DBMS_OUTPUT.PUT_LINE('Deposit successful.');
END;
/

SET SERVEROUTPUT ON;

DECLARE
  account_no NUMBER;
  deposit_amount NUMBER;
BEGIN
  -- Set the values for testing
  account_no := 101;   -- Replace with actual account number
  deposit_amount := 100; -- Replace with the desired deposit amount

  -- Call the deposit procedure
  deposit(account_no, deposit_amount);
END;
/

--withdraw
CREATE OR REPLACE PROCEDURE withdraw (
  account_no IN NUMBER,
  amount IN NUMBER
)
AS
  account_balance NUMBER;
BEGIN
  -- Retrieve the current balance of the specified account
  SELECT balance INTO account_balance
  FROM account
  WHERE account_no = account_no
  AND ROWNUM = 1; -- Limit the result to one row

  -- Check if the account has sufficient balance for withdrawal
  IF account_balance >= amount THEN
    -- Deduct the amount from the account balance
    UPDATE account
    SET balance = balance - amount
    WHERE account_no = account_no;

    -- Insert transaction record
    INSERT INTO transaction (transaction_id, transaction_type, amount, from_acc_no, to_acc_no)
    VALUES (transaction_seq.NEXTVAL, 'Withdrawal', amount, account_no, NULL);

    -- Print success message
    DBMS_OUTPUT.PUT_LINE('Withdrawal successful.');
  ELSE
    -- Print error message if there is insufficient balance
    DBMS_OUTPUT.PUT_LINE('Insufficient balance for withdrawal.');
  END IF;
END;
/


SET SERVEROUTPUT ON;

DECLARE
  account_no NUMBER;
  withdrawal_amount NUMBER;
BEGIN
  -- Set the values for testing
  account_no := 101;   -- Replace with actual account number
  withdrawal_amount := 100; -- Replace with the desired withdrawal amount

  -- Call the withdraw procedure
  withdraw(account_no, withdrawal_amount);
END;
/

--view_transaction

CREATE OR REPLACE PROCEDURE view_customer
AS
BEGIN
  FOR customer_rec IN (SELECT * FROM customer)
  LOOP
    DBMS_OUTPUT.PUT_LINE('Customer ID: ' || customer_rec.customer_id);
    DBMS_OUTPUT.PUT_LINE('First Name: ' || customer_rec.first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || customer_rec.last_name);
    DBMS_OUTPUT.PUT_LINE('Address: ' || customer_rec.address);
    DBMS_OUTPUT.PUT_LINE('Phone Number: ' || customer_rec.phone_no);
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
  END LOOP;
END;
/

SET SERVEROUTPUT ON;

BEGIN
  -- Call the view_customer procedure
  view_customer;
END;
/


--view_account

CREATE OR REPLACE PROCEDURE view_account
AS
BEGIN
  FOR account_rec IN (SELECT * FROM account)
  LOOP
    DBMS_OUTPUT.PUT_LINE('Account Number: ' || account_rec.account_no);
    DBMS_OUTPUT.PUT_LINE('Customer ID: ' || account_rec.customer_id);
    DBMS_OUTPUT.PUT_LINE('Account Type: ' || account_rec.account_type);
    DBMS_OUTPUT.PUT_LINE('Balance: ' || account_rec.balance);
    DBMS_OUTPUT.PUT_LINE('Interest Rate: ' || account_rec.interest_rate);
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
  END LOOP;
END;
/

SET SERVEROUTPUT ON;

BEGIN
  -- Call the view_account procedure
  view_account;
END;
/

--view_transaction

CREATE OR REPLACE PROCEDURE view_transaction
AS
BEGIN
  FOR transaction_rec IN (SELECT * FROM transaction)
  LOOP
    DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || transaction_rec.transaction_id);
    DBMS_OUTPUT.PUT_LINE('Transaction Type: ' || transaction_rec.transaction_type);
    DBMS_OUTPUT.PUT_LINE('Amount: ' || transaction_rec.amount);
    DBMS_OUTPUT.PUT_LINE('From Account Number: ' || transaction_rec.from_acc_no);
    DBMS_OUTPUT.PUT_LINE('To Account Number: ' || transaction_rec.to_acc_no);
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
  END LOOP;
END;
/

SET SERVEROUTPUT ON;

BEGIN
  -- Call the view_transaction procedure
  view_transaction;
END;
/

-- view_branch
CREATE OR REPLACE PROCEDURE view_branch
AS
BEGIN
  FOR branch_rec IN (SELECT * FROM branch)
  LOOP
    DBMS_OUTPUT.PUT_LINE('Branch ID: ' || branch_rec.branch_id);
    DBMS_OUTPUT.PUT_LINE('Branch Name: ' || branch_rec.branch_name);
    DBMS_OUTPUT.PUT_LINE('Address: ' || branch_rec.address);
    DBMS_OUTPUT.PUT_LINE('Phone Number: ' || branch_rec.phone_no);
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
  END LOOP;
END;
/

SET SERVEROUTPUT ON;

BEGIN
  -- Call the view_branch_data procedure
  view_branch;
END;
/


--view_employee
CREATE OR REPLACE PROCEDURE view_employee
AS
BEGIN
  FOR employee_rec IN (SELECT * FROM employee)
  LOOP
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || employee_rec.employee_id);
    DBMS_OUTPUT.PUT_LINE('First Name: ' || employee_rec.first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || employee_rec.last_name);
    DBMS_OUTPUT.PUT_LINE('Position: ' || employee_rec.position);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || employee_rec.salary);
    DBMS_OUTPUT.PUT_LINE('Branch ID: ' || employee_rec.branch_id);
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
  END LOOP;
END;
/

SET SERVEROUTPUT ON;

BEGIN
  -- Call the view_employee procedure
  view_employee;
END;
/



















