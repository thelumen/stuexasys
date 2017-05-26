import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.common.kit.EncryptKit;
import sunday.pojo.Course;
import sunday.pojo.Specialty;
import sunday.pojo.Teacher;
import sunday.pojo.dto.TakenInfo;
import sunday.service.SpeCouService;
import sunday.service.TeacherService;

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

    //测试选课查询
    @Test
    public void t8() {
//        Map<String, Object> params = new HashMap<String, Object>() {{
//            put("teacherId", "140400");
//            put("courseName", "数据结构0");
//            put("specialtyName", "计算机1班");
//        }};
        List<TakenInfo> infoList = speCouService.selectTakenInfo(null, null);
        if (infoList != null) {
            for (TakenInfo info : infoList) {
                out.print(" " + info.getTeacherName() + " " + info.getCourseName() + " " + info.getSpecialtyName());
            }
        } else {
            out.print("无内容");
        }
    }

    //查询教师-课程-班级信息
    @Test
    public void t7() {
        List<TakenInfo> infoList = speCouService.selectTakenInfo(null, null);
        if (infoList != null) {
            for (TakenInfo info : infoList) {
                out.print(" " + info.getTeacherName() + " " + info.getCourseName() + " " + info.getSpecialtyName());
            }
        } else {
            out.print("无内容");
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
