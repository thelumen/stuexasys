package sunday.pojo.student;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * Created by 花间一壶酒 on 2017/6/3.
 */
public class ExamInfo {
    private String courseId;
    private String courseName;
    private String content;
    private String testNum;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date date;
    //是否有考试信息
    private byte test;

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public byte getTest() {
        return test;
    }

    public void setTest(byte test) {
        this.test = test;
    }

    public String getTestNum() {
        return testNum;
    }

    public void setTestNum(String testNum) {
        this.testNum = testNum;
    }

    @Override
    public String toString() {
        return "ExamInfo{" +
                "courseId='" + courseId + '\'' +
                ", courseName='" + courseName + '\'' +
                ", content='" + content + '\'' +
                ", testNum='" + testNum + '\'' +
                ", date=" + date +
                ", test=" + test +
                '}';
    }
}
