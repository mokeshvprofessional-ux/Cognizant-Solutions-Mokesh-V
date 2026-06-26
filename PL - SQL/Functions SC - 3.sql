CREATE TABLE client_balances (
    account_id NUMBER PRIMARY KEY,
    account_holder VARCHAR2(50),
    balance NUMBER(10,2)
);

INSERT INTO client_balances VALUES (101, 'Alice', 1500.00);
INSERT INTO client_balances VALUES (102, 'Bob', 50.00);
COMMIT;

CREATE OR REPLACE FUNCTION HasSufficientBalance (
    p_account_id IN NUMBER,
    p_amount     IN NUMBER
) RETURN BOOLEAN AS
    v_balance NUMBER;
BEGIN
    SELECT balance INTO v_balance
    FROM client_balances
    WHERE account_id = p_account_id;

    IF v_balance >= p_amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    WHEN OTHERS THEN
        RETURN FALSE;
END;
/

SET SERVEROUTPUT ON;

DECLARE
    v_result_alice BOOLEAN;
    v_result_bob   BOOLEAN;
BEGIN
    v_result_alice := HasSufficientBalance(101, 1000.00);
    IF v_result_alice THEN
        DBMS_OUTPUT.PUT_LINE('Alice has sufficient funds for $1000.00');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Alice does NOT have sufficient funds for $1000.00');
    END IF;

    v_result_bob := HasSufficientBalance(102, 1000.00);
    IF v_result_bob THEN
        DBMS_OUTPUT.PUT_LINE('Bob has sufficient funds for $1000.00');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Bob does NOT have sufficient funds for $1000.00');
    END IF;
END;
/