import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.Test;

// REST Client Interface
interface RestClient {
    String getResponse();
}

// Service Class
class ApiService {

    private RestClient restClient;

    public ApiService(RestClient restClient) {
        this.restClient = restClient;
    }

    public String fetchData() {
        return "Fetched " + restClient.getResponse();
    }
}

// Test Class
public class ApiServiceTest {

    @Test
    public void testServiceWithMockRestClient() {

        // Create Mock REST Client
        RestClient mockRestClient = mock(RestClient.class);

        // Stub Method
        when(mockRestClient.getResponse()).thenReturn("Mock Response");

        // Create Service
        ApiService apiService = new ApiService(mockRestClient);

        // Call Method
        String result = apiService.fetchData();

        // Verify Result
        assertEquals("Fetched Mock Response", result);

        // Verify Interaction
        verify(mockRestClient).getResponse();
    }
}