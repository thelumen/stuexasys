package sunday.pojo.teacher;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * 选课类
 * Created by yang on 2017/5/25.
 * At 14:53
 */
public final class CourseTaken {
    private String teacherId;
    private String teacherName;
    private String courseId;
    private String courseName;
    private String specialtyId;
    private String specialtyName;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date starttime;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endtime;
    //课程结束与否，false：结束了，true：没有
    private boolean on;

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(String specialtyId) {
        this.specialtyId = specialtyId;
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

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getSpecialtyName() {
        return specialtyName;
    }

    public void setSpecialtyName(String specialtyName) {
        this.specialtyName = specialtyName;
    }

    public boolean isOn() {
        return on;
    }

    public void setOn(boolean on) {
        this.on = on;
    }

    @Override
    public String toString() {
        return "CourseTaken{" +
                "teacherId='" + teacherId + '\'' +
                ", teacherName='" + teacherName + '\'' +
                ", courseId='" + courseId + '\'' +
                ", courseName='" + courseName + '\'' +
                ", specialtyId='" + specialtyId + '\'' +
                ", specialtyName='" + specialtyName + '\'' +
                ", starttime=" + starttime +
                ", endtime=" + endtime +
                ", on=" + on +
                '}';
    }
}
