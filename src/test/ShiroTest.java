import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.pojo.shiro.Resource;
import sunday.pojo.shiro.Role;
import sunday.pojo.teacher.Teacher;
import sunday.service.shiro.ResourceService;
import sunday.service.shiro.RoleService;
import sunday.service.teacher.TeacherService;

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

    @javax.annotation.Resource(name = "resourceService")
    private ResourceService resourceService;

    @javax.annotation.Resource(name = "teacherService")
    private TeacherService teacherService;

    //查询资源+条件查询
    @Test
    public void t5() {
//        Map<String, Object> roleInfo = new HashMap<String, Object>() {{
//            put("roleId", (short) 1);
//        }};
        List<Resource> resources = resourceService.selectByRoleInfo(null);
        if (resources != null) {
            for (Resource r : resources) {
                out.print(" " + r.getName());
            }
        } else {
            out.print("无数据!");
        }
    }

    //管理员-角色关联(只针对普通管理员)
    @Test
    public void t4() {

    }

    //教师-角色关联
    @Test
    public void t3() {
        short roleId = (short) 3;
        List<Teacher> teachers = teacherService.select(null, null);
        for (Teacher teacher : teachers) {
            short teacherId = teacher.getId();
            if (roleService.link2Teacher(teacherId, roleId)) {
                out.print(" " + teacher.getId() + "绑定角色成功！");
            } else {
                out.print(" " + teacher.getId() + "绑定角色失败！");
            }
        }
    }

    //新增+查询资源
    @Test
    public void t2() {
        Resource resource = new Resource();
        resource.setName("teacher");
        resource.setRemark("教师");
        resource.setPermission("shiro:sys:teacher");
        resource.setUrl("/teacher/main/mainProxy");
        if (resourceService.insert(resource) > 0) {
            out.print("成功！");
        } else {
            out.print("失败！");
        }
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
