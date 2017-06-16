package sunday.pojo.student;

/**
 * Created by 花间一壶酒 on 2017/6/6.
 */
public final class AnotherTestTaken {
    private Long Id;
    private Integer courseId;
    private String content;

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
