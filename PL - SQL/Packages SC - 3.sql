CREATE TABLE customer_accounts (
    account_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    account_type VARCHAR2(20),
    balance NUMBER(10,2),
    status VARCHAR2(10)
);

INSERT INTO customer_accounts VALUES (101, 1, 'Savings', 5000.00, 'Active');
INSERT INTO customer_accounts VALUES (102, 1, 'Checking', 1500.00, 'Active');
INSERT INTO customer_accounts VALUES (103, 2, 'Savings', 250.00, 'Active');
COMMIT;

CREATE OR REPLACE PACKAGE AccountOperations AS
    PROCEDURE OpenAccount (
        p_account_id   IN NUMBER,
        p_customer_id  IN NUMBER,
        p_account_type IN VARCHAR2,
        p_initial_bal  IN NUMBER
    );
    
    PROCEDURE CloseAccount (
        p_account_id IN NUMBER
    );
    
    FUNCTION GetTotalBalance (
        p_customer_id IN NUMBER
    ) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS

    PROCEDURE OpenAccount (
        p_account_id   IN NUMBER,
        p_customer_id  IN NUMBER,
        p_account_type IN VARCHAR2,
        p_initial_bal  IN NUMBER
    ) AS
    BEGIN
        IF p_initial_bal < 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Initial balance cannot be negative.');
            RETURN;
        END IF;

        INSERT INTO customer_accounts (account_id, customer_id, account_type, balance, status)
        VALUES (p_account_id, p_customer_id, p_account_type, p_initial_bal, 'Active');
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Account ' || p_account_id || ' opened for Customer ' || p_customer_id || '.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: Account ID ' || p_account_id || ' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END OpenAccount;

    PROCEDURE CloseAccount (
        p_account_id IN NUMBER
    ) AS
    BEGIN
        UPDATE customer_accounts
        SET balance = 0,
            status = 'Closed'
        WHERE account_id = p_account_id;
        
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('WARNING: Account ID ' || p_account_id || ' not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('SUCCESS: Account ' || p_account_id || ' has been closed and balance cleared.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END CloseAccount;

    FUNCTION GetTotalBalance (
        p_customer_id IN NUMBER
    ) RETURN NUMBER AS
        v_total_balance NUMBER := 0;
    BEGIN
        SELECT SUM(balance) INTO v_total_balance
        FROM customer_accounts
        WHERE customer_id = p_customer_id AND status = 'Active';
        
        RETURN NVL(v_total_balance, 0);
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END GetTotalBalance;

END AccountOperations;
/

SET SERVEROUTPUT ON;

SELECT * FROM customer_accounts;

BEGIN
    AccountOperations.OpenAccount(104, 1, 'Savings', 1200.00);
END;
/

BEGIN
    AccountOperations.CloseAccount(103);
END;
/

DECLARE
    v_total_bal NUMBER;
BEGIN
    v_total_bal := AccountOperations.GetTotalBalance(1);
    DBMS_OUTPUT.PUT_LINE('Total Active Balance for Customer 1: $' || TO_CHAR(v_total_bal, '999,990.00'));
END;
/

SELECT * FROM customer_accounts;