CREATE TABLE transactions (
    transaction_id NUMBER PRIMARY KEY,
    account_id NUMBER,
    transaction_type VARCHAR2(20),
    amount NUMBER(10,2),
    transaction_date DATE
);

CREATE TABLE audit_log (
    log_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    transaction_id NUMBER,
    account_id NUMBER,
    transaction_type VARCHAR2(20),
    amount NUMBER(10,2),
    logged_date DATE
);

CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (
        transaction_id, 
        account_id, 
        transaction_type, 
        amount, 
        logged_date
    )
    VALUES (
        :NEW.transaction_id, 
        :NEW.account_id, 
        :NEW.transaction_type, 
        :NEW.amount, 
        SYSDATE
    );
END;
/

INSERT INTO transactions VALUES (5001, 101, 'Deposit', 1500.00, SYSDATE);
COMMIT;

SELECT * FROM transactions;
SELECT * FROM audit_log;