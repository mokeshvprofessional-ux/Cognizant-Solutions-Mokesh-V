CREATE TABLE bank_accounts (
    account_id NUMBER PRIMARY KEY,
    account_holder VARCHAR2(50),
    balance NUMBER(10,2)
);

INSERT INTO bank_accounts VALUES (101, 'Alice', 5000.00);
INSERT INTO bank_accounts VALUES (102, 'Bob', 200.00);
COMMIT;

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    p_from_account IN NUMBER,
    p_to_account   IN NUMBER,
    p_amount       IN NUMBER
) AS
    v_from_balance NUMBER;
    v_exists       NUMBER;
    insufficient_funds EXCEPTION;
    account_not_found  EXCEPTION;
BEGIN
    BEGIN
        SELECT balance INTO v_from_balance 
        FROM bank_accounts 
        WHERE account_id = p_from_account;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE account_not_found;
    END;
    
    SELECT COUNT(*) INTO v_exists 
    FROM bank_accounts 
    WHERE account_id = p_to_account;
    
    IF v_exists = 0 THEN
        RAISE account_not_found;
    END IF;

    IF p_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Transfer amount must be greater than zero.');
    END IF;
    
    IF v_from_balance < p_amount THEN
        RAISE insufficient_funds; 
    END IF;
    
    UPDATE bank_accounts
    SET balance = balance - p_amount
    WHERE account_id = p_from_account;
    
    UPDATE bank_accounts
    SET balance = balance + p_amount
    WHERE account_id = p_to_account;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Transfer completed.');

EXCEPTION
    WHEN insufficient_funds THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient funds.');
    WHEN account_not_found THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid account.');
    WHEN OTHERS THEN
        ROLLBACK; 
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;

BEGIN
    SafeTransferFunds(101, 102, 1000.00);
END;
/

SELECT * FROM bank_accounts;

BEGIN
    SafeTransferFunds(102, 101, 5000.00);
END;
/

SELECT * FROM bank_accounts;