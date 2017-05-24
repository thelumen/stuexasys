package sunday.common.realm;

import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.stereotype.Component;
import sunday.pojo.*;
import sunday.service.*;

import java.util.*;

/**
 * 不做多realm的形式了
 * Created by yang on 2017/2/8.
 * At 13:36
 */
@Component("myRealm")
public class MyRealm extends AuthorizingRealm {

    @javax.annotation.Resource(name = "managerService")
    private ManagerService managerService;

    @javax.annotation.Resource(name = "teacherService")
    private TeacherService teacherService;

    @javax.annotation.Resource(name = "studentService")
    private StudentService studentService;

    @javax.annotation.Resource(name = "roleService")
    private RoleService roleService;

    @javax.annotation.Resource(name = "resourceService")
    private ResourceService resourceService;

    /**
     * 权限考证
     *
     * @param principalCollection
     * @return
     */
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        ShiroInfo shiroInfo = (ShiroInfo) this.getAuthenticationCacheKey(principalCollection);

        authorizationInfo.setRoles(shiroInfo.getRoles());
        authorizationInfo.setStringPermissions(shiroInfo.getPermissions());
        return authorizationInfo;
    }

    /**
     * 身份认证
     *
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        String account = token.getUsername();
        String direction = account.substring(account.length() - 1);
        String realAccount = account.substring(0, account.length() - 1);
        String password = new String(token.getPassword());
        ShiroInfo shiroInfo = null;
        if (direction.equals("0")) {
            shiroInfo = getStudentInfo(realAccount, password);
        }
        if (direction.equals("1")) {
            shiroInfo = getTeacherInfo(realAccount, password);
        }
        if (direction.equals("2")) {
            shiroInfo = getManagerInfo(realAccount, password);
        }
        if (null != shiroInfo) {
            return new SimpleAuthenticationInfo(shiroInfo, shiroInfo.getUserLoginPassword(), getName());
        } else {
            throw new UnknownAccountException();
        }
    }

    /**
     * 设置角色和权限
     *
     * @param roles          角色集合
     * @param rolesSet       角色
     * @param permissionsSet 权限
     */
    private void setRolesAndPermissions(List<Role> roles, Set<String> rolesSet, Set<String> permissionsSet) {
        for (Role role : roles) {
            rolesSet.add(role.getName());

            Map<String, Object> roleInfo = new HashMap<String, Object>() {{
                put("roleId", role.getId());
            }};
            List<Resource> resources = resourceService.selectByRoleInfo(roleInfo);
            if (null != resources) {
                for (Resource resource : resources) {
                    permissionsSet.add(resource.getPermission());
                }
            }
        }
    }

    /**
     * 管理员信息
     *
     * @param realAccount
     * @param password
     * @return
     */
    private ShiroInfo getManagerInfo(String realAccount, String password) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("managerId", realAccount);
            put("password", password);
        }};
        List<Manager> managers = managerService.select(null, params);
        if (null != managers) {
            Manager manager = managers.get(0);

            ShiroInfo shiroInfo = new ShiroInfo();
            shiroInfo.setUserId(manager.getManagerId());
            shiroInfo.setUserName(manager.getName());
            shiroInfo.setUserLoginName(manager.getManagerId());
            shiroInfo.setUserLoginPassword(manager.getPassword());

            Set<String> rolesSet = new HashSet<>();
            Set<String> permissionsSet = new HashSet<>();

            Map<String, Object> managerInfo = new HashMap<String, Object>() {{
                put("managerId", manager.getId());
            }};
            List<Role> roles = roleService.selectByManagerInfo(managerInfo);
            if (null != roles) {
                setRolesAndPermissions(roles, rolesSet, permissionsSet);
            }
            shiroInfo.setRoles(rolesSet);
            shiroInfo.setPermissions(permissionsSet);
            return shiroInfo;
        }
        return null;
    }

    /**
     * 教师信息
     *
     * @param realAccount
     * @param password
     * @return
     */
    private ShiroInfo getTeacherInfo(String realAccount, String password) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", realAccount);
            put("password", password);
        }};
        List<Teacher> teachers = teacherService.select(null, params);
        if (null != teachers) {
            Teacher teacher = teachers.get(0);

            ShiroInfo shiroInfo = new ShiroInfo();
            shiroInfo.setUserId(teacher.getTeacherId());
            shiroInfo.setUserName(teacher.getName());
            shiroInfo.setUserLoginName(teacher.getTeacherId());
            shiroInfo.setUserLoginPassword(teacher.getPassword());

            Set<String> rolesSet = new HashSet<>();
            Set<String> permissionsSet = new HashSet<>();

            Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
                put("teacherId", teacher.getId());
            }};
            List<Role> roles = roleService.selectByTeacherInfo(teacherInfo);
            if (null != roles) {
                setRolesAndPermissions(roles, rolesSet, permissionsSet);
            }
            shiroInfo.setRoles(rolesSet);
            shiroInfo.setPermissions(permissionsSet);
            return shiroInfo;
        }
        return null;
    }

    /**
     * 学生无角色无权限
     *
     * @param realAccount
     * @param password
     * @return
     */
    private ShiroInfo getStudentInfo(String realAccount, String password) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", realAccount);
            put("password", password);
        }};
        List<Student> students = studentService.select(null, params);
        if (null != students) {
            Student student = students.get(0);

            ShiroInfo shiroInfo = new ShiroInfo();
            shiroInfo.setUserId(student.getStudentId());
            shiroInfo.setUserName(student.getName());
            shiroInfo.setUserLoginName(student.getStudentId());
            shiroInfo.setUserLoginPassword(student.getPassword());
            shiroInfo.setRoles(null);
            shiroInfo.setPermissions(null);

            return shiroInfo;
        }
        return null;
    }

}
