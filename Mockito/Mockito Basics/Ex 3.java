import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.Test;

public interface ExternalApi {

    String getData(String input);

}

public class MyService {

    private ExternalApi externalApi;

    public MyService(ExternalApi externalApi) {
        this.externalApi = externalApi;
    }

    public String fetchData(String input) {
        return externalApi.getData(input);
    }
}

public class MyServiceTest {

    @Test
    void testArgumentMatching() {

        // Create Mock Object
        ExternalApi mockApi = mock(ExternalApi.class);

        // Stub Method
        when(mockApi.getData(anyString())).thenReturn("Mock Data");

        // Create Service
        MyService service = new MyService(mockApi);

        // Call Method
        String result = service.fetchData("Hello");

        // Verify Result
        assertEquals("Mock Data", result);

        // Verify Interaction with Argument Matcher
        verify(mockApi).getData(anyString());
    }
}