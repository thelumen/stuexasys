package sunday.pojo.student;

/**
 * Created by 花间一壶酒 on 2017/6/17.
 */
public class GradeInfo {
    private Long Id;
    private Integer studentId;
    private Integer courseId;
    private Integer grade;
    private Integer grade1;
    private Integer grade2;
    private Integer grade3;
    private Integer grade4;
    private String testNum;
    private String result;

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

    public Long getId() {
        return Id;
    }

    public void setId(Long id) {
        Id = id;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    public String getTestNum() {
        return testNum;
    }

    public void setTestNum(String testNum) {
        this.testNum = testNum;
    }
}
