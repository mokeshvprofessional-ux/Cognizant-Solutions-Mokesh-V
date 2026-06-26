CREATE TABLE loan_records (
    loan_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(50),
    loan_amount NUMBER(12,2),
    annual_interest_rate NUMBER(5,2),
    duration_years NUMBER(3)
);

INSERT INTO loan_records VALUES (1, 'Alice', 10000.00, 5.0, 3);
INSERT INTO loan_records VALUES (2, 'Bob', 250000.00, 4.5, 30);
COMMIT;

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
    p_loan_amount         IN NUMBER,
    p_annual_interest_rate IN NUMBER,
    p_duration_years       IN NUMBER
) RETURN NUMBER AS
    v_monthly_rate NUMBER;
    v_total_months NUMBER;
    v_installment  NUMBER;
BEGIN
    IF p_loan_amount <= 0 OR p_duration_years <= 0 THEN
        RETURN 0;
    END IF;

    IF p_annual_interest_rate = 0 THEN
        RETURN ROUND(p_loan_amount / (p_duration_years * 12), 2);
    END IF;

    v_monthly_rate := (p_annual_interest_rate / 100) / 12;
    v_total_months := p_duration_years * 12;

    v_installment := p_loan_amount * (v_monthly_rate * POWER(1 + v_monthly_rate, v_total_months)) / (POWER(1 + v_monthly_rate, v_total_months) - 1);

    RETURN ROUND(v_installment, 2);
END;
/

SET SERVEROUTPUT ON;

SELECT 
    customer_name, 
    loan_amount, 
    annual_interest_rate, 
    duration_years, 
    CalculateMonthlyInstallment(loan_amount, annual_interest_rate, duration_years) AS monthly_payment
FROM loan_records;

DECLARE
    v_test_payment NUMBER;
BEGIN
    v_test_payment := CalculateMonthlyInstallment(5000, 6.0, 1);
    DBMS_OUTPUT.PUT_LINE('Test Loan Monthly Installment: $' || v_test_payment);
END;
/