package yang.domain.teacher;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * 选课类
 * Created by yang on 2017/5/25.
 * At 14:53
 */
public final class CourseTaken {
    private Integer teacherId;
    private String teacherName;

    private Integer courseId;
    private String courseName;

    private Integer specialtyId;
    private String specialtyName;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date starttime;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date endtime;

    //课程结束与否，false：结束了，true：没有
    private String on;

    @Override
    public String toString() {
        return "CourseTaken{" +
                "teacherId=" + teacherId +
                ", teacherName='" + teacherName + '\'' +
                ", courseId=" + courseId +
                ", courseName='" + courseName + '\'' +
                ", specialtyId=" + specialtyId +
                ", specialtyName='" + specialtyName + '\'' +
                ", starttime=" + starttime +
                ", endtime=" + endtime +
                ", on='" + on + '\'' +
                '}';
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public Integer getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(Integer specialtyId) {
        this.specialtyId = specialtyId;
    }

    public String getSpecialtyName() {
        return specialtyName;
    }

    public void setSpecialtyName(String specialtyName) {
        this.specialtyName = specialtyName;
    }

    public Date getStarttime() {
        return starttime;
    }

    public void setStarttime(Date starttime) {
        this.starttime = starttime;
    }

    public Date getEndtime() {
        return endtime;
    }

    public void setEndtime(Date endtime) {
        this.endtime = endtime;
    }

    public String getOn() {
        return on;
    }

    public void setOn(String on) {
        this.on = on;
    }
}
