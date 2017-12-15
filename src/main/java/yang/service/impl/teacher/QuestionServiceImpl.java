package yang.service.impl.teacher;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yang.dao.teacher.QuestionMapper;
import yang.domain.teacher.AnotherTaken;
import yang.service.teacher.QuestionService;

import java.util.List;
import java.util.Map;

/**
 * @author 花间一壶酒
 * @date 2017/9/5
 */
@Service("questionService")
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    protected QuestionMapper mapper;

    @Override
    public boolean saveQuestion(AnotherTaken anotherTaken) {
        return mapper.updateAnotherQuestion(anotherTaken) > 0;
    }

    @Override
    public boolean delQuestion(Map<String, Object> params) {
        return mapper.deleteAnotherQuestion(params) > 0;
    }

    @Override
    public List<AnotherTaken> selectAnotherQuestion(Map<String, Object> params) {
        return mapper.selectAnotherQuestionWithCourse(params);
    }
}
