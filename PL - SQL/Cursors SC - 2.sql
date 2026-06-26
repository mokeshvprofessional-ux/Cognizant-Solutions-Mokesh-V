CREATE TABLE client_accounts (
    account_id NUMBER PRIMARY KEY,
    account_holder VARCHAR2(50),
    balance NUMBER(10,2)
);

INSERT INTO client_accounts VALUES (101, 'Alice', 2500.00);
INSERT INTO client_accounts VALUES (102, 'Bob', 45.00);
INSERT INTO client_accounts VALUES (103, 'Charlie', 500.00);
COMMIT;

SET SERVEROUTPUT ON;

DECLARE
    v_fee CONSTANT NUMBER(5,2) := 50.00;
    
    CURSOR ApplyAnnualFee IS
        SELECT account_id, account_holder, balance
        FROM client_accounts
        FOR UPDATE;
        
    v_acc_rec ApplyAnnualFee%ROWTYPE;
BEGIN
    OPEN ApplyAnnualFee;
    LOOP
        FETCH ApplyAnnualFee INTO v_acc_rec;
        EXIT WHEN ApplyAnnualFee%NOTFOUND;
        
        UPDATE client_accounts
        SET balance = balance - v_fee
        WHERE CURRENT OF ApplyAnnualFee;
        
        DBMS_OUTPUT.PUT_LINE('Fee applied for ' || v_acc_rec.account_holder || 
                             ' (ID: ' || v_acc_rec.account_id || '). New Balance: $' || 
                             (v_acc_rec.balance - v_fee));
    END LOOP;
    CLOSE ApplyAnnualFee;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Annual maintenance fee applied to all accounts.');

EXCEPTION
    WHEN OTHERS THEN
        IF ApplyAnnualFee%ISOPEN THEN
            CLOSE ApplyAnnualFee;
        END IF;
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Transaction rolled back. Reason: ' || SQLERRM);
END;
/

SELECT * FROM client_accounts;