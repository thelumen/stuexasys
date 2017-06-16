package sunday.pojo.teacher;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * 考试信息类
 * Created by yang on 2017/6/2.
 * At 8:32
 */
public final class ExamTaken {
    private int id;

    private Integer courseId;
    private String courseName;

    private Integer specialtyId;
    private String specialtyName;
    //测验一
    private String content1;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date date1;
    private int sign1;
    //测验二
    private String content2;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date date2;
    private int sign2;
    //测验三
    private String content3;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date date3;
    private int sign3;
    //测验四
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date date4;
    private int sign4;
    //是否可以开始考试
    private int test;
    //是否有考试信息
    private int started;

    @Override
    public String toString() {
        return "ExamTaken{" +
                "id=" + id +
                ", courseId=" + courseId +
                ", courseName='" + courseName + '\'' +
                ", specialtyId=" + specialtyId +
                ", specialtyName='" + specialtyName + '\'' +
                ", content1='" + content1 + '\'' +
                ", date1=" + date1 +
                ", sign1=" + sign1 +
                ", content2='" + content2 + '\'' +
                ", date2=" + date2 +
                ", sign2=" + sign2 +
                ", content3='" + content3 + '\'' +
                ", date3=" + date3 +
                ", sign3=" + sign3 +
                ", date4=" + date4 +
                ", sign4=" + sign4 +
                ", test=" + test +
                ", started=" + started +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
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

    public String getContent1() {
        return content1;
    }

    public void setContent1(String content1) {
        this.content1 = content1;
    }

    public Date getDate1() {
        return date1;
    }

    public void setDate1(Date date1) {
        this.date1 = date1;
    }

    public int getSign1() {
        return sign1;
    }

    public void setSign1(int sign1) {
        this.sign1 = sign1;
    }

    public String getContent2() {
        return content2;
    }

    public void setContent2(String content2) {
        this.content2 = content2;
    }

    public Date getDate2() {
        return date2;
    }

    public void setDate2(Date date2) {
        this.date2 = date2;
    }

    public int getSign2() {
        return sign2;
    }

    public void setSign2(int sign2) {
        this.sign2 = sign2;
    }

    public String getContent3() {
        return content3;
    }

    public void setContent3(String content3) {
        this.content3 = content3;
    }

    public Date getDate3() {
        return date3;
    }

    public void setDate3(Date date3) {
        this.date3 = date3;
    }

    public int getSign3() {
        return sign3;
    }

    public void setSign3(int sign3) {
        this.sign3 = sign3;
    }

    public Date getDate4() {
        return date4;
    }

    public void setDate4(Date date4) {
        this.date4 = date4;
    }

    public int getSign4() {
        return sign4;
    }

    public void setSign4(int sign4) {
        this.sign4 = sign4;
    }

    public int getTest() {
        return test;
    }

    public void setTest(int test) {
        this.test = test;
    }

    public int getStarted() {
        return started;
    }

    public void setStarted(int started) {
        this.started = started;
    }
}
