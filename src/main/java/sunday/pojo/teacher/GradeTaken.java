package sunday.pojo.teacher;

/**
 * 成绩类
 * Created by yang on 2017/5/27.
 * At 18:47
 */
public final class GradeTaken {
    private String studentId;
    private String studentName;
    private String specialtyId;
    private String specialtyName;
    private String courseName;
    private byte grade1;
    private byte grade2;
    private byte grade3;
    private byte grade4;
    private byte total;

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

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(String specialtyId) {
        this.specialtyId = specialtyId;
    }

    public String getSpecialtyName() {
        return specialtyName;
    }

    public void setSpecialtyName(String specialtyName) {
        this.specialtyName = specialtyName;
    }

    public byte getGrade1() {
        return grade1;
    }

    public void setGrade1(byte grade1) {
        this.grade1 = grade1;
    }

    public byte getGrade2() {
        return grade2;
    }

    public void setGrade2(byte grade2) {
        this.grade2 = grade2;
    }

    public byte getGrade3() {
        return grade3;
    }

    public void setGrade3(byte grade3) {
        this.grade3 = grade3;
    }

    public byte getGrade4() {
        return grade4;
    }

    public void setGrade4(byte grade4) {
        this.grade4 = grade4;
    }

    public byte getTotal() {
        return total;
    }

    public void setTotal(byte total) {
        this.total = total;
    }
}
