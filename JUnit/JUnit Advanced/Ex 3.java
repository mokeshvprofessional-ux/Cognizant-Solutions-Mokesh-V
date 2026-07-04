import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

@TestMethodOrder(OrderAnnotation.class)
public class OrderedTests {

    @Test
    @Order(1)
    void firstTest() {
        System.out.println("First Test Executed");
    }

    @Test
    @Order(2)
    void secondTest() {
        System.out.println("Second Test Executed");
    }

    @Test
    @Order(3)
    void thirdTest() {
        System.out.println("Third Test Executed");
    }
}