CREATE TABLE customer_records (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(50),
    email VARCHAR2(100),
    balance NUMBER(10,2)
);

INSERT INTO customer_records VALUES (1, 'Alice', 'alice@email.com', 1500.00);
COMMIT;

CREATE OR REPLACE PACKAGE CustomerManagement AS
    PROCEDURE AddNewCustomer (
        p_customer_id   IN NUMBER,
        p_customer_name IN VARCHAR2,
        p_email         IN VARCHAR2,
        p_initial_bal   IN NUMBER
    );
    
    PROCEDURE UpdateCustomerDetails (
        p_customer_id   IN NUMBER,
        p_customer_name IN VARCHAR2,
        p_email         IN VARCHAR2
    );
    
    FUNCTION GetCustomerBalance (
        p_customer_id IN NUMBER
    ) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement AS

    PROCEDURE AddNewCustomer (
        p_customer_id   IN NUMBER,
        p_customer_name IN VARCHAR2,
        p_email         IN VARCHAR2,
        p_initial_bal   IN NUMBER
    ) AS
    BEGIN
        INSERT INTO customer_records (customer_id, customer_name, email, balance)
        VALUES (p_customer_id, p_customer_name, p_email, p_initial_bal);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Customer ' || p_customer_name || ' added.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: Customer ID ' || p_customer_id || ' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END AddNewCustomer;

    PROCEDURE UpdateCustomerDetails (
        p_customer_id   IN NUMBER,
        p_customer_name IN VARCHAR2,
        p_email         IN VARCHAR2
    ) AS
    BEGIN
        UPDATE customer_records
        SET customer_name = p_customer_name,
            email = p_email
        WHERE customer_id = p_customer_id;
        
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('WARNING: Customer ID ' || p_customer_id || ' not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('SUCCESS: Customer ID ' || p_customer_id || ' updated.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END UpdateCustomerDetails;

    FUNCTION GetCustomerBalance (
        p_customer_id IN NUMBER
    ) RETURN NUMBER AS
        v_balance NUMBER;
    BEGIN
        SELECT balance INTO v_balance
        FROM customer_records
        WHERE customer_id = p_customer_id;
        
        RETURN v_balance;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END GetCustomerBalance;

END CustomerManagement;
/

SET SERVEROUTPUT ON;

BEGIN
    CustomerManagement.AddNewCustomer(2, 'Bob', 'bob@email.com', 500.00);
END;
/

BEGIN
    CustomerManagement.UpdateCustomerDetails(1, 'Alice Smith', 'alice.smith@email.com');
END;
/

DECLARE
    v_bal NUMBER;
BEGIN
    v_bal := CustomerManagement.GetCustomerBalance(1);
    DBMS_OUTPUT.PUT_LINE('Alice''s Balance: $' || v_bal);
END;
/

SELECT * FROM customer_records;