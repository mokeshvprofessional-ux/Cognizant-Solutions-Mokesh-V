import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.ValueSource;
import static org.junit.jupiter.api.Assertions.*;

public class EvenChecker
{
    public boolean isEven(int num)
    {
        return num%2==0;
    }
}

public class EvenCheckerTest
{
    EvenChecker check = new EvenChecker();
    
    @ParameterizedTest
    @ValueSource(ints = {2,4,6,8,10})
    public void testeven(int num)
    {
        assertTrue(check.isEven(num));
    }
    
    @ParameterizedTest
    @ValueSource(ints = {1,3,5,7,9})
    public void testeven(int num)
    {
        assertFalse(check.isEven(num));
    }
}