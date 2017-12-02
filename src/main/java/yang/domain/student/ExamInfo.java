package yang.domain.student;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * Created by 花间一壶酒 on 2017/6/3.
 */
public final class ExamInfo {
    private Long Id;
    private Integer courseId;
    private String courseName;
    private String content;
    private String testNum;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date date;
    /**
     * 是否有考试信息
     */
    private int test;

    @Override
    public String toString() {
        return "ExamInfo{" +
                "Id=" + Id +
                ", courseId=" + courseId +
                ", courseName='" + courseName + '\'' +
                ", content='" + content + '\'' +
                ", testNum='" + testNum + '\'' +
                ", date=" + date +
                ", test=" + test +
                '}';
    }

    public Long getId() {
        return Id;
    }

    public void setId(Long id) {
        Id = id;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTestNum() {
        return testNum;
    }

    public void setTestNum(String testNum) {
        this.testNum = testNum;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getTest() {
        return test;
    }

    public void setTest(int test) {
        this.test = test;
    }
}
