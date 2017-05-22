package sunday.common.realm;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.stereotype.Component;
import sunday.pojo.*;
import sunday.service.*;

import java.util.*;

/**
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
        ShiroInfo shiroInfo;
        if (direction.equals("0")) {
            shiroInfo = getStudentInfo(realAccount, password);
        }
        if (direction.equals("1")) {
            shiroInfo = getTeacherInfo(realAccount, password);
        }
        if (direction.equals("2")) {
            shiroInfo = getManagerInfo(realAccount, password);
        }
//        Map<String, Object> params = new HashMap<String, Object>();
//        params.put("loginName", token.getUsername());
//        params.put("loginPassword", new String(token.getPassword()));
//        List<User> users = userService.select(null, params);
//        if (null != users && users.size() > 0) {
//            //用户名是唯一的
//            User user = users.get(0);
//
//            //以shiroInfo来封装用户-角色-权限（资源）
//            ShiroInfo shiroInfo = new ShiroInfo();
//            shiroInfo.setUserId(user.getId());
//            shiroInfo.setUserName(user.getName());
//            shiroInfo.setUserLoginName(user.getLoginName());
//            shiroInfo.setUserLoginPassword(user.getLoginPassword());
//
//            //用户id查角色，角色id查资源(权限)
//            Set<String> rolesSet = new HashSet<String>();
//            Set<String> stringPermissionsSet = new HashSet<String>();
//            Map<String, Object> userInfo = new HashMap<>();
//            userInfo.put("id", user.getId());
//
//            List<Role> roles = userService.getRoles(userInfo);
//            if (null != roles && roles.size() > 0) {
//                for (Role role : roles) {
//                    //当前用户拥有的角色
//                    rolesSet.add(role.getName());
//                    //以角色ID来查询其权限，即资源
//                    Map<String, Object> roleInfo = new HashMap<>();
//                    roleInfo.put("id", role.getId());
//                    List<Resource> resources = roleService.getResources(roleInfo);
//                    if (null != resources && resources.size() > 0) {
//                        //前台权限名称展示
//                        for (Resource resource : resources) {
//                            //当前用户拥有的权限
//                            stringPermissionsSet.add(resource.getPermission());
//                        }
//                        SecurityUtils.getSubject().getSession().setAttribute("hasPermission", true);
//                    }
//                }
//            }
//            shiroInfo.setRoles(rolesSet);
//            shiroInfo.setPermissions(stringPermissionsSet);
//            //realm有一个方法,即getName(),获取自身的名字
//            //此处传入的第一个参数为shiroInfo对象，那么我们在页面可以通过这样的方式来获取用户名：<shiro:principal property="userName"/>
//            AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(shiroInfo, user.getLoginPassword(), getName());
//            return authenticationInfo;
//        } else {
//            throw new UnknownAccountException();
//        }
        return null;
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
