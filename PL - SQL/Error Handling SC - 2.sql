CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    employee_name VARCHAR2(50),
    salary NUMBER(10,2)
);

INSERT INTO employees VALUES (1, 'Alice', 5000.00);
INSERT INTO employees VALUES (2, 'Bob', 6000.00);
COMMIT;

CREATE OR REPLACE PROCEDURE UpdateSalary (
    p_employee_id IN NUMBER,
    p_percentage  IN NUMBER
) AS
    v_current_salary NUMBER;
BEGIN
    SELECT salary INTO v_current_salary
    FROM employees
    WHERE employee_id = p_employee_id;

    UPDATE employees
    SET salary = salary + (salary * (p_percentage / 100))
    WHERE employee_id = p_employee_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Salary updated for Employee ID ' || p_employee_id);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Employee ID ' || p_employee_id || ' does not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;

BEGIN
    UpdateSalary(1, 10);
END;
/

SELECT * FROM employees;

BEGIN
    UpdateSalary(999, 10);
END;
/

SELECT * FROM employees;