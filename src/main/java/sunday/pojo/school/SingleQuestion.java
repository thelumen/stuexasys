package sunday.pojo.school;

/**
 * 选择题类
 * Created by yang on 2017/6/5.
 * At 15:21
 */
public final class SingleQuestion {
    private long id;
    private String courseId;
    private String section;
    private byte levels;
    private String content;
    private String que1;
    private String que2;
    private String que3;
    private String que4;
    private String result;

    @Override
    public String toString() {
        return "SingleQuestion{" +
                "id=" + id +
                ", courseId='" + courseId + '\'' +
                ", section='" + section + '\'' +
                ", levels=" + levels +
                ", content='" + content + '\'' +
                ", que1='" + que1 + '\'' +
                ", que2='" + que2 + '\'' +
                ", que3='" + que3 + '\'' +
                ", que4='" + que4 + '\'' +
                ", result='" + result + '\'' +
                '}';
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public byte getLevels() {
        return levels;
    }

    public void setLevels(byte levels) {
        this.levels = levels;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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
}
