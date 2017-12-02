package yang.dao.teacher;

import org.springframework.stereotype.Repository;
import yang.domain.teacher.AnotherTaken;

import java.util.List;
import java.util.Map;

/**
 * Created by 花间一壶酒 on 2017/9/6.
 */
@Repository
public interface QuestionMapper {

    /**
     * 删除简答题
     *
     * @param params .
     * @return .
     */
    int deleteAnotherQuestion(Map<String,Object> params);

    /**
     * 更新简答题
     *
     * @param anotherTaken .
     * @return .
     */
    int updateAnotherQuestion(AnotherTaken anotherTaken);

    /**
     * 查询简答题
     *
     * @param params .
     * @return .
     */
    List<AnotherTaken> selectAnotherQuestionWithCourse(Map<String,Object> params);
}
