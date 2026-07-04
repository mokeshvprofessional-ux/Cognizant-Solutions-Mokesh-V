CREATE TABLE operational_accounts (
    account_id NUMBER PRIMARY KEY,
    account_holder VARCHAR2(50),
    balance NUMBER(10,2)
);

INSERT INTO operational_accounts VALUES (101, 'Alice', 3000.00);
INSERT INTO operational_accounts VALUES (102, 'Bob', 500.00);
COMMIT;

CREATE OR REPLACE PROCEDURE TransferFunds (
    p_from_account IN NUMBER,
    p_to_account   IN NUMBER,
    p_amount       IN NUMBER
) AS
    v_from_balance NUMBER;
BEGIN
    SELECT balance INTO v_from_balance 
    FROM operational_accounts 
    WHERE account_id = p_from_account;
    
    IF v_from_balance < p_amount THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Transfer failed. Insufficient balance in source account.');
        RETURN;
    END IF;
    
    UPDATE operational_accounts
    SET balance = balance - p_amount
    WHERE account_id = p_from_account;
    
    UPDATE operational_accounts
    SET balance = balance + p_amount
    WHERE account_id = p_to_account;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Transferred $' || p_amount || ' from Account ' || p_from_account || ' to Account ' || p_to_account);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: One or both account IDs do not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;

SELECT * FROM operational_accounts;

BEGIN
    TransferFunds(101, 102, 1200.00);
END;
/

SELECT * FROM operational_accounts;

BEGIN
    TransferFunds(102, 101, 4000.00);
END;
/