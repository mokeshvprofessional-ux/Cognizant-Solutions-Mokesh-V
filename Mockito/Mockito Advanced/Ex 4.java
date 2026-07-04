import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.Test;

// Network Client Interface
interface NetworkClient {
    String connect();
}

// Network Service Class
class NetworkService {

    private NetworkClient networkClient;

    public NetworkService(NetworkClient networkClient) {
        this.networkClient = networkClient;
    }

    public String connectToServer() {
        return "Connected to " + networkClient.connect();
    }
}

// Test Class
public class NetworkServiceTest {

    @Test
    public void testServiceWithMockNetworkClient() {

        // Create Mock Network Client
        NetworkClient mockNetworkClient = mock(NetworkClient.class);

        // Stub Method
        when(mockNetworkClient.connect()).thenReturn("Mock Connection");

        // Create Service
        NetworkService networkService = new NetworkService(mockNetworkClient);

        // Call Method
        String result = networkService.connectToServer();

        // Verify Result
        assertEquals("Connected to Mock Connection", result);

        // Verify Interaction
        verify(mockNetworkClient).connect();
    }
}