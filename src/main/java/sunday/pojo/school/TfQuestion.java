package sunday.pojo.school;

/**
 * Created by yang on 2017/6/5.
 * At 17:32
 */
public final class TfQuestion {
    private long id;
    private String courseId;
    private String section;
    private byte levels;
    private String content;
    private byte result;

    @Override
    public String toString() {
        return "TfQuestion{" +
                "id=" + id +
                ", courseId='" + courseId + '\'' +
                ", section='" + section + '\'' +
                ", levels=" + levels +
                ", content='" + content + '\'' +
                ", result=" + result +
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

    public byte getResult() {
        return result;
    }

    public void setResult(byte result) {
        this.result = result;
    }
}
