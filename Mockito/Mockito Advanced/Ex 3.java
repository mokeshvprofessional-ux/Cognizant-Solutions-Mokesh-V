import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.Test;

// File Reader Interface
interface FileReader {
    String read();
}

// File Writer Interface
interface FileWriter {
    void write(String data);
}

// File Service Class
class FileService {

    private FileReader fileReader;
    private FileWriter fileWriter;

    public FileService(FileReader fileReader, FileWriter fileWriter) {
        this.fileReader = fileReader;
        this.fileWriter = fileWriter;
    }

    public String processFile() {

        String content = fileReader.read();

        fileWriter.write("Processed " + content);

        return "Processed " + content;
    }
}

// Test Class
public class FileServiceTest {

    @Test
    public void testServiceWithMockFileIO() {

        // Create Mock Objects
        FileReader mockFileReader = mock(FileReader.class);
        FileWriter mockFileWriter = mock(FileWriter.class);

        // Stub File Reader
        when(mockFileReader.read()).thenReturn("Mock File Content");

        // Create Service
        FileService fileService = new FileService(mockFileReader, mockFileWriter);

        // Call Method
        String result = fileService.processFile();

        // Verify Result
        assertEquals("Processed Mock File Content", result);

        // Verify Interactions
        verify(mockFileReader).read();
        verify(mockFileWriter).write("Processed Mock File Content");
    }
}