import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.common.kit.RandomKit;
import sunday.pojo.school.Student;
import sunday.pojo.student.*;
import sunday.service.student.StudentService;

import java.util.*;

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
    public void t7() {
        ExamInfo examInfo = new ExamInfo();
        examInfo.setContent("1,2,4");
        Byte i = 1;
        Byte j = 2;
        Byte k = 3;
        //Map<String, String> changed = new HashMap<String, String>() {{
        //    put("1", "第一章");
        //    put("2", "第二章");
        //    put("3", "第三章");
        //    put("4", "第四章");
        //    put("5", "第五章");
        //    put("6", "第六章");
        //    put("7", "第七章");
        //    put("8", "第八章");
        //    put("9", "第九章");
        //}};
        //String[] strArray = examInfo.getContent().split(",");
        //StringBuilder sectionInfo = new StringBuilder();
        //for (int i = 0; i < strArray.length; ) {
        //    strArray[i] = changed.get(strArray[i]);
        //    sectionInfo.append("'");
        //    sectionInfo.append(strArray[i]);
        //    i++;
        //    if (i != strArray.length) {
        //        sectionInfo.append("',");
        //    } else sectionInfo.append("'");
        //}

        List<SingleTaken> singleTakenList = new ArrayList<>();
        SingleTaken singleTaken0 = new SingleTaken();
        SingleTaken singleTaken1 = new SingleTaken();
        SingleTaken singleTaken2 = new SingleTaken();
        SingleTaken singleTaken3 = new SingleTaken();
        SingleTaken singleTaken5 = new SingleTaken();
        SingleTaken singleTaken6 = new SingleTaken();
        SingleTaken singleTaken7 = new SingleTaken();
        SingleTaken singleTaken8 = new SingleTaken();
        SingleTaken singleTaken9 = new SingleTaken();
        SingleTaken singleTaken10 = new SingleTaken();

        singleTaken0.setLevels(i);
        singleTaken1.setLevels(j);
        singleTaken2.setLevels(k);
        singleTaken3.setLevels(i);
        singleTaken5.setLevels(i);
        singleTaken6.setLevels(i);
        singleTaken7.setLevels(j);
        singleTaken8.setLevels(i);
        singleTaken9.setLevels(k);
        singleTaken10.setLevels(k);

        singleTakenList.add(singleTaken0);
        singleTakenList.add(singleTaken1);
        singleTakenList.add(singleTaken2);
        singleTakenList.add(singleTaken3);
        singleTakenList.add(singleTaken5);
        singleTakenList.add(singleTaken6);
        singleTakenList.add(singleTaken7);
        singleTakenList.add(singleTaken8);
        singleTakenList.add(singleTaken9);
        singleTakenList.add(singleTaken10);

        singleTakenList.sort((o1, o2) -> {
            if (o1.getLevels() > o2.getLevels()) {
                return 1;
            }
            if (Objects.equals(o1.getLevels(), o2.getLevels())) {
                return 0;
            }
            return -1;
        });
        for (SingleTaken singleTaken4 : singleTakenList) {
            System.out.print(singleTaken4.getLevels());
        }

        Map<String, Integer> single_2 = new HashMap<>();
        int count_s = 0;
        Boolean startNotFind_s = true;//起始值 未找到（true）
        for (SingleTaken singleTaken : singleTakenList) {
            if (startNotFind_s && singleTaken.getLevels() == 2) {
                single_2.put("start", count_s);
                startNotFind_s = false;//起始值 已找到（false）
            }
            //查找结束值 找到后结束循环
            if (singleTaken.getLevels() == 3) {
                single_2.put("end", count_s - 1);
                break;
            }
            count_s++;
        }
        //简单难度的起始值为 0 , 结束值 等于 中等难度的起始值-1
        Map<String, Integer> single_1 = new HashMap<String, Integer>() {{
            put("start", 0);
            put("end", single_2.get("start") - 1);
        }};
        //困难难度的结束值为 列表长度, 起始值 等于 中等难度的结束值+1
        Map<String, Integer> single_3 = new HashMap<String, Integer>() {{
            put("start", (single_2.get("end") + 1));
            put("end", singleTakenList.size() - 1);
        }};
        System.out.println(single_1);
        System.out.println(single_2);
        System.out.println(single_3);

        HashSet<Integer> set_s_1 = new HashSet<>();
        HashSet<Integer> set_s_2 = new HashSet<>();
        HashSet<Integer> set_s_3 = new HashSet<>();
        HashSet<Integer> set_t_1 = new HashSet<>();
        HashSet<Integer> set_t_2 = new HashSet<>();
        HashSet<Integer> set_t_3 = new HashSet<>();
        int s_1 = 2;
        int s_2 = 14;
        int s_3 = 2;
        int t_1 = 1;
        int t_2 = 3;
        int t_3 = 1;

        set_s_1 = RandomKit.randomSet(single_1.get("start"), single_1.get("end"), s_1, set_s_1);
        assert set_s_1 != null;
        for (Integer aSet_s_1 : set_s_1) {
            System.out.println("value=" + aSet_s_1.toString());
        }


    }

    @Test
    //查询学生成绩
    public void t6() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", "140400000");
        }};
        List<GradeTaken> gradeTakens = studentService.selectGrade(null, params);
        for (GradeTaken gradeTaken : gradeTakens) {
            System.out.println(gradeTaken.toString());
        }

    }

    @Test
    //更新学生性别
    public void t5() {
        List<Student> studentList = studentService.select(null, null);
        for (Student student : studentList) {
            StudentInfo studentInfo = new StudentInfo();
            studentInfo.setStudentId(student.getStudentId());
            studentInfo.setGender("男");
            studentService.update(studentInfo);
            System.out.println(studentInfo.toString());
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
