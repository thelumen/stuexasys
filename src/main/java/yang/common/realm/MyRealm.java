package yang.common.realm;

import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import yang.common.kit.ShiroKit;
import yang.domain.manager.Manager;
import yang.domain.shiro.Resource;
import yang.domain.shiro.Role;
import yang.domain.shiro.ShiroInfo;
import yang.domain.student.StudentTaken;
import yang.domain.teacher.Teacher;
import yang.service.manager.ManagerService;
import yang.service.shiro.ResourceService;
import yang.service.shiro.RoleService;
import yang.service.student.StudentService;
import yang.service.teacher.TeacherService;

import java.util.*;

/**
 * 不做多realm的形式了
 *
 * @author yang
 * @date 2017/2/8
 * At 13:36
 */
@Component("myRealm")
public class MyRealm extends AuthorizingRealm {

    @Autowired
    private ManagerService managerService;

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private ResourceService resourceService;

    /**
     * 权限考证
     *
     * @param principalCollection
     * @return
     */
    @Override
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
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;

        String account = token.getUsername();
        String direction = account.substring(account.length() - 1);

        String realAccount = account.substring(0, account.length() - 1);
        String password = new String(token.getPassword());

        ShiroInfo shiroInfo = null;
        if ("0".equals(direction)) {
            shiroInfo = getStudentInfo(realAccount, password);
        } else if ("1".equals(direction)) {
            shiroInfo = getTeacherInfo(realAccount, password);
        } else if ("2".equals(direction)) {
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
                put("managerId", manager.getManagerId());
            }};
            List<Role> roles = roleService.selectByManagerInfo(managerInfo);
            if (null != roles) {
                setRolesAndPermissions(roles, rolesSet, permissionsSet);
            }
            shiroInfo.setRoles(rolesSet);
            shiroInfo.setPermissions(permissionsSet);

            ShiroKit.getSession().setAttribute("currentManager", manager);

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
                put("teacherId", teacher.getTeacherId());
            }};
            List<Role> roles = roleService.selectByTeacherInfo(teacherInfo);
            if (null != roles) {
                setRolesAndPermissions(roles, rolesSet, permissionsSet);
            }
            shiroInfo.setRoles(rolesSet);
            shiroInfo.setPermissions(permissionsSet);

            ShiroKit.getSession().setAttribute("currentTeacher", teacher);

            return shiroInfo;
        }
        return null;
    }

    /**
     * 学生信息
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
        List<StudentTaken> students = studentService.selectStudentInfo(null, params);
        if (null != students) {
            StudentTaken student = students.get(0);

            ShiroInfo shiroInfo = new ShiroInfo();
            shiroInfo.setUserId(student.getStudentId());
            shiroInfo.setUserName(student.getName());
            shiroInfo.setUserLoginName(student.getStudentId());
            shiroInfo.setUserLoginPassword(student.getPassword());

            Set<String> rolesSet = new HashSet<>();
            Set<String> permissionsSet = new HashSet<>();

            Map<String, Object> studentInfo = new HashMap<String, Object>() {{
                put("studentId", student.getStudentId());
            }};
            List<Role> roles = roleService.selectByStudentInfo(studentInfo);
            if (null != roles) {
                setRolesAndPermissions(roles, rolesSet, permissionsSet);
            }
            shiroInfo.setRoles(rolesSet);
            shiroInfo.setPermissions(permissionsSet);

            ShiroKit.getSession().setAttribute("currentStudent", student);

            return shiroInfo;
        }
        return null;
    }

}
