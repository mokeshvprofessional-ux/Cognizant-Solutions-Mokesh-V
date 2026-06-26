CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    account_holder VARCHAR2(50),
    balance NUMBER(10,2)
);

CREATE TABLE transactions (
    transaction_id NUMBER PRIMARY KEY,
    account_id NUMBER,
    transaction_type VARCHAR2(20),
    amount NUMBER(10,2)
);

INSERT INTO accounts VALUES (101, 'Alice', 1000.00);
COMMIT;

CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON transactions
FOR EACH ROW
DECLARE
    v_current_balance NUMBER;
BEGIN
    SELECT balance INTO v_current_balance
    FROM accounts
    WHERE account_id = :NEW.account_id;

    IF :NEW.transaction_type = 'Deposit' AND :NEW.amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Deposit amount must be positive.');
    END IF;

    IF :NEW.transaction_type = 'Withdrawal' THEN
        IF :NEW.amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Withdrawal amount must be positive.');
        ELSIF :NEW.amount > v_current_balance THEN
            RAISE_APPLICATION_ERROR(-20004, 'Withdrawal amount exceeds current balance.');
        END IF;
    END IF;
END;
/

INSERT INTO transactions VALUES (1, 101, 'Deposit', 250.00);

INSERT INTO transactions VALUES (2, 101, 'Deposit', -10.00);

INSERT INTO transactions VALUES (3, 101, 'Withdrawal', 5000.00);