CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(50)
);

CREATE TABLE customer_transactions (
    transaction_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    transaction_type VARCHAR2(20),
    amount NUMBER(10,2),
    transaction_date DATE
);

INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');

INSERT INTO customer_transactions VALUES (101, 1, 'Deposit', 1500.00, TRUNC(SYSDATE, 'MM') + 2);
INSERT INTO customer_transactions VALUES (102, 1, 'Withdrawal', 200.00, TRUNC(SYSDATE, 'MM') + 5);
INSERT INTO customer_transactions VALUES (103, 2, 'Deposit', 3000.00, TRUNC(SYSDATE, 'MM') + 1);
INSERT INTO customer_transactions VALUES (104, 2, 'Deposit', 450.00, ADD_MONTHS(SYSDATE, -1));
COMMIT;

SET SERVEROUTPUT ON;

DECLARE
    CURSOR GenerateMonthlyStatements IS
        SELECT c.customer_name, t.customer_id, t.transaction_type, t.amount, t.transaction_date
        FROM customer_transactions t
        JOIN customers c ON t.customer_id = c.customer_id
        WHERE t.transaction_date >= TRUNC(SYSDATE, 'MM')
          AND t.transaction_date < ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 1)
        ORDER BY t.customer_id, t.transaction_date;
        
    v_stmt_rec GenerateMonthlyStatements%ROWTYPE;
    v_prev_customer_id NUMBER := -1;
BEGIN
    OPEN GenerateMonthlyStatements;
    LOOP
        FETCH GenerateMonthlyStatements INTO v_stmt_rec;
        EXIT WHEN GenerateMonthlyStatements%NOTFOUND;
        
        IF v_prev_customer_id <> v_stmt_rec.customer_id THEN
            IF v_prev_customer_id <> -1 THEN
                DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
            END IF;
            DBMS_OUTPUT.PUT_LINE('MONTHLY STATEMENT FOR: ' || UPPER(v_stmt_rec.customer_name) || ' (ID: ' || v_stmt_rec.customer_id || ')');
            DBMS_OUTPUT.PUT_LINE('DATE       | TYPE        | AMOUNT');
            DBMS_OUTPUT.PUT_LINE('-----------|-------------|------------');
            v_prev_customer_id := v_stmt_rec.customer_id;
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(
            TO_CHAR(v_stmt_rec.transaction_date, 'YYYY-MM-DD') || ' | ' || 
            RPAD(v_stmt_rec.transaction_type, 11) || ' | $' || 
            LPAD(TO_CHAR(v_stmt_rec.amount, '999990.00'), 10)
        );
    END LOOP;
    
    IF v_prev_customer_id <> -1 THEN
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    END IF;
    
    CLOSE GenerateMonthlyStatements;
END;
/