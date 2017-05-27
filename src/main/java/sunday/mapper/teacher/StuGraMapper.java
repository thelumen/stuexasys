package sunday.mapper.teacher;

import org.springframework.stereotype.Repository;
import sunday.pojo.GradeTaken;

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
}
