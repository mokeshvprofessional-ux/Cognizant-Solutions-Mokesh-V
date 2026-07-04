import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.Test;

public interface Repository {

    String getData();

}

public class Service {

    private Repository repository;

    public Service(Repository repository) {
        this.repository = repository;
    }

    public String processData() {
        return "Processed " + repository.getData();
    }
}

public class ServiceTest {

    @Test
    void testServiceWithMockRepository() {

        // Create Mock Repository
        Repository mockRepository = mock(Repository.class);

        // Stub Method
        when(mockRepository.getData()).thenReturn("Mock Data");

        // Create Service
        Service service = new Service(mockRepository);

        // Call Method
        String result = service.processData();

        // Verify Result
        assertEquals("Processed Mock Data", result);

        // Verify Interaction
        verify(mockRepository).getData();
    }
}