package sunday.mapper.student;

import org.springframework.stereotype.Repository;
import sunday.pojo.school.Student;
import sunday.pojo.student.CourseTaken;
import sunday.pojo.student.ExamTaken;
import sunday.pojo.student.GradeTaken;
import sunday.pojo.student.StudentTaken;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/24.
 * At 8:56
 */
@Repository
public interface StudentMapper {

    /**
     * 查询学生
     *
     * @param params .
     * @return List<Student>
     */
    List<Student> select(Map<String, Object> params);

    /**
     * 查询学生详细信息
     *
     * @param params .
     * @return List<Student>
     */
    List<StudentTaken> selectStudentInfo(Map<String, Object> params);

    /**
     * 查询学生成绩信息
     *
     * @param params .
     * @return List<GradeTaken>
     */
    List<GradeTaken> selectGrade(Map<String, Object> params);

    /**
     * 查询学生考试信息
     *
     * @param params .
     * @return List<ExamTaken>
     */
    List<ExamTaken> selectExamInfo(Map<String, Object> params);

    /**
     * 查询学生课程信息
     *
     * @param params .
     * @return List<CourseTaken>
     */
    List<CourseTaken> selectCourse(Map<String, Object> params);

    /**
     * 新增学生
     *
     * @param student .
     * @return int
     */
    int insertStudent(Student student);

    /**
     * 新增学生成绩
     *
     * @param params .
     * @return List<Student>
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
     * @param params .
     * @return int
     */
    int update(Map<String, Object> params);
}
