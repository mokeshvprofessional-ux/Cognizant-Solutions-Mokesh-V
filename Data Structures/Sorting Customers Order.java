class Order {
    private int orderId;
    private String customerName;
    private double totalPrice;

    public Order(int orderId, String customerName, double totalPrice) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.totalPrice = totalPrice;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    @Override
    public String toString() {
        return "ID: " + orderId + " | Customer: " + customerName + " | Total: $" + totalPrice;
    }
}

class OrderSorter {

    public static void bubbleSort(Order[] orders) {
        int n = orders.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (orders[j].getTotalPrice() > orders[j + 1].getTotalPrice()) {
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                }
            }
        }
    }

    public static void quickSort(Order[] orders, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(orders, low, high);
            quickSort(orders, low, pivotIndex - 1);
            quickSort(orders, pivotIndex + 1, high);
        }
    }

    private static int partition(Order[] orders, int low, int high) {
        double pivot = orders[high].getTotalPrice();
        int i = (low - 1);

        for (int j = low; j < high; j++) {
            if (orders[j].getTotalPrice() <= pivot) {
                i++;
                Order temp = orders[i];
                orders[i] = orders[j];
                orders[j] = temp;
            }
        }

        Order temp = orders[i + 1];
        orders[i + 1] = orders[high];
        orders[high] = temp;

        return i + 1;
    }
}

public class Main {
    public static void main(String[] args) {
        Order[] ordersForBubble = {
            new Order(101, "Alice", 250.50),
            new Order(102, "Bob", 89.99),
            new Order(103, "Charlie", 450.00),
            new Order(104, "David", 120.75)
        };

        Order[] ordersForQuick = {
            new Order(101, "Alice", 250.50),
            new Order(102, "Bob", 89.99),
            new Order(103, "Charlie", 450.00),
            new Order(104, "David", 120.75)
        };

        System.out.println("--- TESTING BUBBLE SORT ---");
        OrderSorter.bubbleSort(ordersForBubble);
        for (Order o : ordersForBubble) {
            System.out.println(o);
        }

        System.out.println("\n--- TESTING QUICK SORT ---");
        OrderSorter.quickSort(ordersForQuick, 0, ordersForQuick.length - 1);
        for (Order o : ordersForQuick) {
            System.out.println(o);
        }
    }
}