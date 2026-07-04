import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.Test;

public class ExceptionThrower {

    public void throwException() {
        throw new ArithmeticException("Division by zero");
    }
}

public class ExceptionThrowerTest {

    private ExceptionThrower exceptionThrower = new ExceptionThrower();

    @Test
    void testThrowException() {

        assertThrows(ArithmeticException.class, () -> {
            exceptionThrower.throwException();
        });
    }
}