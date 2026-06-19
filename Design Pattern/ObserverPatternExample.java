import java.util.ArrayList;
import java.util.List;

interface Observer
{
    public void update(String stockname, double price);
}

interface Stock
{
    public void register(Observer observer);
    public void deregister(Observer observer);
    public void notifyObservers();
}

class StockMarket implements Stock
{
    private final List<Observer> observers = new ArrayList<>();
    private String stockname;
    private double price;
    
    @Override
    public void register(Observer observer)
    {
        observers.add(observer);
        System.out.println("New User added");
    }
    
    @Override
    public void deregister(Observer observer)
    {
        observers.remove(observer);
        System.out.println("User removed");
    }
    
    @Override
    public void notifyObservers()
    {
        for(Observer ob : observers)
        {
            ob.update(stockname, price);
        }
    }
    
    public void setstockprice(String stockname, double price)
    {
        this.stockname = stockname;
        this.price = price;
        notifyObservers();
    }
}

class Mobileapp implements Observer
{
    private final String name;
    
    public Mobileapp(String name)
    {
        this.name = name;
    }
    
    public void update(String stockname, double price)
    {
        System.out.println(name+" - "+ stockname+" -> "+price);
    }
}

class WebApp implements Observer
{
    private final String url;
    
    public WebApp(String url)
    {
        this.url = url;
    }
    
    public void update(String stockname, double price)
    {
        System.out.println(stockname + " -> "+ price + " is updated on your web app!!");
    }
}

public class Main {
    public static void main(String[] args) {
        StockMarket nasdaq = new StockMarket();

        Observer client1 = new Mobileapp("PremiumUser");
        Observer client2 = new WebApp("portal.nasdaq.com");

        nasdaq.register(client1);
        nasdaq.register(client2);

        nasdaq.setstockprice("AAPL", 185.50);
        nasdaq.setstockprice("GOOGL", 172.30);

        nasdaq.deregister(client2);

        nasdaq.setstockprice("TSLA", 220.15);
    }
}
