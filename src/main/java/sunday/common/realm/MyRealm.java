package sunday.common.realm;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.stereotype.Component;

/**
 * Created by yang on 2017/2/8.
 * At 13:36
 */
@Component("myRealm")
public class MyRealm extends AuthorizingRealm {

//    @javax.annotation.Resource(name = "userService")
//    private ManagerService userService;
//
//    @javax.annotation.Resource(name = "roleService")
//    private RoleService roleService;

    /**
     * 授权
     * 在调用controller方法时，如果方法上面有shiro注解，会触发下面的方法
     *
     * @param principalCollection
     * @return
     */
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {

        return null;
//        //返回验证信息AuthenticationInfo,包括用户角色和权限
//        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
//        //取得cache中的用户信息
//        ShiroInfo shiroInfo = (ShiroInfo) this.getAuthenticationCacheKey(principalCollection);
//
//        authorizationInfo.setRoles(shiroInfo.getRoles());
//        authorizationInfo.setStringPermissions(shiroInfo.getPermissions());
//
//        return authorizationInfo;
    }

    /**
     * 身份认证
     * 调用subject.login(token);的时候，会触发下面的方法
     *
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
//        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
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

}
