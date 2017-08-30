package sunday.service.lmp.teacher;

import org.springframework.stereotype.Service;
import sunday.mapper.teacher.Teacher2QuestionMapper;
import sunday.pojo.school.Another;
import sunday.pojo.school.SingleQuestion;
import sunday.pojo.school.TfQuestion;
import sunday.pojo.teacher.AnotherTaken;
import sunday.service.teacher.Teacher2QuestionService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/6/5.
 * At 15:24
 */
@Service("teacher2QuestionService")
public class Teacher2QuestionServiceImpl implements Teacher2QuestionService {

    @javax.annotation.Resource(name = "teacher2QuestionMapper")
    private Teacher2QuestionMapper teacher2QuestionMapper;

    @Override
    public List<SingleQuestion> selectSingleQuestion(Map<String, Object> params) {
        List<SingleQuestion> questions = teacher2QuestionMapper.selectSingleQuestion(params);
        if (null != questions && questions.size() > 0) {
            return questions;
        }
        return null;
    }

    @Override
    public int insertSingleQuestion(SingleQuestion question) {
        return teacher2QuestionMapper.insertSingleQuestion(question);
    }

    @Override
    public int insertTfQuestion(TfQuestion question) {
        return teacher2QuestionMapper.insertTfQuestion(question);
    }

    @Override
    public int insertAnother(Another another) {
        return teacher2QuestionMapper.insertAnother(another);
    }

    @Override
    public List<AnotherTaken> selectAnother(Map<String, Object> params) {
        List<AnotherTaken> anotherTaken = teacher2QuestionMapper.selectAnother(params);
        if (null != anotherTaken && anotherTaken.size() > 0) {
            return anotherTaken;
        }
        return null;
    }
}
