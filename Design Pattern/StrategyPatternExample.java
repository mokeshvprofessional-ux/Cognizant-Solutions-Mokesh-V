interface PaymentStrategy
{
    public void pay(double amount);
}

class CreditCardPayment implements PaymentStrategy
{
    private String cardno;
    
    public CreditCardPayment(String cardno)
    {
        this.cardno = cardno;
    }
    
    @Override 
    public void pay(double amount)
    {
        System.out.println("Paid the amount "+amount+" with card number : "+cardno);
    }
}

class PayPalPayment implements PaymentStrategy
{
    private String email;
    
    public PayPalPayment(String email)
    {
        this.email = email;
    }
    
    @Override
    public void pay(double amount)
    {
        System.out.println("Paying the amount through "+email+" PayPal account");    
    }
}

class PaymentContext
{
    private PaymentStrategy strategy;
    
    public void setPaymentContext(PaymentStrategy strategy)
    {
        this.strategy = strategy;
    }
    
    public void execute(double amount)
    {
        strategy.pay(amount);
    }
}

class Main
{
    public static void main(String[] args)
    {
        PaymentContext paid = new PaymentContext();
        
        paid.setPaymentContext(new CreditCardPayment(
            "1111-2222-3333"));
        paid.execute(20000.00);
    }
}