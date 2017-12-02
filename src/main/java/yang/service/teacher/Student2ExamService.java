package yang.service.teacher;

import com.github.pagehelper.Page;
import yang.domain.teacher.ExamTaken;

import java.util.List;
import java.util.Map;

/**
 *
 * @author yang
 * @date 2017/6/2
 * At 9:22
 */
public interface Student2ExamService {
    /**
     * 新增考试信息
     *
     * @param exam
     * @return
     */
    boolean insertExamInfo(ExamTaken exam);

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
    boolean updateExamInfo(ExamTaken examInfo);

    /**
     * 删除考试信息
     *
     * @param params
     * @return
     */
    boolean deleteExamInfo(Map<String, Object> params);

    /**
     * 获取modal中table的考试信息
     *
     * @param page
     * @param params
     * @return
     */
    List<ExamTaken> selectTableExamInfo(Page page, Map<String, Object> params);

    /**
     * 开启考试
     *
     * @param params
     * @return
     */
    boolean startOrCloseExam(Map<String, Object> params);
}
