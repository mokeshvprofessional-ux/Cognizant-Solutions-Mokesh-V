import java.util.*;

class Logger
{
    private static Logger instance;
    
    private Logger()
    {
        System.out.println("User Logged In");
    }
    
    public static Logger getInstance()
    {
        if(instance==null)
        {
            instance = new Logger();
        }
        return instance;
    }
}

public class Main
{
    public static void main(String[] args)
    {
        Logger log1 = Logger.getInstance();
        Logger log2 = Logger.getInstance();
    }
}