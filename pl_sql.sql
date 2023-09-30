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
id BRANCH.BRANCH_ID%type:=10020;
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
select customer_id,FIRST_NAME,ADDRESS,PHONE_NO,branch_id into customer_row.customer_id,customer_row.FIRST_NAME,customer_row.ADDRESS,customer_row.PHONE_NO,customer_row.BRANCH_ID from customer where customer_id=4;
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


--Procedure

--insert customer
CREATE OR REPLACE PROCEDURE insert_customer(
  p_customer_id IN customer.customer_id%TYPE,
  p_first_name IN customer.first_name%TYPE,
  p_last_name IN customer.last_name%TYPE,
  p_address IN customer.address%TYPE,
  p_phone_no IN customer.phone_no%TYPE,
  p_branch_id IN customer.branch_id%TYPE
)
IS
BEGIN
  INSERT INTO customer(customer_id, first_name, last_name, address, phone_no, branch_id)
  VALUES (p_customer_id, p_first_name, p_last_name, p_address, p_phone_no, p_branch_id);
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Customer inserted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inserting customer: ' || SQLERRM);
END;
/

set serveroutput on
declare
BEGIN
  insert_customer(11, 'John', 'Doe', '123 Main St', '01234567881',10010);
END;
/

--modify customer
CREATE OR REPLACE PROCEDURE modify_customer(
  p_customer_id IN customer.customer_id%TYPE,
  p_new_first_name IN customer.first_name%TYPE,
  p_new_last_name IN customer.last_name%TYPE,
  p_new_address IN customer.address%TYPE,
  p_new_phone_no IN customer.phone_no%TYPE,
  p_new_branch_id IN customer.branch_id%TYPE
)
IS
BEGIN
  UPDATE customer
  SET first_name = p_new_first_name,
      last_name = p_new_last_name,
      address = p_new_address,
      phone_no = p_new_phone_no,
      branch_id = p_new_branch_id
  WHERE customer_id = p_customer_id;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Customer modified successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error modifying customer: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  --insert_customer(11, 'John', 'Doe', '123 Main St', '01234567881',10010);
  modify_customer(11, 'Jane', 'Smith', '456 Elm St', '9876543210',10010);
END;
/

-- delete customer
CREATE OR REPLACE PROCEDURE delete_customer(
  p_customer_id IN customer.customer_id%TYPE
)
IS
BEGIN
  DELETE FROM customer WHERE customer_id = p_customer_id;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Customer deleted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error deleting customer: ' || SQLERRM);
END;
/

set serveroutput on
declare
BEGIN
  --insert_customer(11, 'John', 'Doe', '123 Main St', '01234567881',10010);
  --modify_customer(11, 'Jane', 'Smith', '456 Elm St', '9876543210',10010);
  delete_customer(11);
END;
/


--insert account
CREATE OR REPLACE PROCEDURE insert_account(
  p_account_no IN account.account_no%TYPE,
  p_customer_id IN account.customer_id%TYPE,
  p_account_type IN account.account_type%TYPE,
  p_balance IN account.balance%TYPE,
  p_interest_rate IN account.interest_rate%TYPE
)
IS
BEGIN
  INSERT INTO account(account_no, customer_id, account_type, balance, interest_rate)
  VALUES (p_account_no, p_customer_id, p_account_type, p_balance, p_interest_rate);
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Account inserted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inserting account: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
--insert_customer(11, 'John', 'Doe', '123 Main St', '01234567881');
  insert_account(111, 11, 'Savings', 1000.00, 0.5);
END;
/


--modify account
CREATE OR REPLACE PROCEDURE modify_account(
  p_account_no IN account.account_no%TYPE,
  p_customer_id IN account.customer_id%TYPE,
  p_account_type IN account.account_type%TYPE,
  p_balance IN account.balance%TYPE,
  p_interest_rate IN account.interest_rate%TYPE
)
IS
BEGIN
  UPDATE account
  SET customer_id = p_customer_id,
      account_type = p_account_type,
      balance = p_balance,
      interest_rate = p_interest_rate
  WHERE account_no = p_account_no;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Account modified successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error modifying account: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  --insert_customer(11, 'John', 'Doe', '123 Main St', '01234567881');
  --insert_account(111, 11, 'Savings', 1000.00, 0.5);
  modify_account(111, 11, 'Checking', 500.00, 0.25);
END;
/


--delete account
CREATE OR REPLACE PROCEDURE delete_account(
  p_account_no IN account.account_no%TYPE
)
IS
BEGIN
  DELETE FROM account WHERE account_no = p_account_no;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Account deleted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error deleting account: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  --insert_customer(11, 'John', 'Doe', '123 Main St', '01234567881');
  --insert_account(111, 11, 'Savings', 1000.00, 0.5);
  --modify_account(111, 11, 'Checking', 500.00, 0.25);
  delete_account(111);
END;
/


--insert transaction
CREATE OR REPLACE PROCEDURE insert_transaction(
  p_transaction_id IN transaction.transaction_id%TYPE,
  p_transaction_type IN transaction.transaction_type%TYPE,
  p_amount IN transaction.amount%TYPE,
  p_from_acc_no IN transaction.from_acc_no%TYPE,
  p_to_acc_no IN transaction.to_acc_no%TYPE
)
IS
BEGIN
  INSERT INTO transaction(transaction_id, transaction_type, amount, from_acc_no, to_acc_no)
  VALUES (p_transaction_id, p_transaction_type, p_amount, p_from_acc_no, p_to_acc_no);
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Transaction inserted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inserting transaction: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  --insert_customer(11, 'John', 'Doe', '123 Main St', '01234567881');
  --insert_account(111, 11, 'Savings', 1000.00, 0.5);
  --modify_account(111, 11, 'Checking', 500.00, 0.25);
  --delete_account(111);
  --insert_account(111, 11, 'Savings', 1000.00, 0.5);
  --modify_account(111, 11, 'Checking', 500.00, 0.25);
  --delete_account(111);
  insert_transaction(1011, 'Transfer', 500.00, 111, 101);
END;
/


--modify transaction
CREATE OR REPLACE PROCEDURE modify_transaction(
  p_transaction_id IN transaction.transaction_id%TYPE,
  p_transaction_type IN transaction.transaction_type%TYPE,
  p_amount IN transaction.amount%TYPE,
  p_from_acc_no IN transaction.from_acc_no%TYPE,
  p_to_acc_no IN transaction.to_acc_no%TYPE
)
IS
BEGIN
  UPDATE transaction
  SET transaction_type = p_transaction_type,
      amount = p_amount,
      from_acc_no = p_from_acc_no,
      to_acc_no = p_to_acc_no
  WHERE transaction_id = p_transaction_id;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Transaction modified successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error modifying transaction: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  --insert_customer(11, 'John', 'Doe', '123 Main St', '01234567881');
  --insert_account(111, 11, 'Savings', 1000.00, 0.5);
  --modify_account(111, 11, 'Checking', 500.00, 0.25);
  --delete_account(111);
  --insert_account(111, 11, 'Savings', 1000.00, 0.5);
  --modify_account(111, 11, 'Checking', 500.00, 0.25);
  --delete_account(111);
  --insert_transaction(1011, 'Transfer', 500.00, 111, 101);
    modify_transaction(1011, 'Deposit', 1000.00, 111, 101);
END;
/


--delete transaction
CREATE OR REPLACE PROCEDURE delete_transaction(
  p_transaction_id IN transaction.transaction_id%TYPE
)
IS
BEGIN
  DELETE FROM transaction WHERE transaction_id = p_transaction_id;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Transaction deleted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error deleting transaction: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  --insert_customer(11, 'John', 'Doe', '123 Main St', '01234567881');
  --insert_account(111, 11, 'Savings', 1000.00, 0.5);
  --modify_account(111, 11, 'Checking', 500.00, 0.25);
  --delete_account(111);
  --insert_account(111, 11, 'Savings', 1000.00, 0.5);
  --modify_account(111, 11, 'Checking', 500.00, 0.25);
  --delete_account(111);
  --insert_transaction(1011, 'Transfer', 500.00, 111, 101);
    --modify_transaction(1011, 'Deposit', 1000.00, 111, 101);
    delete_transaction(10001);
END;
/


--insert branch
CREATE OR REPLACE PROCEDURE insert_branch(
  p_branch_id IN branch.branch_id%TYPE,
  p_branch_name IN branch.branch_name%TYPE,
  p_address IN branch.address%TYPE,
  p_phone_no IN branch.phone_no%TYPE
)
IS
BEGIN
  INSERT INTO branch(branch_id, branch_name, address, phone_no)
  VALUES (p_branch_id, p_branch_name, p_address, p_phone_no);
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Branch inserted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inserting branch: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  insert_branch(10011, 'Main Branch', '123 Main St', '01234567890');
END;
/


--modify branch
CREATE OR REPLACE PROCEDURE modify_branch(
  p_branch_id IN branch.branch_id%TYPE,
  p_branch_name IN branch.branch_name%TYPE,
  p_address IN branch.address%TYPE,
  p_phone_no IN branch.phone_no%TYPE
)
IS
BEGIN
  UPDATE branch
  SET branch_name = p_branch_name,
      address = p_address,
      phone_no = p_phone_no
  WHERE branch_id = p_branch_id;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Branch modified successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error modifying branch: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  --insert_branch(10011, 'Main Branch', '123 Main St', '01234567890');
    modify_branch(10011, 'Updated Branch', '456 Elm St', '09876543210');
END;
/


--delete branch
CREATE OR REPLACE PROCEDURE delete_branch(
  p_branch_id IN branch.branch_id%TYPE
)
IS
BEGIN
  DELETE FROM branch WHERE branch_id = p_branch_id;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Branch deleted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error deleting branch: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  --insert_branch(10011, 'Main Branch', '123 Main St', '01234567890');
  --modify_branch(10011, 'Updated Branch', '456 Elm St', '09876543210');
    delete_branch(10011);
    delete_branch(10020);
END;
/


--insert employee
CREATE OR REPLACE PROCEDURE insert_employee(
  p_employee_id IN employee.employee_id%TYPE,
  p_first_name IN employee.first_name%TYPE,
  p_last_name IN employee.last_name%TYPE,
  p_position IN employee.position%TYPE,
  p_salary IN employee.salary%TYPE,
  p_branch_id IN employee.branch_id%TYPE
)
IS
BEGIN
  INSERT INTO employee(employee_id, first_name, last_name, position, salary, branch_id)
  VALUES (p_employee_id, p_first_name, p_last_name, p_position, p_salary, p_branch_id);
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Employee inserted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inserting employee: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  --insert_branch(10011, 'Main Branch', '123 Main St', '01234567890');
  --modify_branch(10011, 'Updated Branch', '456 Elm St', '09876543210');
    --delete_branch(10011);
    insert_employee(21, 'John', 'Doe', 'Manager', 5000.00, 10011);
END;
/


--modify employee
CREATE OR REPLACE PROCEDURE modify_employee(
  p_employee_id IN employee.employee_id%TYPE,
  p_first_name IN employee.first_name%TYPE,
  p_last_name IN employee.last_name%TYPE,
  p_position IN employee.position%TYPE,
  p_salary IN employee.salary%TYPE,
  p_branch_id IN employee.branch_id%TYPE
)
IS
BEGIN
  UPDATE employee
  SET first_name = p_first_name,
      last_name = p_last_name,
      position = p_position,
      salary = p_salary,
      branch_id = p_branch_id
  WHERE employee_id = p_employee_id;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Employee modified successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error modifying employee: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  --insert_branch(10011, 'Main Branch', '123 Main St', '01234567890');
  --modify_branch(10011, 'Updated Branch', '456 Elm St', '09876543210');
    --delete_branch(10011);
    --insert_employee(21, 'John', 'Doe', 'Manager', 5000.00, 10011);
    modify_employee(21, 'Jane', 'Smith', 'Supervisor', 4500.00, 10011);
END;
/


--delete employee
CREATE OR REPLACE PROCEDURE delete_employee(
  p_employee_id IN employee.employee_id%TYPE
)
IS
BEGIN
  DELETE FROM employee WHERE employee_id = p_employee_id;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Employee deleted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error deleting employee: ' || SQLERRM);
END;
/


set serveroutput on
declare
BEGIN
  --insert_branch(10011, 'Main Branch', '123 Main St', '01234567890');
  --modify_branch(10011, 'Updated Branch', '456 Elm St', '09876543210');
    --delete_branch(10011);
    --insert_employee(21, 'John', 'Doe', 'Manager', 5000.00, 10011);
    --modify_employee(21, 'Jane', 'Smith', 'Supervisor', 4500.00, 10011);
    delete_employee(21);
END;
/




























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
emp_id EMPLOYEE.EMPLOYEE_ID%type:=11;
emp_first_name EMPLOYEE.FIRST_NAME%type;
emp_last_name EMPLOYEE.LAST_NAME%type;
emp_position EMPLOYEE.POSITION%type;
emp_salary EMPLOYEE.SALARY%type;
emp_branch_id EMPLOYEE.BRANCH_ID%type;
begin
    emp_id:=11;
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



















