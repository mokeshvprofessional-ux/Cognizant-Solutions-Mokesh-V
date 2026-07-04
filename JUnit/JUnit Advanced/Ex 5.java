import static org.junit.jupiter.api.Assertions.assertTimeout;

import java.time.Duration;

import org.junit.jupiter.api.Test;

public class PerformanceTester {

    public void performTask() throws InterruptedException {

        Thread.sleep(1000);

        System.out.println("Task Completed Successfully");
    }
}

public class PerformanceTesterTest {

    private PerformanceTester performanceTester = new PerformanceTester();

    @Test
    void testPerformance() {

        assertTimeout(Duration.ofSeconds(2), () -> {
            performanceTester.performTask();
        });
    }
}