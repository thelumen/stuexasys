package sunday.service;

import sunday.pojo.GradeTaken;

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
     * @param params
     * @return
     */
    List<GradeTaken> selectGradeTaken(Map<String, Object> params);
}
