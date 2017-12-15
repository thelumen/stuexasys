package yang.service.impl.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yang.dao.teacher.Student2ExamMapper;
import yang.domain.teacher.ExamTaken;
import yang.service.teacher.Student2ExamService;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/6/2
 * At 9:32
 */
@Service("student2ExamService")
public class Student2ExamServiceImpl implements Student2ExamService {

    @Autowired
    protected Student2ExamMapper mapper;

    @Override
    public boolean insertExamInfo(ExamTaken exam) {
        return mapper.insertExamInfo(exam) > 0;
    }

    @Override
    public List<ExamTaken> selectExamTaken(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<ExamTaken> examTakens = mapper.selectExamTaken(params);
        if (null != examTakens && examTakens.size() > 0) {
            return examTakens;
        }
        return null;
    }

    @Override
    public boolean updateExamInfo(ExamTaken examInfo) {
        return mapper.updateExamInfo(examInfo) > 0;
    }

    @Override
    public boolean deleteExamInfo(Map<String, Object> params) {
        return mapper.deleteExamInfo(params) > 0;
    }

    @Override
    public List<ExamTaken> selectTableExamInfo(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<ExamTaken> examTakens = mapper.selectTableExamInfo(params);
        if (null != examTakens && examTakens.size() > 0) {
            return examTakens;
        }
        return null;
    }

    @Override
    public boolean startOrCloseExam(Map<String, Object> params) {
        return mapper.startOrCloseExam(params) > 0;
    }
}
