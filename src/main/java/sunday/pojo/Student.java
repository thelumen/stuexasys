package sunday.pojo;

/**
 * Created by yang on 2017/5/22.
 * At 19:06
 */
public final class Student {
    //自增
    private long id;
    private final String studentId;
    private final String password;
    private String name;
    private final String specialtyId;
    private String gender;
    private String cellphone;

    public Student(String studentId, String password, String specialtyId) {
        this.studentId = studentId;
        this.password = password;
        this.specialtyId = specialtyId;
    }

    public String getStudentId() {
        return studentId;
    }

    public String getPassword() {
        return password;
    }

    public String getSpecialtyId() {
        return specialtyId;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getCellphone() {
        return cellphone;
    }

    public void setCellphone(String cellphone) {
        this.cellphone = cellphone;
    }
}
