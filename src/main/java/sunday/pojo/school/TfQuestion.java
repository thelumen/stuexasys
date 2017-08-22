package sunday.pojo.school;

/**
 * Created by yang on 2017/6/5.
 * At 17:32
 */
public final class TfQuestion {
    private long id;
    private Integer courseId;
    private String section;
    private int levels;
    private String content;
    private int result;

    @Override
    public String toString() {
        return "TfQuestion{" +
                "id=" + id +
                ", courseId=" + courseId +
                ", section='" + section + '\'' +
                ", levels=" + levels +
                ", content='" + content + '\'' +
                ", result=" + result +
                '}';
    }

    public long getId() {
        return id;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public int getLevels() {
        return levels;
    }

    public void setLevels(int levels) {
        this.levels = levels;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }
}
