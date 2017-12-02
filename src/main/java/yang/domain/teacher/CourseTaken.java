package yang.domain.teacher;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * 选课类
 *
 * @author yang
 * @date 2017/5/25
 * At 14:53
 */
public class CourseTaken {
    private int teacherId;
    private String teacherName;

    private int courseId;
    private String courseName;

    private int specialtyId;
    private String specialtyName;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date starttime;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date endtime;

    /**
     * 课程结束与否，false：结束了，true：没有
     */
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

    public int getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public int getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(int specialtyId) {
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
