package yang.domain.school;

import java.io.Serializable;

/**
 * Created by yang on 2017/5/22.
 * At 19:06
 */
public final class Student implements Serializable{
    //自增
    private long id;
    private Integer studentId;
    private String password;
    private String name;
    private Integer specialtyId;
    private String gender;
    private String cellphone;
    private String email;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Student student = (Student) o;

        if (id != student.id) return false;
        if (studentId != null ? !studentId.equals(student.studentId) : student.studentId != null) return false;
        if (password != null ? !password.equals(student.password) : student.password != null) return false;
        if (name != null ? !name.equals(student.name) : student.name != null) return false;
        if (specialtyId != null ? !specialtyId.equals(student.specialtyId) : student.specialtyId != null) return false;
        if (gender != null ? !gender.equals(student.gender) : student.gender != null) return false;
        if (cellphone != null ? !cellphone.equals(student.cellphone) : student.cellphone != null) return false;
        return email != null ? email.equals(student.email) : student.email == null;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (studentId != null ? studentId.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (specialtyId != null ? specialtyId.hashCode() : 0);
        result = 31 * result + (gender != null ? gender.hashCode() : 0);
        result = 31 * result + (cellphone != null ? cellphone.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        return result;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public long getId() {
        return id;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
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

    public Integer getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(Integer specialtyId) {
        this.specialtyId = specialtyId;
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

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", studentId='" + studentId + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", specialtyId='" + specialtyId + '\'' +
                ", gender='" + gender + '\'' +
                ", cellphone='" + cellphone + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
