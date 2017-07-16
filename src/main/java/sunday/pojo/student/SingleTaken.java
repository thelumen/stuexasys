package sunday.pojo.student;

/**
 * Created by 花间一壶酒 on 2017/6/4.
 */
public final class SingleTaken {
    private Long Id;
    private Integer courseId;
    private String section;
    private Integer levels;
    private String name;
    private String que1;
    private String que2;
    private String que3;
    private String que4;
    private String result;

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
