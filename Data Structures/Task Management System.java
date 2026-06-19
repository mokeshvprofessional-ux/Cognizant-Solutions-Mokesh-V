class Task {
    private int taskId;
    private String taskName;
    private String status;

    public Task(int taskId, String taskName, String status) {
        this.taskId = taskId;
        this.taskName = taskName;
        this.status = status;
    }

    public int getTaskId() {
        return taskId;
    }

    @Override
    public String toString() {
        return "Task ID: " + taskId + " | Name: " + taskName + " | Status: " + status;
    }
}

class Node {
    Task task;
    Node next;

    public Node(Task task) {
        this.task = task;
        this.next = null;
    }
}

class TaskLinkedList {
    private Node head;

    public void add(Task task) {
        Node newNode = new Node(task);
        if (head == null) {
            head = newNode;
        } else {
            Node current = head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }
        System.out.println("Task added successfully: " + task.getTaskId());
    }

    public Task search(int taskId) {
        Node current = head;
        while (current != null) {
            if (current.task.getTaskId() == taskId) {
                return current.task;
            }
            current = current.next;
        }
        return null;
    }

    public void traverse() {
        System.out.println("\n--- CURRENT TASK LIST ---");
        if (head == null) {
            System.out.println("No tasks inside the system.");
            return;
        }
        Node current = head;
        while (current != null) {
            System.out.println(current.task);
            current = current.next;
        }
        System.out.println("-------------------------");
    }

    public void delete(int taskId) {
        if (head == null) {
            System.out.println("Error: Task list is empty.");
            return;
        }

        if (head.task.getTaskId() == taskId) {
            head = head.next;
            System.out.println("Task ID " + taskId + " deleted successfully.");
            return;
        }

        Node current = head;
        Node previous = null;

        while (current != null && current.task.getTaskId() != taskId) {
            previous = current;
            current = current.next;
        }

        if (current == null) {
            System.out.println("Error: Task ID " + taskId + " not found.");
            return;
        }

        previous.next = current.next;
        System.out.println("Task ID " + taskId + " deleted successfully.");
    }
}

public class Main {
    public static void main(String[] args) {
        TaskLinkedList taskList = new TaskLinkedList();

        taskList.add(new Task(101, "Database Migration", "Pending"));
        taskList.add(new Task(102, "API Implementation", "In Progress"));
        taskList.add(new Task(103, "Unit Testing", "Pending"));

        taskList.traverse();

        Task searched = taskList.search(102);
        if (searched != null) {
            System.out.println("\nTask Found -> " + searched);
        } else {
            System.out.println("\nTask not found.");
        }

        System.out.println();
        taskList.delete(102);

        taskList.traverse();
    }
}