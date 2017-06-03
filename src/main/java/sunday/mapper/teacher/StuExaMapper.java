package sunday.mapper.teacher;

import org.springframework.stereotype.Repository;
import sunday.pojo.teacher.ExamTaken;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/6/2.
 * At 9:36
 */
@Repository
public interface StuExaMapper {
    /**
     * 新增考试信息
     *
     * @param exam
     * @return
     */
    int insertExamInfo(ExamTaken exam);

    /**
     * 查询考试信息
     *
     * @param params
     * @return
     */
    List<ExamTaken> selectExamTaken(Map<String, Object> params);

    /**
     * 更新考试信息
     *
     * @param examInfo
     * @return
     */
    int updateExamInfo(ExamTaken examInfo);
}
