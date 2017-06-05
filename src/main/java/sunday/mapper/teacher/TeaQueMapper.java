package sunday.mapper.teacher;

import org.springframework.stereotype.Repository;
import sunday.pojo.school.SingleQuestion;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/6/5.
 * At 15:25
 */
@Repository
public interface TeaQueMapper {
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
}
