package sunday.pojo.student;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * 成绩类
 * Created by yang on 2017/5/27.
 * At 18:47
 */
public final class GradeTaken {
    private Integer studentId;
    private String studentName;
    private String specialtyId;
    private String specialtyName;
    private String courseName;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date startTime;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endTime;
    private Integer grade1;
    private Integer grade2;
    private Integer grade3;
    private Integer grade4;
    private Integer total;

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


    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public Integer getGrade1() {
        return grade1;
    }

    public void setGrade1(Integer grade1) {
        this.grade1 = grade1;
    }

    public Integer getGrade2() {
        return grade2;
    }

    public void setGrade2(Integer grade2) {
        this.grade2 = grade2;
    }

    public Integer getGrade3() {
        return grade3;
    }

    public void setGrade3(Integer grade3) {
        this.grade3 = grade3;
    }

    public Integer getGrade4() {
        return grade4;
    }

    public void setGrade4(Integer grade4) {
        this.grade4 = grade4;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "GradeTaken{" +
                "studentId='" + studentId + '\'' +
                ", studentName='" + studentName + '\'' +
                ", specialtyId='" + specialtyId + '\'' +
                ", specialtyName='" + specialtyName + '\'' +
                ", courseName='" + courseName + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", grade1=" + grade1 +
                ", grade2=" + grade2 +
                ", grade3=" + grade3 +
                ", grade4=" + grade4 +
                ", total=" + total +
                '}';
    }
}
