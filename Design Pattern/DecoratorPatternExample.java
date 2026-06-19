interface Notifier
{
    String send();
}

class EmailNotifier implements Notifier
{
    @Override
    public String send()
    {
        return "Sent message through Email";
    }
}

abstract class NotifierDecorator implements Notifier
{
    protected Notifier decoratedNotifier;
    
    public NotifierDecorator(Notifier notifier)
    {
        this.decoratedNotifier = notifier;
    }
    
    @Override
    public String send()
    {
        return decoratedNotifier.send();
    }
}

class SMSNotifierDecorator extends NotifierDecorator
{
    public SMSNotifierDecorator(Notifier notifier)
    {
        super(notifier);
    }
    
    @Override
    public String send()
    {
        return super.send()+", SMS";
    }
}

class SlackNotifierDecorator extends NotifierDecorator
{
    public SlackNotifierDecorator(Notifier notifier)
    {
        super(notifier);
    }
    
    @Override
    public String send()
    {
        return super.send()+" and Slack";
    }
}

class Main
{
    public static void main(String[] args) 
    {
        Notifier notification = new EmailNotifier();
        System.out.println(notification.send());
        
        notification = new SMSNotifierDecorator(notification);
        System.out.println(notification.send());
        
        notification = new SlackNotifierDecorator(notification);
        System.out.println(notification.send());
        
    }
}