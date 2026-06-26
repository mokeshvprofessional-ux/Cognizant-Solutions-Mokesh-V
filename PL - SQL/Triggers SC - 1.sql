CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(50),
    email VARCHAR2(100),
    last_modified DATE
);

INSERT INTO customers VALUES (1, 'Alice', 'alice@email.com', SYSDATE - 5);
INSERT INTO customers VALUES (2, 'Bob', 'bob@email.com', SYSDATE - 10);
COMMIT;

CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
    :NEW.last_modified := SYSDATE;
END;
/

SELECT * FROM customers;

UPDATE customers 
SET email = 'alice_new@email.com' 
WHERE customer_id = 1;

SELECT * FROM customers;