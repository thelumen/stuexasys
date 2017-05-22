package sunday.pojo;

import java.util.Date;

/**
 * Created by yang on 2017/5/15.
 * At 15:51
 */
public final class Teacher {
    //自增
    private short id;
    private final String teacherId;
    private final String password;
    private String name;
    private String gender;
    private String position;
    private String office;
    private Date logintime;
    private String ip;

    public Teacher(String teacherId, String password) {
        this.teacherId = teacherId;
        this.password = password;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public String getPassword() {
        return password;
    }

    public short getId() {
        return id;
    }

    public void setId(short id) {
        this.id = id;
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
