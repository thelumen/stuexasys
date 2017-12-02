package yang.domain.student;

import java.io.Serializable;

/**
 * @author 花间一壶酒
 * @date 2017/6/4
 */
public final class TfTaken implements Serializable {
    private static final long serialVersionUID = -3458253633212400876L;
    private Long Id;
    private Integer courseId;
    private String section;
    private Integer levels;
    private String content;
    private Integer result;
    private Integer realAnswer;

    public Integer getRealAnswer() {
        return realAnswer;
    }

    public void setRealAnswer(Integer realAnswer) {
        this.realAnswer = realAnswer;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public Integer getResult() {
        return result;
    }

    public void setResult(Integer result) {
        this.result = result;
    }
}
