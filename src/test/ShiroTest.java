import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.pojo.Role;
import sunday.service.shiro.RoleService;

import java.util.List;

import static java.lang.System.out;

/**
 * Created by yang on 2017/5/24.
 * At 18:17
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:/config/spring/spring-*.xml"})
public class ShiroTest {
    @javax.annotation.Resource(name = "roleService")
    private RoleService roleService;

    //模拟登陆
    @Test
    public void t2() {
    }

    //新增+查询角色
    @Test
    public void t1() {
        Role role = new Role();
        role.setName("manager");
        role.setRemark("管理员");
        if (roleService.insert(role) > 0) {
            List<Role> roles = roleService.select(null);
            for (Role r : roles) {
                out.print(" " + r.getName());
            }
        }
    }
}
