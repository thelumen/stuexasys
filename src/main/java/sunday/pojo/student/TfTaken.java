package sunday.pojo.student;

/**
 * Created by 花间一壶酒 on 2017/6/4.
 */
public class TfTaken {
    private Long Id;
    private String courseId;
    private String section;
    private Byte levels;
    private String name;
    private String result;

    public Long getId() {
        return Id;
    }

    public void setId(Long id) {
        Id = id;
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

    public Byte getLevels() {
        return levels;
    }

    public void setLevels(Byte levels) {
        this.levels = levels;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }
}
