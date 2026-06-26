CREATE TABLE loan_accounts (
    loan_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(50),
    loan_type VARCHAR2(20),
    interest_rate NUMBER(4,2)
);

INSERT INTO loan_accounts VALUES (1, 'Alice', 'Home', 4.50);
INSERT INTO loan_accounts VALUES (2, 'Bob', 'Personal', 12.00);
INSERT INTO loan_accounts VALUES (3, 'Charlie', 'Home', 5.00);
COMMIT;

SET SERVEROUTPUT ON;

DECLARE
    CURSOR UpdateLoanInterestRates IS
        SELECT loan_id, loan_type, interest_rate
        FROM loan_accounts
        FOR UPDATE;
        
    v_loan_rec UpdateLoanInterestRates%ROWTYPE;
    v_new_rate NUMBER(4,2);
BEGIN
    OPEN UpdateLoanInterestRates;
    LOOP
        FETCH UpdateLoanInterestRates INTO v_loan_rec;
        EXIT WHEN UpdateLoanInterestRates%NOTFOUND;
        
        IF v_loan_rec.loan_type = 'Home' THEN
            v_new_rate := 3.99;
        ELSIF v_loan_rec.loan_type = 'Personal' THEN
            v_new_rate := 10.50;
        ELSE
            v_new_rate := v_loan_rec.interest_rate;
        END IF;
        
        UPDATE loan_accounts
        SET interest_rate = v_new_rate
        WHERE CURRENT OF UpdateLoanInterestRates;
        
        DBMS_OUTPUT.PUT_LINE('Loan ID ' || v_loan_rec.loan_id || ' (' || v_loan_rec.loan_type || ') updated from ' || v_loan_rec.interest_rate || '% to ' || v_new_rate || '%');
    END LOOP;
    CLOSE UpdateLoanInterestRates;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: All loan interest rates updated.');

EXCEPTION
    WHEN OTHERS THEN
        IF UpdateLoanInterestRates%ISOPEN THEN
            CLOSE UpdateLoanInterestRates;
        END IF;
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/

SELECT * FROM loan_accounts;