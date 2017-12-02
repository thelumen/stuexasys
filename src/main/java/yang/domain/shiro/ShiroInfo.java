package yang.domain.shiro;

import java.io.Serializable;
import java.util.Set;

/**
 * Created by yang on 2017/5/22.
 * At 17:27
 */
public final class ShiroInfo implements Serializable {
    private Integer userId;
    private String userName;
    private Integer userLoginName;
    private String userLoginPassword;

    private Set<String> roles;
    private Set<String> permissions;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getUserLoginName() {
        return userLoginName;
    }

    public void setUserLoginName(Integer userLoginName) {
        this.userLoginName = userLoginName;
    }

    public String getUserLoginPassword() {
        return userLoginPassword;
    }

    public void setUserLoginPassword(String userLoginPassword) {
        this.userLoginPassword = userLoginPassword;
    }

    public Set<String> getRoles() {
        return roles;
    }

    public void setRoles(Set<String> roles) {
        this.roles = roles;
    }

    public Set<String> getPermissions() {
        return permissions;
    }

    public void setPermissions(Set<String> permissions) {
        this.permissions = permissions;
    }
}
