package sunday.service.lmp.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.mapper.teacher.Student2ExamMapper;
import sunday.pojo.teacher.ExamTaken;
import sunday.service.common.CommonService;
import sunday.service.teacher.Student2ExamService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/6/2.
 * At 9:32
 */
@Service("student2ExamService")
public class Student2ExamServiceImpl extends CommonService implements Student2ExamService {

    @Override
    public int insertExamInfo(ExamTaken exam) {
        return student2ExamMapper.insertExamInfo(exam);
    }

    @Override
    public List<ExamTaken> selectExamTaken(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<ExamTaken> examTakens = student2ExamMapper.selectExamTaken(params);
        if (null != examTakens && examTakens.size() > 0) {
            return examTakens;
        }
        return null;
    }

    @Override
    @Transactional
    public int updateExamInfo(ExamTaken examInfo) {
        return student2ExamMapper.updateExamInfo(examInfo);
    }

    @Override
    @Transactional
    public boolean deleteExamInfo(String id) {
        boolean result = false;
        if (student2ExamMapper.deleteExamInfo(id) > 0) {
            result = true;
        }
        return result;
    }

    @Override
    public List<ExamTaken> selectTableExamInfo() {
        List<ExamTaken> examTakens = student2ExamMapper.selectTableExamInfo();
        if (null != examTakens && examTakens.size() > 0) {
            return examTakens;
        }
        return null;
    }

    @Override
    @Transactional
    public boolean startOrCloseExam(Map<String, Object> params) {
        boolean result = false;
        if (student2ExamMapper.startOrCloseExam(params) > 0) {
            result = true;
        }
        return result;
    }
}
