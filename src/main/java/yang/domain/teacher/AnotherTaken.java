package yang.domain.teacher;

/**
 * 学生附加题类
 * Created by yang on 2017/6/7.
 * At 15:15
 */
public final class AnotherTaken {
    //附加题标号
    private long id;
    //课程信息
    private Integer courseId;
    private String courseName;
    //专业信息
    private Integer specialtyId;
    private String specialtyName;
    //学生信息
    private Integer studentId;
    private String studentName;
    //附加题内容
    private String content;
    //标准答案
    private String result;
    //学生回答
    private String studentAnswer;
    //成绩
    private int score;

    @Override
    public String toString() {
        return "AnotherTaken{" +
                "id=" + id +
                ", courseId=" + courseId +
                ", courseName='" + courseName + '\'' +
                ", specialtyId=" + specialtyId +
                ", specialtyName='" + specialtyName + '\'' +
                ", studentId=" + studentId +
                ", studentName='" + studentName + '\'' +
                ", content='" + content + '\'' +
                ", result='" + result + '\'' +
                ", studentAnswer='" + studentAnswer + '\'' +
                ", score=" + score +
                '}';
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public Integer getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(Integer specialtyId) {
        this.specialtyId = specialtyId;
    }

    public String getSpecialtyName() {
        return specialtyName;
    }

    public void setSpecialtyName(String specialtyName) {
        this.specialtyName = specialtyName;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getStudentAnswer() {
        return studentAnswer;
    }

    public void setStudentAnswer(String studentAnswer) {
        this.studentAnswer = studentAnswer;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }
}
