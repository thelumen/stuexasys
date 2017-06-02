package sunday.service.student;

import com.github.pagehelper.Page;
import sunday.pojo.school.Student;
import sunday.pojo.student.CourseTaken;
import sunday.pojo.student.GradeTaken;
import sunday.pojo.student.StudentInfo;
import sunday.pojo.student.StudentTaken;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:35
 */
public interface StudentService {
    /**
     * 查询学生
     *
     * @param page   .
     * @param params .
     * @return List<Student>
     */
    List<Student> select(Page page, Map<String, Object> params);

    /**
     * 查询学生详细信息
     *
     *@param page   .
     * @param params .
     * @return List<Student>
     */
    List<StudentTaken> selectStudentInfo(Page page, Map<String, Object> params);

    /**
     * 查询学生成绩信息
     *
     * @param page   .
     * @param params .
     * @return List<GradeTaken>
     */
    List<GradeTaken> selectGrade(Page page, Map<String, Object> params);

    /**
     * 查询学生成绩信息
     *
     * @param page   .
     * @param params .
     * @return List<GradeTaken>
     */
    List<CourseTaken> selectCourse(Page page, Map<String, Object> params);

    /**
     * 新增学生
     *
     * @param student .
     * @return int
     */
    int insertStudent(Student student);

    /**
     * 插入学生成绩
     *
     * @param params 参数.
     * @return int 插入成功的行数
     */
    int insertGrade(Map<String, Object> params);

    /**
     * 插入学生专业
     *
     * @param student .
     * @return int
     */
    int insertStudentSpecialty(Student student);

    /**
     * 更新学生信息
     *
     * @param studentInfo .
     * @return int
     */
    Boolean update(StudentInfo studentInfo);
}
