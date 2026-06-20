CREATE TABLE Customers(
  customer_id NUMBER PRIMARY KEY,
  customer_name VARCHAR(50),
  age NUMBER,
  intereset_rate NUMBER(4,2)
);

INSERT INTO Customers VALUES(1, 'Max', 30, 6.50);
INSERT INTO Customers VALUES(2, 'Lewis', 30, 7.00);
INSERT INTO Customers VALUES(3, 'Charles', 60, 6.65);
INSERT INTO Customers VALUES(4, 'George', 65, 8.85);

BEGIN
    FOR cust_rec IN (SELECT customer_id, age FROM Customers) LOOP
        IF cust_rec.age > 60 THEN
            UPDATE Customers
            SET intereset_rate = intereset_rate - 1
            WHERE customer_id = cust_rec.customer_id;
        END IF;
    END LOOP;
    COMMIT;
END;
/

SELECT * FROM Customers;