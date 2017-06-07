import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.common.kit.ChapterKit;
import sunday.common.kit.EncryptKit;
import sunday.pojo.school.Course;
import sunday.pojo.school.SingleQuestion;
import sunday.pojo.school.Specialty;
import sunday.pojo.teacher.CourseTaken;
import sunday.pojo.teacher.Teacher;
import sunday.service.teacher.SpeCouService;
import sunday.service.teacher.TeaQueService;
import sunday.service.teacher.TeacherService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @javax.annotation.Resource(name = "speCouService")
    private SpeCouService speCouService;

    @javax.annotation.Resource(name = "teaQueService")
    private TeaQueService teaQueService;

    //测试teacherService
    @Test
    public void t9() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", "140400");
        }};
        List<Teacher> teachers = teacherService.select(null, params);
        if (null != teachers) {
            out.print(teachers.size() + teachers.get(0).toString());
        }
    }

    //选择题章节排序
    @Test
    public void t8() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("courseId", "10000001");
        }};
        List<SingleQuestion> questions = teaQueService.selectSingleQuestion(params);
        if (null != questions) {
            List<SingleQuestion> target = ChapterKit.bubbleSort(questions);
            for (SingleQuestion s : target) {
                out.print(s.getSection() + " ");
            }
        }
    }

    @Test
    public void t7() {
        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", "140400");
        }};
        List<CourseTaken> courseTakens = speCouService.selectCourseTaken(null, teacherInfo);
        if (courseTakens != null) {
            for (CourseTaken courseTaken : courseTakens) {
                out.print(" " + courseTaken.getCourseName());
            }
        } else {
            out.print("无数据");
        }
    }

    //测试新增和查询课程功能
    @Test
    public void t6() {
        for (int i = 0; i < 8; i++) {
            Course course = new Course();
            course.setCourseId("1000000" + i);
            course.setName("数据结构" + i);
            course.setCredit(new Byte("2"));
            course.setPeriod(new Byte("12"));
            if (speCouService.insertCourse(course) > 0) {
                out.print(i + "：成功 ");
            }
        }
//        Map<String, Object> params = new HashMap<String, Object>() {{
//            put("period", new Byte("12"));
//        }};
        List<Course> courses = speCouService.selectCourse(null);
        if (courses != null) {
            for (Course course : courses) {
                out.print(" " + course.getName());
            }
        }
    }

    //测试新增和查询班级功能
    @Test
    public void t5() {
        for (int i = 0; i < 6; i++) {
            Specialty specialty = new Specialty();
            specialty.setSpecialtyId("14040" + i);
            specialty.setName("计算机" + i + "班");
            if (speCouService.insertSpecialty(specialty) > 0) {
                out.print(i + "：成功 ");
            }
        }
//        Map<String, Object> params = new HashMap<String, Object>() {{
//            put("name", "计算机0班");
//        }};
        List<Specialty> specialties = speCouService.selectSpecialty(null);
        if (specialties != null) {
            for (Specialty specialty : specialties) {
                out.print(" " + specialty.getName());
            }
        }

    }

    //条件查询
    @Test
    public void t4() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("name", "辽工教师");
        }};
        List<Teacher> teachers = teacherService.select(null, params);
        for (Teacher teacher : teachers) {
            System.out.print(" " + teacher.getTeacherId());
        }
    }

    //测试map数据查询
    @Test
    public void t3() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", "140400");
        }};
        List<Teacher> teachers = teacherService.select(null, params);
        if (teachers != null) {
            out.print(teachers.get(0).getId());
        }
    }

    //添加教师数据
    @Test
    public void t2() {
        for (int i = 0; i < 3; i++) {
            Teacher teacher = new Teacher();
            teacher.setTeacherId("14040" + i);
            teacher.setPassword(EncryptKit.md5("12345"));
            if (teacherService.insert(teacher) > 0) {
                out.print(i + " 成功！ ");
            }
        }
    }

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
