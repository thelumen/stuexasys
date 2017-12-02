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
     * 查询选择题
     *
     * @param params
     * @return
     */
    List<SingleQuestion> selectSingleQuestion(Map<String, Object> params);

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

    List<TfQuestion> selectTfInfo(Page page, Map<String, Object> params);

    boolean updateTfInfo(TfQuestion tfQuestion);

    boolean deleteTfInfo(TfQuestion tfQuestion);

    List<SingleQuestion> selectSingleInfo(Page page, Map<String, Object> params);

    boolean updateSingleInfo(SingleQuestion singleQuestion);

    boolean deleteSingleInfo(SingleQuestion singleQuestion);
}
