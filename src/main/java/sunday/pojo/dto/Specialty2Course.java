package sunday.pojo.dto;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * Created by 花间一壶酒 on 2017/9/2.
 */
public final class Specialty2Course {
    private Integer teacherId;
    private Integer courseId;
    private Integer specialtyId;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date starttime;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endtime;

    @Override
    public String toString() {
        return "Specialty2Course{" +
                "teacherId=" + teacherId +
                ", courseId=" + courseId +
                ", specialtyId=" + specialtyId +
                ", starttime=" + starttime +
                ", endtime=" + endtime +
                '}';
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(Integer specialtyId) {
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
}
