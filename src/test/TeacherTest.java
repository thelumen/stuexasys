import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.pojo.Teacher;
import sunday.service.TeacherService;

import java.util.List;

import static java.lang.System.out;

/**
 * Created by yang on 2017/5/24.
 * At 12:34
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:/config/spring/spring-*.xml"})
public class TeacherTest {
    @javax.annotation.Resource(name = "teacherService")
    private TeacherService teacherService;

    //测试新增和查询功能
    @Test
    public void t1() {
        Teacher teacher = new Teacher();
        teacher.setTeacherId("140406");
        teacher.setPassword("123456");
        if (teacherService.insert(teacher) > 0) {
            List<Teacher> teachers = teacherService.select(null, null);
            for (Teacher t : teachers) {
                out.print(t.getId() + " " + t.getTeacherId());
            }
        } else {
            out.print("新增教师失败!");
        }
    }
}
