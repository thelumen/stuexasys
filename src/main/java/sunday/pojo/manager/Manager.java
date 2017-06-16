package sunday.pojo.manager;

import java.util.Date;

/**
 * Created by yang on 2017/5/22.
 * At 19:06
 */
public final class Manager {
    private int id;
    private int managerId;
    private String password;
    private String name;
    private Date logintime;
    private String ip;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setId(short id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
