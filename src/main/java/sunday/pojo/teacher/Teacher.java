package sunday.pojo.teacher;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by yang on 2017/5/15.
 * At 15:51
 */
public final class Teacher implements Serializable {
    //自增
    private int id;
    private Integer teacherId;
    private String password;
    private String name;
    private String gender;
    private String position;
    private String office;
    private Date logintime;
    private String ip;

    @Override
    public String toString() {
        return "Teacher{" +
                "id=" + id +
                ", teacherId=" + teacherId +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", position='" + position + '\'' +
                ", office='" + office + '\'' +
                ", logintime=" + logintime +
                ", ip='" + ip + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getOffice() {
        return office;
    }

    public void setOffice(String office) {
        this.office = office;
    }

    public Date getLogintime() {
        return logintime;
    }

    public void setLogintime(Date logintime) {
        this.logintime = logintime;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }
}
