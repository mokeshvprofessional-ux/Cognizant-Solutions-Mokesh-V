import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;


public class CalculatorTest {

    @Test
    void testAddition() {
        int result = 10 + 5;
        assertEquals(15, result);
    }
}

public class EvenCheckerTest {

    private EvenChecker checker = new EvenChecker();

    @ParameterizedTest
    @ValueSource(ints = {2,4,6,8,10})
    void testEvenNumbers(int number) {
        assertTrue(checker.isEven(number));
    }

    @ParameterizedTest
    @ValueSource(ints = {1,3,5,7,9})
    void testOddNumbers(int number) {
        assertFalse(checker.isEven(number));
    }
}

@Suite
@SelectClasses({
        CalculatorTest.class,
        EvenCheckerTest.class
})
public class AllTests {
}