class Product
{
    private int productId;
    private String productName;
    private String category;
    
    public Product(int productId, String productName, String category)
    {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }
    
    public int getProductId()
    {
        return productId;
    }
    
    public String getProductName()
    {
        return productName;
    }
    
    public String getCategory()
    {
        return category;
    }
}

class Search
{
    public static Product LinearSearch(Product[] product, int searchid)
    {
        for(int i = 0; i<product.length; i++)
        {
            if(product[i].getProductId() == searchid)
                return product[i];
        }
        return null;
    }
    
    public static Product BinarySearch(Product[] product, int searchid)
    {
        int low = 0;
        int high = product.length - 1;
        
        while(low<=high)
        {
            int mid = low + (high-low)/2;
            int midid = product[mid].getProductId();
            
            if(midid == searchid)
            {
                return product[mid];
            }
            
            else if(midid < searchid)
            {
                low = mid+1;
            }
            
            else
            {
                high = mid-1;
            }
        }
        
        return null;
    }
}

class Main
{
    public static void main(String[] args)
    {
        Product[] unsortedInventory = {
            new Product(305, "Wireless Mouse", "Electronics"),
            new Product(101, "Gaming Laptop", "Electronics"),
            new Product(404, "Running Shoes", "Apparel"),
            new Product(202, "Coffee Maker", "Appliances")
        };

        Product[] sortedInventory = {
            new Product(101, "Gaming Laptop", "Electronics"),
            new Product(202, "Coffee Maker", "Appliances"),
            new Product(305, "Wireless Mouse", "Electronics"),
            new Product(404, "Running Shoes", "Apparel")
        };
        
        Product result1 = Search.LinearSearch(unsortedInventory, 203);
        if(result1!=null)
        {
            System.out.println("Product found");
        }
        else
        {
            System.out.println("Product not found");
        }
        
        Product result2 = Search.BinarySearch(sortedInventory, 404);
        if(result2!=null)
        {
            System.out.println("Product found");
        }
        else
        {
            System.out.println("Product found");
        }
    }
}