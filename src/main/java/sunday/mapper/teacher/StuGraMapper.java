package sunday.mapper.teacher;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import sunday.pojo.teacher.GradeTaken;

import java.util.List;
import java.util.Map;

/**
 * 学生-成绩
 * Created by yang on 2017/5/27.
 * At 19:01
 */
@Repository
public interface StuGraMapper {
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
    int insertGrade(GradeTaken studentGrade);

    /**
     * 更新附加题成绩
     *
     * @param studentId
     * @param courseId
     * @param score
     * @return
     */
    int updateAnother(@Param("studentId") String studentId, @Param("courseId") String courseId, @Param("score") Byte score);
}
