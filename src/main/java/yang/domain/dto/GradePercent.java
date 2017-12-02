package yang.domain.dto;

/**
 * 学生成绩分配类
 * Created by yang on 2017/5/31.
 * At 8:59
 */
public final class GradePercent {
    private Integer specialtyId;
    private Integer courseId;
    private String percent1;
    private String percent2;
    private String percent3;
    private String percent4;

    @Override
    public String toString() {
        return "GradePercent{" +
                "specialtyId=" + specialtyId +
                ", courseId=" + courseId +
                ", percent1='" + percent1 + '\'' +
                ", percent2='" + percent2 + '\'' +
                ", percent3='" + percent3 + '\'' +
                ", percent4='" + percent4 + '\'' +
                '}';
    }

    public Integer getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(Integer specialtyId) {
        this.specialtyId = specialtyId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getPercent1() {
        return percent1;
    }

    public void setPercent1(String percent1) {
        this.percent1 = percent1;
    }

    public String getPercent2() {
        return percent2;
    }

    public void setPercent2(String percent2) {
        this.percent2 = percent2;
    }

    public String getPercent3() {
        return percent3;
    }

    public void setPercent3(String percent3) {
        this.percent3 = percent3;
    }

    public String getPercent4() {
        return percent4;
    }

    public void setPercent4(String percent4) {
        this.percent4 = percent4;
    }
}
