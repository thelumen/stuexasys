package sunday.pojo.student;

import java.util.Date;

/**
 * Created by 花间一壶酒 on 2017/5/30.
 */
public class CourseTaken {
    private String courseName;
    private Date startTime;
    private Date endTime;
    private Byte period;
    private Byte credit;

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Byte getPeriod() {
        return period;
    }

    public void setPeriod(Byte period) {
        this.period = period;
    }

    public Byte getCredit() {
        return credit;
    }

    public void setCredit(Byte credit) {
        this.credit = credit;
    }

    @Override
    public String toString() {
        return "CourseTaken{" +
                "courseName='" + courseName + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", period=" + period +
                ", credit=" + credit +
                '}';
    }
}
