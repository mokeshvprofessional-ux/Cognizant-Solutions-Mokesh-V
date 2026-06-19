import java.util.*;
import java.util.HashMap;

class Product
{
    private int productId;
    private String productName;
    private int quantity;
    private int price;
    
    
    public Product(int productId, String productName, int quantity, int price)
    {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
    }
    
    public int getProductId()
    {
        return productId;
    }
    
    public String getProductName()
    {
        return productName;
    }
    
    public int getQuantity()
    {
        return quantity;
    }
    
    public int getPrice()
    {
        return price;
    }
    
    public void setQuantity(int quantity)
    {
        this.quantity = quantity;
    }
    
    public void setPrice(int price)
    {
        this.price = price;
    }
    
    public void display()
    {
        System.out.println("ID: "+productId);
        System.out.println("Name: "+productName);
        System.out.println("Quantity: "+quantity);
        System.out.println("Price: "+price);
        System.out.println();
    }
}

class Inventory
{
    private final HashMap<Integer, Product> inventory = new HashMap<>();
    
    public void addProduct(Product product)
    {
        if(inventory.containsKey(product.getProductId()))
        {
            System.out.println("There is already a product available. -> "+ product.getProductName());
        }
        else
        {
            inventory.put(product.getProductId(), product);
            System.out.println("Product added");
        }
    }
    
    public void updateProduct(int productId, int newPrice, int newQuantity)
    {
        Product product = inventory.get(productId);
        
        if(product!=null)
        {
            product.setQuantity(newQuantity);
            product.setPrice(newPrice);
            System.out.println("Product updated : "+product.getProductId());
        }
        else
        {
            System.out.println("Error!!! We cannot able to update the product");
        }
    }
    
    public void deleteProduct(int productId)
    {
        Product product = inventory.get(productId);
        if(product!=null)
        {
            inventory.remove(productId);
            System.out.println("Product removed");
        }
        else
        {
            System.out.println("Cannot able to find the product to delete the item");
        }
    }
    
    public void displaywarehouse()
    {
        if(inventory.isEmpty())
        {
            System.out.println("WareHouse is Empty");
        }
        else
        {
            for(Product p : inventory.values())
            {
                p.display();
            }
        }
    }
}

class Main
{
    public static void main(String[] args)
    {
        Inventory warehouse = new Inventory();
        
        Product prod1 = new Product(001, "Gaming Laptop", 15, 1200);
        Product prod2 = new Product(002, "Wireless Mouse", 150, 25);
        Product prod3 = new Product(003, "Mechanical Keyboard", 45, 89);
        
        warehouse.addProduct(prod1);
        warehouse.addProduct(prod2);
        warehouse.addProduct(prod3);
        
        warehouse.displaywarehouse();
        
        warehouse.updateProduct(001, 20, 2000);
        
        warehouse.deleteProduct(003);
        
        warehouse.displaywarehouse();
    }
}