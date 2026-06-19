interface Image
{
    public void display(String ImageId);
}

class Realimage implements Image
{
    private String ImageId;
    
    public Realimage(String ImageId)
    {
        this.ImageId = ImageId;
        loadfromserver();
    }
    
    public void loadfromserver()
    {
        System.out.println("Loading from server: "+ImageId);
    }
    
    @Override
    public void display(String ImageId)
    {
        System.out.println("Viewing image : "+ ImageId);
    }
}

class ProxyImage implements Image
{
    private Realimage real;
    private String ImageId;
    
    public ProxyImage(String ImageId)
    {
        this.ImageId = ImageId;
    }
    
    @Override
    public void display(String ImageId)
    {
        if(real==null)
        {
            real = new Realimage(ImageId);
        }
        else
        {
            System.out.println("Error while retrieving image "+ImageId);
        }
        real.display(ImageId);
    }
}

class Main
{
    public static void main(String[] args)
    {
        Image image = new ProxyImage("mp4");
        image.display("mp4");
    }
}