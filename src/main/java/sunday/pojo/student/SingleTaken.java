package sunday.pojo.student;

import java.io.Serializable;

/**
 *
 * @author 花间一壶酒
 * @date 2017/6/4
 */
public final class SingleTaken implements Serializable{
    private static final long serialVersionUID = -4447759751561576266L;
    private Long Id;
    private Integer courseId;
    private String section;
    private Integer levels;
    private String content;
    private String que1;
    private String que2;
    private String que3;
    private String que4;
    private String result;
    private String realAnswer;

    @Override
    public String toString() {
        return "SingleTaken{" +
                "Id=" + Id +
                ", courseId=" + courseId +
                ", section='" + section + '\'' +
                ", levels=" + levels +
                ", content='" + content + '\'' +
                ", que1='" + que1 + '\'' +
                ", que2='" + que2 + '\'' +
                ", que3='" + que3 + '\'' +
                ", que4='" + que4 + '\'' +
                ", result='" + result + '\'' +
                ", realAnswer='" + realAnswer + '\'' +
                '}';
    }

    public String getRealAnswer() {
        return realAnswer;
    }

    public void setRealAnswer(String realAnswer) {
        this.realAnswer = realAnswer;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getId() {
        return Id;
    }

    public void setId(Long id) {
        Id = id;
    }

    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public String getQue1() {
        return que1;
    }

    public void setQue1(String que1) {
        this.que1 = que1;
    }

    public String getQue2() {
        return que2;
    }

    public void setQue2(String que2) {
        this.que2 = que2;
    }

    public String getQue3() {
        return que3;
    }

    public void setQue3(String que3) {
        this.que3 = que3;
    }

    public String getQue4() {
        return que4;
    }

    public void setQue4(String que4) {
        this.que4 = que4;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getLevels() {
        return levels;
    }

    public void setLevels(Integer levels) {
        this.levels = levels;
    }
}
