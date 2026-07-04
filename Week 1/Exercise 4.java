import static org.junit.Assert.*;
import org.junit.Test;
import org.junit.Before;
import org.junit.After;

public class Calculator
{
    public int add(int a, int b)
    {
        return a+b;
    }
}

public class AssertTest
{
    private Calculator calculator;
    
    @Before
    public void setup()
    {
        calculator = new calculator();
        System.out.println("Setup Executed");
    }
    
    @Test
    public void asserttest()
    {
        //Arrange
        int a = 20;
        int b = 30;
        
        //Act
        int result = calculator.add(a,b);
        
        //Assert
        assertEquals(50, result);
    }
    
    @After
    public void teardown()
    {
        calculator = null;
        System.out.println("Teardown executed");
    }
}