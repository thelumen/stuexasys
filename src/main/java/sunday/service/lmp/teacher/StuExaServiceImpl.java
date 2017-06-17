package sunday.service.lmp.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.mapper.teacher.StuExaMapper;
import sunday.pojo.teacher.ExamTaken;
import sunday.service.teacher.StuExaService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/6/2.
 * At 9:32
 */
@Service("stuExaService")
public class StuExaServiceImpl implements StuExaService {

    @javax.annotation.Resource(name = "stuExaMapper")
    private StuExaMapper stuExaMapper;

    @Override
    public int insertExamInfo(ExamTaken exam) {
        return stuExaMapper.insertExamInfo(exam);
    }

    @Override
    public List<ExamTaken> selectExamTaken(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<ExamTaken> examTakens = stuExaMapper.selectExamTaken(params);
        if (null != examTakens && examTakens.size() > 0) {
            return examTakens;
        }
        return null;
    }

    @Override
    @Transactional
    public int updateExamInfo(ExamTaken examInfo) {
        return stuExaMapper.updateExamInfo(examInfo);
    }

    @Override
    @Transactional
    public boolean deleteExamInfo(String id) {
        boolean result = false;
        if (stuExaMapper.deleteExamInfo(id) > 0) {
            result = true;
        }
        return result;
    }

    @Override
    public List<ExamTaken> selectTableExamInfo() {
        List<ExamTaken> examTakens = stuExaMapper.selectTableExamInfo();
        if (null != examTakens && examTakens.size() > 0) {
            return examTakens;
        }
        return null;
    }

    @Override
    @Transactional
    public boolean startOrCloseExam(Map<String, Object> params) {
        boolean result = false;
        if (stuExaMapper.startOrCloseExam(params) > 0) {
            result = true;
        }
        return result;
    }
}
