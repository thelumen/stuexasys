import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.pojo.school.Student;
import sunday.pojo.teacher.GradeTaken;
import sunday.service.student.StudentService;

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

    @Test
    //查询学生成绩
    public void t6() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", "140400000");
        }};
        List<GradeTaken> gradeTakens = studentService.selectGrade(null, params);
        for (GradeTaken gradeTaken:gradeTakens){
            System.out.println(gradeTaken.toString());
        }

    }

    @Test
    //更新学生性别
    public void t5() {
        List<Student> studentList = studentService.select(null, null);
        for (Student student : studentList) {
            student.setGender("0");
            studentService.update(student);
            System.out.println(student.toString());
        }
    }

    @Test
    //插入学生专业
    public void t4() {
        List<Student> studentList = studentService.select(null, null);
        for (Student student : studentList) {
            studentService.insertStudentSpecialty(student);
            System.out.println(student.toString());
        }
    }

    @Test
    //录入学生成绩
    public void t3() {
        List<Student> studentList = studentService.select(null, null);
        for (int i = 0; i < 8; i++) {
            String courseId = "1000000" + i;
            for (Student student : studentList) {
                Map<String, Object> params = new HashMap<String, Object>() {{
                    put("studentId", student.getStudentId());
                    put("courseId", courseId);
                    put("grade1", Integer.toString((int) ((Math.random()) * 100)));
                    put("grade2", Integer.toString((int) ((Math.random()) * 100)));
                    put("grade3", Integer.toString((int) ((Math.random()) * 100)));
                    put("grade4", Integer.toString((int) ((Math.random()) * 100)));
                }};
                studentService.insertGrade(params);
                System.out.println(params.toString());
            }
        }
    }

    @Test
    //插入学生
    public void t2() {
        Student student = new Student();
        for (int i = 0; i < 6; i++) {
            String specialtyId = "14040" + i;
            student.setSpecialtyId(specialtyId);
            for (int j = 0; j < 10; j++) {
                String studentId = "14040" + i + "0" + i + j;
                student.setStudentId(studentId);
                student.setPassword("827ccb0eea8a706c4c34a16891f84e7b");
                studentService.insertStudent(student);
                System.out.println(student.toString());
            }
        }
    }

    @Test
    //查询学生
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
