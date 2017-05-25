package sunday.pojo.dto;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * 教师-课程-班级
 * 信息类
 * Created by yang on 2017/5/25.
 * At 14:56
 */
public final class TakenInfo {
    private String teacherId;
    private String teacherName;
    private String courseName;
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

    public boolean isOn() {
        return on;
    }

    public void setOn(boolean on) {
        this.on = on;
    }
}
