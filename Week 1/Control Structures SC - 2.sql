CREATE TABLE Vip_Customers(
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(50) NOT NULL,
    balance NUMBER(10,2),
    vip VARCHAR2(1) DEFAULT 'N'
);

INSERT INTO Vip_Customers VALUES(1, 'MAX', 15000.00, 'N');
INSERT INTO Vip_Customers VALUES(2, 'SARA', 8000.00, 'N');
INSERT INTO Vip_Customers VALUES(3, 'JOHN', 12000.00, 'N');

BEGIN
    FOR cust_rec IN (SELECT customer_id, balance FROM Vip_Customers) LOOP
        IF cust_rec.balance > 10000 THEN
            UPDATE Vip_Customers
            SET vip = 'Y'
            WHERE customer_id = cust_rec.customer_id;
        END IF;
    END LOOP;
END;
/

SELECT * FROM Vip_Customers;