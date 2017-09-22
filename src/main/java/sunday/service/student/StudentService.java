package sunday.service.student;

import com.github.pagehelper.Page;
import sunday.pojo.school.Student;
import sunday.pojo.student.*;

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
     * @param page   .
     * @param params .
     * @return List<Student>
     */
    List<StudentTaken> selectStudentInfo(Page page, Map<String, Object> params);

    /**
     * 查询学生成绩信息
     *
     * @param params .
     * @return List<GradeTaken>
     */
    List<GradeTaken> selectGrade(Map<String, Object> params);

    /**
     * 查询学生课程信息
     *
     * @param params .
     * @return List<GradeTaken>
     */
    List<CourseTaken> selectCourse(Map<String, Object> params);

    /**
     * 查询学生考试信息
     *
     * @param params .
     * @return List<ExamInfo>
     */
    List<ExamInfo> selectExamInfo(Map<String, Object> params);

    /**
     * 通过 courseId 组卷并返回集合对象( 附加 )
     *
     *@param studentId .
     * @param examInfo .
     * @return TestPaper
     */
    TestPaper selectTestPaperAnother(int studentId, ExamInfo examInfo);

    /**
     * 插入学生成绩
     *
     * @param gradeInfo 参数.
     * @return int 插入成功的行数
     */
    boolean insertGrade(GradeInfo gradeInfo);

    /**
     * 更新学生信息
     *
     * @param studentInfo .
     * @return int
     */
    boolean update(StudentInfo studentInfo);

    /**
     * 删除学生信息
     *
     * @param params .
     * @return .
     */
    boolean delete(Map<String, Object> params);

    /**
     * 通过 courseId, content 组卷并返回集合对象( 普通 )
     *
     * @param examInfo .
     * @return .
     */
    TestPaper selectQuestion(ExamInfo examInfo);

    /**
     * 检查考试是否为开启状态
     *
     * @param gradeInfo 成绩信息.
     * @return 开启状态.
     */
    boolean checkTestStart(GradeInfo gradeInfo);
}
