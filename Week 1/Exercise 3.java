import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.test;

public class CheckMethod
{
    public int add(int a, int b)
    {
        return a+b;
    }
    
    public int greater(int a, int b)
    {
        return a>b;
    }
    
    public Object createObject(boolean returnNull)
    {
        return returnNull ? null : new Object();
    }
}

public class AssertionTest
{
    @Test
    public void TestAssertion()
    {
        CheckMethod check = new CheckMethod();
        
        assertEquals(5, check.add(2, 3));
        
        assertTrue(check.greater(5>3));
        
        assertFalse(check.greater(5<3));
        
        assertNull(check.createObject(true));
        
        assertNotNull(check.createObject(false));
    }
}