import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.pojo.Student;
import sunday.service.StudentService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/24.
 * At 21:04
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:/config/spring/spring-*.xml"})
public class StudentTest {
    @javax.annotation.Resource(name = "studentService")
    private StudentService studentService;

    //查询学生
    @Test
    public void t1() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", "140401049");
            put("password", "827ccb0eea8a706c4c34a16891f84e7b");
        }};
        List<Student> students = studentService.select(null, params);
        if (students != null) {
            for (Student student : students) {
                System.out.print(" " + student.getStudentId());
            }
        } else {
            System.out.print("没有数据！");
        }
    }
}
