package sunday.pojo.student;

/**
 * Created by 花间一壶酒 on 2017/6/1.
 */
public final class StudentInfo{
    private Integer studentId;
    private String oldPassword;
    private String newPassword;
    private String gender;
    private String cellphone;
    private String email;

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
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
        return "StudentInfo{" +
                "studentId='" + studentId + '\'' +
                ", oldPassword='" + oldPassword + '\'' +
                ", newPassword='" + newPassword + '\'' +
                ", gender='" + gender + '\'' +
                ", cellphone='" + cellphone + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
