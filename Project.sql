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
