package sunday.pojo;

import java.util.Date;

/**
 * Created by yang on 2017/5/22.
 * At 19:06
 */
public final class Manager {
    private final String managerId;
    private final String password;
    private String name;
    private Date logintime;
    private String ip;

    public Manager(String managerId, String password) {
        this.managerId = managerId;
        this.password = password;
    }

    public String getManagerId() {
        return managerId;
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
