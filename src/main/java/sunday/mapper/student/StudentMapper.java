package sunday.mapper.student;

import org.springframework.stereotype.Repository;
import sunday.pojo.school.Student;
import sunday.pojo.student.*;

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
     * 查询题库（选择题）
     *
     * @param params .
     * @return List<SingleTaken>
     */
    List<SingleTaken> selectQuestionBaseSingle(Map<String, Object> params);

    /**
     * 查询题库（判断题）
     *
     * @param params .
     * @return List<TfTaken>
     */
    List<TfTaken> selectQuestionBaseTf(Map<String, Object> params);

    /**
     * 查询题库（附加题）
     *
     * @param params .
     * @return List<AnotherQuestionTaken>
     */
    List<AnotherTestTaken> selectQuestionBaseAnother(Map<String, Object> params);

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
     * 增加学生与权限关联
     *
     * @param student .
     * @return int
     */
    int insertStudentRole(Student student);
    /**
     * 新增学生成绩
     * 针对测试一
     * @param params .
     * @return int
     */
    int insertGrade(Map<String, Object> params);

    /**
     * 更新学生成绩
     * 针对测试二和三
     * @param params .
     * @return int
     */
    int updateGrade(Map<String, Object> params);

    /**
     * 查询学生附加题信息
     *
     * @param params .
     * @return AnotherTestTaken
     */
    AnotherTestTaken selectStudentAnotherQuestionInfo(Map<String, Object> params);

    /**
     * 插入学生附加题答案
     *  针对测试四
     * @param params .
     * @return int
     */
    int insertAnotherResult(Map<String, Object> params);

    /**
     * 更新学生附加题答案
     * @param params .
     * @return int
     */
    int updateAnotherResult(Map<String, Object> params);

    /**
     * 更新学生信息
     *
     * @param params .
     * @return int
     */
    int update(Map<String, Object> params);

    /**
     * 删除学生信息
     *
     * @param params .
     * @return .
     */
    int delete(Map<String, Object> params);
}
