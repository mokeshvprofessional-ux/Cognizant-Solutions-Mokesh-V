CREATE TABLE customer_dob (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(50),
    date_of_birth DATE
);

INSERT INTO customer_dob VALUES (1, 'Alice', TO_DATE('1990-05-15', 'YYYY-MM-DD'));
INSERT INTO customer_dob VALUES (2, 'Bob', TO_DATE('1965-11-23', 'YYYY-MM-DD'));
INSERT INTO customer_dob VALUES (3, 'Charlie', TO_DATE('2010-02-01', 'YYYY-MM-DD'));
COMMIT;

CREATE OR REPLACE FUNCTION CalculateAge (
    p_dob IN DATE
) RETURN NUMBER AS
    v_age NUMBER;
BEGIN
    v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
    RETURN v_age;
END;
/

SET SERVEROUTPUT ON;

SELECT customer_name, date_of_birth, CalculateAge(date_of_birth) AS current_age 
FROM customer_dob;

DECLARE
    v_test_age NUMBER;
BEGIN
    v_test_age := CalculateAge(TO_DATE('1985-08-10', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Test Age Output: ' || v_test_age);
END;
/