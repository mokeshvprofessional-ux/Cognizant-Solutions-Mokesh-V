CREATE TABLE bank_staff (
    employee_id NUMBER PRIMARY KEY,
    employee_name VARCHAR2(50),
    job_title VARCHAR2(50),
    monthly_salary NUMBER(10,2)
);

INSERT INTO bank_staff VALUES (1, 'Alice Vance', 'Manager', 5500.00);
COMMIT;

CREATE OR REPLACE PACKAGE EmployeeManagement AS
    PROCEDURE HireNewEmployee (
        p_employee_id   IN NUMBER,
        p_employee_name IN VARCHAR2,
        p_job_title     IN VARCHAR2,
        p_monthly_sal   IN NUMBER
    );
    
    PROCEDURE UpdateEmployeeDetails (
        p_employee_id   IN NUMBER,
        p_employee_name IN VARCHAR2,
        p_job_title     IN VARCHAR2
    );
    
    FUNCTION CalculateAnnualSalary (
        p_employee_id IN NUMBER
    ) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

    PROCEDURE HireNewEmployee (
        p_employee_id   IN NUMBER,
        p_employee_name IN VARCHAR2,
        p_job_title     IN VARCHAR2,
        p_monthly_sal   IN NUMBER
    ) AS
    BEGIN
        INSERT INTO bank_staff (employee_id, employee_name, job_title, monthly_salary)
        VALUES (p_employee_id, p_employee_name, p_job_title, p_monthly_sal);
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Employee ' || p_employee_name || ' successfully hired.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: Employee ID ' || p_employee_id || ' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END HireNewEmployee;

    PROCEDURE UpdateEmployeeDetails (
        p_employee_id   IN NUMBER,
        p_employee_name IN VARCHAR2,
        p_job_title     IN VARCHAR2
    ) AS
    BEGIN
        UPDATE bank_staff
        SET employee_name = p_employee_name,
            job_title = p_job_title
        WHERE employee_id = p_employee_id;
        
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('WARNING: Employee ID ' || p_employee_id || ' not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('SUCCESS: Employee ID ' || p_employee_id || ' updated.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END UpdateEmployeeDetails;

    FUNCTION CalculateAnnualSalary (
        p_employee_id IN NUMBER
    ) RETURN NUMBER AS
        v_monthly_salary NUMBER;
    BEGIN
        SELECT monthly_salary INTO v_monthly_salary
        FROM bank_staff
        WHERE employee_id = p_employee_id;
        
        RETURN v_monthly_salary * 12;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('WARNING: Employee ID ' || p_employee_id || ' not found.');
            RETURN NULL;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
            RETURN NULL;
    END CalculateAnnualSalary;

END EmployeeManagement;
/

SET SERVEROUTPUT ON;

SELECT * FROM bank_staff;

BEGIN
    EmployeeManagement.HireNewEmployee(2, 'Bob Miller', 'Senior Analyst', 4800.00);
END;
/

BEGIN
    EmployeeManagement.UpdateEmployeeDetails(1, 'Alice Smith', 'Regional Director');
END;
/

DECLARE
    v_annual_sal NUMBER;
BEGIN
    v_annual_sal := EmployeeManagement.CalculateAnnualSalary(1);
    DBMS_OUTPUT.PUT_LINE('Alice''s Annual Salary: $' || TO_CHAR(v_annual_sal, '999,990.00'));
END;
/

SELECT * FROM bank_staff;