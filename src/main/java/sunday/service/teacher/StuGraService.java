package sunday.service.teacher;

import com.github.pagehelper.Page;
import sunday.pojo.teacher.GradeTaken;

import java.util.List;
import java.util.Map;

/**
 * 学生-成绩
 * Created by yang on 2017/5/27.
 * At 18:56
 */
public interface StuGraService {
    /**
     * 查询学生成绩信息
     *
     * @param page
     * @param params
     * @return
     */
    List<GradeTaken> selectGradeTaken(Page page, Map<String, Object> params);

    /**
     * 更新成绩
     *
     * @param studentGrade
     * @return
     */
    boolean updateGrade(GradeTaken studentGrade);

    /**
     * 更新附加题成绩
     *
     * @param studentId
     * @param courseId
     * @param score
     * @return
     */
    boolean updateAnother(Integer studentId, Integer courseId, int score);
}
