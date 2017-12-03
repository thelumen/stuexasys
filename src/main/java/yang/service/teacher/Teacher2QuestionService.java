package yang.service.teacher;

import com.github.pagehelper.Page;
import yang.domain.common.Another;
import yang.domain.common.SingleQuestion;
import yang.domain.common.TfQuestion;
import yang.domain.teacher.AnotherTaken;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/6/5
 * At 15:24
 */
public interface Teacher2QuestionService {

    /**
     * 新增选择题
     *
     * @param question
     * @return
     */
    boolean insertSingleQuestion(SingleQuestion question);

    /**
     * 新增判断题
     *
     * @param question
     * @return
     */
    boolean insertTfQuestion(TfQuestion question);

    /**
     * 新增附加题
     *
     * @param another
     * @return
     */
    boolean insertAnother(Another another);

    /**
     * 查询附加题
     *
     * @param params
     * @return
     */
    List<AnotherTaken> selectAnother(Map<String, Object> params);

    /**
     * 查询判断题
     *
     * @param page
     * @param params
     * @return
     */
    List<TfQuestion> selectTfInfo(Page page, Map<String, Object> params);

    /**
     * 更新判断题
     *
     * @param tfQuestion
     * @return
     */
    boolean updateTfInfo(TfQuestion tfQuestion);

    /**
     * 删除判断题
     *
     * @param tfQuestion
     * @return
     */
    boolean deleteTfInfo(TfQuestion tfQuestion);

    /**
     * 查询选择题
     *
     * @param page
     * @param params
     * @return
     */
    List<SingleQuestion> selectSingleInfo(Page page, Map<String, Object> params);

    /**
     * 更新选择题
     *
     * @param singleQuestion
     * @return
     */
    boolean updateSingleInfo(SingleQuestion singleQuestion);

    /**
     * 删除选择题
     *
     * @param singleQuestion
     * @return
     */
    boolean deleteSingleInfo(SingleQuestion singleQuestion);
}
