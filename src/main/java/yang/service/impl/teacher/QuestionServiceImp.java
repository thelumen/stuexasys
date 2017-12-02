package yang.service.impl.teacher;

import org.springframework.stereotype.Service;
import yang.domain.teacher.AnotherTaken;
import yang.service.common.CommonService;
import yang.service.teacher.QuestionService;

import java.util.List;
import java.util.Map;

/**
 * Created by 花间一壶酒 on 2017/9/5.
 */

@Service("questionService")
public class QuestionServiceImp extends CommonService implements QuestionService{


    @Override
    public boolean saveQuestion(AnotherTaken anotherTaken) {
        return questionMapper.updateAnotherQuestion(anotherTaken)>0;
    }

    @Override
    public boolean delQuestion(Map<String,Object> params) {
        return questionMapper.deleteAnotherQuestion(params)>0;
    }

    @Override
    public List<AnotherTaken> selectAnotherQuestion(Map<String,Object> params) {
        return questionMapper.selectAnotherQuestionWithCourse(params);
    }
}
