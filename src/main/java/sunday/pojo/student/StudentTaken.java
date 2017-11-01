package sunday.pojo.student;

import java.io.Serializable;

/**
 *
 * Created by 花间一壶酒 on 2017/5/31.
 */
public final class StudentTaken implements Serializable{
    private Integer studentId;
    private String password;
    private String name;
    private Integer specialtyId;
    private String specialtyName;
    private String gender;
    private String cellphone;
    private String email;

    public Integer getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(Integer specialtyId) {
        this.specialtyId = specialtyId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecialtyName() {
        return specialtyName;
    }

    public void setSpecialtyName(String specialtyName) {
        this.specialtyName = specialtyName;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    @Override
    public String toString() {
        return "StudentTaken{" +
                "studentId=" + studentId +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", specialtyId=" + specialtyId +
                ", specialtyName='" + specialtyName + '\'' +
                ", gender='" + gender + '\'' +
                ", cellphone='" + cellphone + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
