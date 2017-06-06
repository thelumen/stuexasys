package sunday.pojo.school;

/**
 * 附加题类
 * Created by yang on 2017/6/6.
 * At 10:04
 */
public final class Another {
    private long id;
    private String courseId;
    private String content;
    private String result;

    @Override
    public String toString() {
        return "Another{" +
                "id=" + id +
                ", courseId='" + courseId + '\'' +
                ", content='" + content + '\'' +
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
}
