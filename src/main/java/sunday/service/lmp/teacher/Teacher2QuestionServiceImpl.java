package sunday.service.lmp.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import sunday.mapper.teacher.Teacher2QuestionMapper;
import sunday.pojo.school.Another;
import sunday.pojo.school.SingleQuestion;
import sunday.pojo.school.TfQuestion;
import sunday.pojo.student.TfTaken;
import sunday.pojo.teacher.AnotherTaken;
import sunday.service.common.CommonService;
import sunday.service.teacher.Teacher2QuestionService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/6/5.
 * At 15:24
 */
@Service("teacher2QuestionService")
public class Teacher2QuestionServiceImpl extends CommonService implements Teacher2QuestionService {

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

    @Override
    public List<TfQuestion> selectTfInfo(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<TfQuestion> tfs = teacher2QuestionMapper.selectTfInfo(params);
        if (null != tfs && tfs.size() > 0) {
            return tfs;
        }
        return null;
    }

    @Override
    public boolean updateTfInfo(TfQuestion tfQuestion) {
        return teacher2QuestionMapper.updateTfInfo(tfQuestion);
    }

    @Override
    public boolean deleteTfInfo(TfQuestion tfQuestion) {
        return teacher2QuestionMapper.deleteTfInfo(tfQuestion);
    }

    @Override
    public List<SingleQuestion> selectSingleInfo(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<SingleQuestion> singleQuestionList = teacher2QuestionMapper.selectSingleInfo(params);
        if (null != singleQuestionList && singleQuestionList.size() > 0) {
            return singleQuestionList;
        }
        return null;
    }

    @Override
    public boolean updateSingleInfo(SingleQuestion singleQuestion) {
        return teacher2QuestionMapper.updateSingleInfo(singleQuestion);
    }

    @Override
    public boolean deleteSingleInfo(SingleQuestion singleQuestion) {
        return teacher2QuestionMapper.deleteSingleInfo(singleQuestion);
    }
}
