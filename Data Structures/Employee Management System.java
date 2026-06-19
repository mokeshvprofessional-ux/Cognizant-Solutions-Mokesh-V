class Employee
{
    private int employeeid;
    private String name;
    private String position;
    private double salary;
    
    public Employee(int empid, String name, String position, double amount)
    {
        this.employeeid = empid;
        this.name = name;
        this.position = position;
        this.salary = amount;
    }
    
    public int getEmployeeId()
    {
        return employeeid;
    }
    
    public String getName()
    {
        return name;
    }
    
    public String getPosition()
    {
        return position;
    }
    
    public double getSalary()
    {
        return salary;
    }
    
    @Override
    public String toString()
    {
        return "Employee ID: "+employeeid + " Name: "+name+" Position: "+position+" Salary: "+salary;
    }
}

class Employeemanager
{
    private Employee[] employees;
    private int count;
    
    public Employeemanager(int capacity)
    {
        employees = new Employee[capacity];
        count = 0;
    }
    
    public void add(Employee employee)
    {
        if(count>=employees.length)
        {
            System.out.println("Employee cannot be added");
            return;
        }
        employees[count] = employee;
        count++;
        System.out.println("Employee added : "+employee.getEmployeeId());
    }
    
    public Employee search(int empid)
    {
        for(int i = 0; i<count; i++)
        {
            if(employees[i].getEmployeeId() == empid)
            {
                return employees[i];
            }
        }
        return null;
    }
    
    public void traverse()
    {
        if(count==0) 
        {
            System.out.println("No Records found");
            return;
        }
        else
        {
            for(int i = 0; i<count; i++)
            {
                System.out.println(employees[i]);
            }
        }
    }
    
    public void delete(int empid)
    {
        int index = -1;
        for(int i = 0; i<count; i++)
        {
            if(employees[i].getEmployeeId() == empid)
            {
                index = i;
                break;
            }
        }
        
        if(index==-1)
        {
            System.out.println("No employee found in this ID: "+ empid);
            return;
        }
        
        for(int j = index; j<count-1; j++)
        {
            employees[j] = employees[j+1];
        }
        
        employees[count-1] = null;
        count--;
        System.out.println("Employee ID deleted successfully.");
    }
}

public class Main
{
    public static void main(String[] args)
    {
        Employeemanager manager = new Employeemanager(5);
        
        manager.add(new Employee(1, "Mokesh", "Senior Manager", 100000.00));
        manager.add(new Employee(2, "Max", "Assistant Manager", 80000.00));
        
        manager.traverse();
        
        Employee found = manager.search(2);
        if(found==null)
        {
            System.out.println("Employee not found");
        }
        else
        {
            System.out.println("Employee found: "+found);
        }
        
        manager.delete(2);
        manager.traverse();
    }
}