interface PaymentProcessor
{
    public void ProcessPayment(double amount);
}

class Advancedpay
{
    public void paymentconverter(int cents)
    {
        System.out.println("Amount converted to "+cents+" Cents");
    }
}

class adapter implements PaymentProcessor
{
    private Advancedpay advancedpayinstance;
    
    public adapter(Advancedpay advancedpayinstance)
    {
        this.advancedpayinstance = advancedpayinstance;
    }
    
    public void ProcessPayment(double amount)
    {
        int cents = (int)(amount*100);
        System.out.println("Converting amount to Cents");
        advancedpayinstance.paymentconverter(cents);
    }
}

class Main
{
    public static void main(String[] args)
    {
        Advancedpay external = new Advancedpay();
        PaymentProcessor con = new adapter(external);
        con.ProcessPayment(40.00);
    }
}