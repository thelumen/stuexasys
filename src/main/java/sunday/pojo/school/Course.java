package sunday.pojo.school;

/**
 * 课程类
 * Created by yang on 2017/5/25.
 * At 12:28
 */
public final class Course {
    private int id;
    private Integer courseId;
    private String name;
    private int period;
    private int credit;

    @Override
    public String toString() {
        return "Course{" +
                "id=" + id +
                ", courseId=" + courseId +
                ", name='" + name + '\'' +
                ", period=" + period +
                ", credit=" + credit +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPeriod() {
        return period;
    }

    public void setPeriod(int period) {
        this.period = period;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }
}
