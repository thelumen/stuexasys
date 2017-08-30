package sunday.service.teacher;

import sunday.pojo.school.Another;
import sunday.pojo.school.SingleQuestion;
import sunday.pojo.school.TfQuestion;
import sunday.pojo.teacher.AnotherTaken;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/6/5.
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
    int insertSingleQuestion(SingleQuestion question);

    /**
     * 新增判断题
     *
     * @param question
     * @return
     */
    int insertTfQuestion(TfQuestion question);

    /**
     * 新增附加题
     *
     * @param another
     * @return
     */
    int insertAnother(Another another);

    /**
     * 查询附加题
     *
     * @param params
     * @return
     */
    List<AnotherTaken> selectAnother(Map<String, Object> params);
}
