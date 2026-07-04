CREATE TABLE bank_employees (
    employee_id NUMBER PRIMARY KEY,
    employee_name VARCHAR2(50),
    department VARCHAR2(50),
    salary NUMBER(10,2)
);

INSERT INTO bank_employees VALUES (1, 'Alice', 'Sales', 4000.00);
INSERT INTO bank_employees VALUES (2, 'Bob', 'Sales', 5000.00);
INSERT INTO bank_employees VALUES (3, 'Charlie', 'HR', 4500.00);
COMMIT;

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) AS
    v_row_count NUMBER := 0;
BEGIN
    UPDATE bank_employees
    SET salary = salary + (salary * (p_bonus_percentage / 100))
    WHERE UPPER(department) = UPPER(p_department);

    v_row_count := SQL%ROWCOUNT;

    IF v_row_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('WARNING: No employees found in department: ' || p_department);
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Updated ' || v_row_count || ' employee(s) in ' || p_department || ' department.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;

SELECT * FROM bank_employees;

BEGIN
    UpdateEmployeeBonus('Sales', 10);
END;
/

SELECT * FROM bank_employees;

BEGIN
    UpdateEmployeeBonus('Marketing', 5);
END;
/