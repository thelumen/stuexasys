package sunday.service.teacher;

import com.github.pagehelper.Page;
import sunday.pojo.teacher.ExamTaken;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/6/2.
 * At 9:22
 */
public interface StuExaService {
    /**
     * 新增考试信息
     *
     * @param exam
     * @return
     */
    int insertExamInfo(ExamTaken exam);

    /**
     * 获取考试信息
     *
     * @param page
     * @param params
     * @return
     */
    List<ExamTaken> selectExamTaken(Page page, Map<String, Object> params);

    /**
     * 更新考试信息
     *
     * @param examInfo
     * @return
     */
    int updateExamInfo(ExamTaken examInfo);

    /**
     * 删除考试信息
     *
     * @param id
     * @return
     */
    boolean deleteExamInfo(String id);

    /**
     * 获取modal中table的考试信息
     *
     * @return
     */
    List<ExamTaken> selectTableExamInfo();
}
