class StudentModel {
    private String studentId;
    private String studentName;

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
}

class StudentView {
    public void displayStudentDetails(String name, String id) {
        System.out.println("=== STUDENT PROFILE DASHBOARD ===");
        System.out.println("Identification Number: " + id);
        System.out.println("Enrolled Full Name    : " + name);
        System.out.println("=================================\n");
    }
}

class StudentController {
    private StudentModel model;
    private StudentView view;

    public StudentController(StudentModel model, StudentView view) {
        this.model = model;
        this.view = view;
    }

    public void setStudentName(String name) {
        model.setStudentName(name);
    }

    public String getStudentName() {
        return model.getStudentName();
    }

    public void setStudentId(String id) {
        model.setStudentId(id);
    }

    public String getStudentId() {
        return model.getStudentId();
    }

    public void updateView() {
        view.displayStudentDetails(model.getStudentName(), model.getStudentId());
    }
}

public class Main {
    public static void main(String[] args) {
        StudentModel model = new StudentModel();
        model.setStudentName("John Doe");
        model.setStudentId("STU-98765");

        StudentView view = new StudentView();

        StudentController controller = new StudentController(model, view);

        controller.updateView();

        controller.setStudentName("Jane Smith");
        controller.updateView();
    }
}