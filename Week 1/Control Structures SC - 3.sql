CREATE TABLE Loans(
    loan_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(50),
    amount NUMBER(10,2),
    due_date DATE
);

INSERT INTO Loans Values(1, 'Max', 20000.00, SYSDATE+45);
INSERT INTO Loans Values(2, 'Charles', 20000.00, SYSDATE+30);
INSERT INTO Loans Values(3, 'Leclerc', 30000.00, SYSDATE+20);
INSERT INTO Loans Values(4, 'Emilia', 40000.00, SYSDATE);

SET SERVEROUTPUT ON;

BEGIN
    FOR loan_rec IN(
        SELECT loan_id, customer_name, amount, due_date FROM Loans WHERE 
        due_date BETWEEN SYSDATE AND (SYSDATE+30)) LOOP
        
        DBMS_OUTPUT.PUT_LINE('REMAINDER HELLO!!' || loan_rec.customer_name ||' your loan amount '|| loan_rec.amount || ' is reaching the due date');
    END LOOP;
END;
/

SELECT * FROM Loans;