package yang.service.impl.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import yang.domain.common.Another;
import yang.domain.common.SingleQuestion;
import yang.domain.common.TfQuestion;
import yang.domain.teacher.AnotherTaken;
import yang.service.common.CommonService;
import yang.service.teacher.Teacher2QuestionService;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/6/5
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
    public boolean insertSingleQuestion(SingleQuestion question) {
        return teacher2QuestionMapper.insertSingleQuestion(question) > 0;
    }

    @Override
    public boolean insertTfQuestion(TfQuestion question) {
        return teacher2QuestionMapper.insertTfQuestion(question) > 0;
    }

    @Override
    public boolean insertAnother(Another another) {
        return teacher2QuestionMapper.insertAnother(another) > 0;
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
