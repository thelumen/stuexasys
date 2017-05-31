package sunday.pojo.dto;

/**
 * 学生成绩分配类
 * Created by yang on 2017/5/31.
 * At 8:59
 */
public final class GradePercent {
    private String specialtyId;
    private String courseId;
    private String percent1;
    private String percent2;
    private String percent3;
    private String percent4;

    public String getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(String specialtyId) {
        this.specialtyId = specialtyId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
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
