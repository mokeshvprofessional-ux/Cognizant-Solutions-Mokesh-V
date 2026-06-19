class Book
{
    private int bookid;
    private String title;
    private String author;
    
    public Book(int bookid, String title, String author)
    {
        this.bookid = bookid;
        this.title = title;
        this.author = author;
    }
    
    public int getBookId()
    {
        return bookid;
    }
    
    public String getTitle()
    {
        return title;
    }
    
    public String getAuthor()
    {
        return author;
    }
}

class SearchEngine
{
    public static Book LinearSearch(Book[] book, int target)
    {
        for(int i = 0; i<book.length; i++)
        {
            if(book[i].getBookId() == target)
            {
                return book[i];
            }
        }
        return null;
    }
    
    public static Book BinarySearch(Book[] book, int target)
    {
        int low = 0;
        int high = book.length - 1;
        
        while(low<=high)
        {
            int mid = low + (high-low)/2;
            int midid = book[mid].getBookId();
            
            if(midid == target)
            {
                return book[mid];
            }
            else if(midid < target)
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
        Book[] unsorted = {
            new Book(101, "DSP", "Mokesh"),
            new Book(113, "Java", "Karl"),
            new Book(165, "SQL", "Marx")
        };
        
        Book[] sorted = {
            new Book(101, "DSP", "Mokesh"),
            new Book(102, "Java", "Karl")
        };
        
        Book res1 = SearchEngine.LinearSearch(unsorted, 11);
        if(res1 == null)
        {
            System.out.println("Book not Found");
        }
        else
        {
            System.out.println("Book Found");
        }
        
        Book res2 = SearchEngine.BinarySearch(sorted, 111);
        if(res2==null)
        {
            System.out.println("Book not found");
        }
        else
        {
            System.out.println("Book Found");
        }
    }
}