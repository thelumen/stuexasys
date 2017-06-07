package sunday.service.lmp.teacher;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.mapper.teacher.TeaQueMapper;
import sunday.pojo.school.Another;
import sunday.pojo.school.SingleQuestion;
import sunday.pojo.school.TfQuestion;
import sunday.pojo.teacher.AnotherTaken;
import sunday.service.teacher.TeaQueService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/6/5.
 * At 15:24
 */
@Service("teaQueService")
public class TeaQueServiceImpl implements TeaQueService {

    @javax.annotation.Resource(name = "teaQueMapper")
    private TeaQueMapper teaQueMapper;

    @Override
    public List<SingleQuestion> selectSingleQuestion(Map<String, Object> params) {
        List<SingleQuestion> questions = teaQueMapper.selectSingleQuestion(params);
        if (null != questions && questions.size() > 0) {
            return questions;
        }
        return null;
    }

    @Override
    @Transactional
    public int insertSingleQuestion(SingleQuestion question) {
        return teaQueMapper.insertSingleQuestion(question);
    }

    @Override
    @Transactional
    public int insertTfQuestion(TfQuestion question) {
        return teaQueMapper.insertTfQuestion(question);
    }

    @Override
    @Transactional
    public int insertAnother(Another another) {
        return teaQueMapper.insertAnother(another);
    }

    @Override
    public List<AnotherTaken> selectAnother(Map<String, Object> params) {
        List<AnotherTaken> anotherTaken = teaQueMapper.selectAnother(params);
        if (null != anotherTaken && anotherTaken.size() > 0) {
            return anotherTaken;
        }
        return null;
    }
}
