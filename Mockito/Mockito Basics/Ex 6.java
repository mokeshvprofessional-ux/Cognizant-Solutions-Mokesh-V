import static org.mockito.Mockito.*;

import org.junit.jupiter.api.Test;
import org.mockito.InOrder;

public interface ExternalApi {

    void login();

    void fetchData();

    void logout();

}

public class MyService {

    private ExternalApi externalApi;

    public MyService(ExternalApi externalApi) {
        this.externalApi = externalApi;
    }

    public void executeProcess() {

        externalApi.login();
        externalApi.fetchData();
        externalApi.logout();

    }
}

public class MyServiceTest {

    @Test
    void testInteractionOrder() {

        // Create Mock Object
        ExternalApi mockApi = mock(ExternalApi.class);

        // Create Service
        MyService service = new MyService(mockApi);

        // Call Method
        service.executeProcess();

        // Verify Interaction Order
        InOrder inOrder = inOrder(mockApi);

        inOrder.verify(mockApi).login();
        inOrder.verify(mockApi).fetchData();
        inOrder.verify(mockApi).logout();
    }
}