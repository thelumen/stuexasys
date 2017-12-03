package yang.service.impl.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yang.dao.teacher.Teacher2QuestionMapper;
import yang.domain.common.Another;
import yang.domain.common.SingleQuestion;
import yang.domain.common.TfQuestion;
import yang.domain.teacher.AnotherTaken;
import yang.service.teacher.Teacher2QuestionService;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/6/5
 * At 15:24
 */
@Service("teacher2QuestionService")
public class Teacher2QuestionServiceImpl implements Teacher2QuestionService {

    @Autowired
    protected Teacher2QuestionMapper mapper;

    @Override
    public boolean insertSingleQuestion(SingleQuestion question) {
        return mapper.insertSingleQuestion(question) > 0;
    }

    @Override
    public boolean insertTfQuestion(TfQuestion question) {
        return mapper.insertTfQuestion(question) > 0;
    }

    @Override
    public boolean insertAnother(Another another) {
        return mapper.insertAnother(another) > 0;
    }

    @Override
    public List<AnotherTaken> selectAnother(Map<String, Object> params) {
        List<AnotherTaken> anotherTaken = mapper.selectAnother(params);
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
        List<TfQuestion> tfs = mapper.selectTfInfo(params);
        if (null != tfs && tfs.size() > 0) {
            return tfs;
        }
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateTfInfo(TfQuestion tfQuestion) {
        return mapper.updateTfInfo(tfQuestion);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteTfInfo(TfQuestion tfQuestion) {
        return mapper.deleteTfInfo(tfQuestion);
    }

    @Override
    public List<SingleQuestion> selectSingleInfo(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<SingleQuestion> singleQuestionList = mapper.selectSingleInfo(params);
        if (null != singleQuestionList && singleQuestionList.size() > 0) {
            return singleQuestionList;
        }
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSingleInfo(SingleQuestion singleQuestion) {
        return mapper.updateSingleInfo(singleQuestion);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteSingleInfo(SingleQuestion singleQuestion) {
        return mapper.deleteSingleInfo(singleQuestion);
    }
}
