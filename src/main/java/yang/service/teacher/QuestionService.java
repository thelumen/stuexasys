package yang.service.teacher;

import yang.domain.teacher.AnotherTaken;

import java.util.List;
import java.util.Map;

/**
 * @author 花间一壶酒
 * @date 2017/9/5
 */
public interface QuestionService {

    /**
     * 保存简答题更改
     *
     * @param anotherTaken .
     * @return .
     */
    boolean saveQuestion(AnotherTaken anotherTaken);

    /**
     * 删除题目
     *
     * @param params .
     * @return .
     */
    boolean delQuestion(Map<String, Object> params);

    /**
     * 查询简答题
     *
     * @param params .
     * @return .
     */
    List<AnotherTaken> selectAnotherQuestion(Map<String, Object> params);
}
