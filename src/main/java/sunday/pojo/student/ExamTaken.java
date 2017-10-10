package sunday.pojo.student;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * Created by 花间一壶酒 on 2017/6/3.
 */
public final class ExamTaken {
    private Integer courseId;
    private String courseName;
    //测验一
    private String content1;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date date1;
    private Integer sign1;
    //测验二
    private String content2;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date date2;
    private Integer sign2;
    //测验三
    private String content3;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date date3;
    private Integer sign3;
    //测验四
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date date4;
    private Integer sign4;
    //是否可以开始考试
    private int test;
    //是否有考试信息
    private Integer started;

    @Override
    public String toString() {
        return "ExamTaken{" +
                "courseId=" + courseId +
                ", courseName='" + courseName + '\'' +
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

    public Integer getSign1() {
        return sign1;
    }

    public void setSign1(Integer sign1) {
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

    public Integer getSign2() {
        return sign2;
    }

    public void setSign2(Integer sign2) {
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

    public Integer getSign3() {
        return sign3;
    }

    public void setSign3(Integer sign3) {
        this.sign3 = sign3;
    }

    public Date getDate4() {
        return date4;
    }

    public void setDate4(Date date4) {
        this.date4 = date4;
    }

    public Integer getSign4() {
        return sign4;
    }

    public void setSign4(Integer sign4) {
        this.sign4 = sign4;
    }

    public int getTest() {
        return test;
    }

    public void setTest(int test) {
        this.test = test;
    }

    public Integer getStarted() {
        return started;
    }

    public void setStarted(Integer started) {
        this.started = started;
    }
}
