import static org.mockito.Mockito.*;

import org.junit.jupiter.api.Test;

public interface ExternalApi {

    void sendData(String data);

}

public class MyService {

    private ExternalApi externalApi;

    public MyService(ExternalApi externalApi) {
        this.externalApi = externalApi;
    }

    public void processData(String data) {
        externalApi.sendData(data);
    }
}

public class MyServiceTest {

    @Test
    void testVoidMethod() {

        // Create Mock Object
        ExternalApi mockApi = mock(ExternalApi.class);

        // Stub Void Method
        doNothing().when(mockApi).sendData("Hello");

        // Create Service
        MyService service = new MyService(mockApi);

        // Call Method
        service.processData("Hello");

        // Verify Interaction
        verify(mockApi).sendData("Hello");
    }
}