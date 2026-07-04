import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.Test;

// Repository Interface
interface Repository {
    String getData();
}

// Service Class
class Service {

    private Repository repository;

    public Service(Repository repository) {
        this.repository = repository;
    }

    public String processData() {
        return "Processed " + repository.getData();
    }
}

// Test Class
public class MultiReturnServiceTest {

    @Test
    public void testServiceWithMultipleReturnValues() {

        // Create Mock Repository
        Repository mockRepository = mock(Repository.class);

        // Stub Method with Multiple Return Values
        when(mockRepository.getData())
                .thenReturn("First Mock Data")
                .thenReturn("Second Mock Data");

        // Create Service
        Service service = new Service(mockRepository);

        // Call Method Twice
        String firstResult = service.processData();
        String secondResult = service.processData();

        // Verify Results
        assertEquals("Processed First Mock Data", firstResult);
        assertEquals("Processed Second Mock Data", secondResult);

        // Verify Interaction
        verify(mockRepository, times(2)).getData();
    }
}