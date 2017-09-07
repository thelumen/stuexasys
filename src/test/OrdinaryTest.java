import org.junit.Test;
import sunday.common.kit.DateKit;
import sunday.common.kit.ResourceFileKit;
import sunday.pojo.school.Student;

import java.text.ParseException;
import java.util.*;

/**
 * Created by 花间一壶酒 on 2017/7/30.
 */
public class OrdinaryTest {

    @Test
    public void t4() {
        List<Student> t1 = new ArrayList<Student>() {{
            for (int i = 0; i < 4; i++) {
                Student student = new Student();
                student.setStudentId(i);
                student.setPassword("" + i + 2);
                add(student);
            }
        }};
        List<Student> t2 = new ArrayList<Student>() {{
            for (int i = 0; i < 6; i++) {
                Student student = new Student();
                student.setStudentId(i);
                student.setPassword("" + i + 2);
                add(student);
            }
        }};
        t2.removeAll(t1);
        System.out.println(t2.size());

    }

    @Test
    public void t3() {
        List<Map<String, Object>> testList = ResourceFileKit.getResourceInfo();
        assert testList != null;
        testList.toString();
    }

    @Test
    public void t2() throws ParseException {
        String resultTime = DateKit.date2String(System.currentTimeMillis());
        System.out.println(resultTime);
    }
}
