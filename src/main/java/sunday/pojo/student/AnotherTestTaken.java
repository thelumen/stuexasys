package sunday.pojo.student;

import java.io.Serializable;

/**
 *
 * @author 花间一壶酒
 * @date 2017/6/6
 */
public final class AnotherTestTaken implements Serializable {
    private static final long serialVersionUID = 318865977840892546L;
    private Long Id;
    private Integer courseId;
    private String content;
    private String result;

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
