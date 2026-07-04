CREATE TABLE savings_accounts (
    account_id NUMBER PRIMARY KEY,
    account_holder VARCHAR2(50),
    balance NUMBER(10,2)
);

INSERT INTO savings_accounts VALUES (1, 'Alice', 1000.00);
INSERT INTO savings_accounts VALUES (2, 'Bob', 5000.00);
INSERT INTO savings_accounts VALUES (3, 'Charlie', 250.50);
COMMIT;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    FOR acc_rec IN (SELECT account_id, balance FROM savings_accounts) LOOP
        UPDATE savings_accounts
        SET balance = balance + (balance * 0.01)
        WHERE account_id = acc_rec.account_id;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Monthly interest applied to all savings accounts.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;

SELECT * FROM savings_accounts;

BEGIN
    ProcessMonthlyInterest;
END;
/

SELECT * FROM savings_accounts;