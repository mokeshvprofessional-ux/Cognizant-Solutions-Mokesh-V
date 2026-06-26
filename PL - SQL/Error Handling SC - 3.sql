CREATE TABLE customers_info (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(50),
    email VARCHAR2(100)
);

INSERT INTO customers_info VALUES (1, 'Alice', 'alice@email.com');
COMMIT;

CREATE OR REPLACE PROCEDURE AddNewCustomer (
    p_customer_id   IN NUMBER,
    p_customer_name IN VARCHAR2,
    p_email         IN VARCHAR2
) AS
BEGIN
    INSERT INTO customers_info (customer_id, customer_name, email)
    VALUES (p_customer_id, p_customer_name, p_email);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Customer ' || p_customer_name || ' added.');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Customer ID ' || p_customer_id || ' already exists. Insertion prevented.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;

BEGIN
    AddNewCustomer(2, 'Bob', 'bob@email.com');
END;
/

SELECT * FROM customers_info;

BEGIN
    AddNewCustomer(1, 'Charlie', 'charlie@email.com');
END;
/

SELECT * FROM customers_info;