package yang.dao.teacher;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import yang.domain.teacher.GradeTaken;

import java.util.List;
import java.util.Map;

/**
 * 学生-成绩
 * Created by yang on 2017/5/27.
 * At 19:01
 */
@Repository
public interface Student2GradeMapper {
    /**
     * 查询学生成绩
     *
     * @param params
     * @return
     */
    List<GradeTaken> selectGradeTaken(Map<String, Object> params);

    /**
     * 更新学生成绩
     *
     * @param studentGrade
     * @return
     */
    int updateGrade(GradeTaken studentGrade);

    /**
     * 更新附加题成绩
     *
     * @param studentId
     * @param courseId
     * @param score
     * @return
     */
    int updateAnother(@Param("studentId") Integer studentId, @Param("courseId") Integer courseId, @Param("score") int score);
}
