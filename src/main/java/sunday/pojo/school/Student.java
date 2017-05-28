package sunday.pojo.school;

/**
 * Created by yang on 2017/5/22.
 * At 19:06
 */
public final class Student {
    //自增
    private long id;
    private String studentId;
    private String password;
    private String name;
    private String specialtyId;
    private String gender;
    private String cellphone;

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setSpecialtyId(String specialtyId) {
        this.specialtyId = specialtyId;
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
