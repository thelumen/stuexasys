package sunday.service.lmp.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.mapper.teacher.Student2GradeMapper;
import sunday.pojo.teacher.GradeTaken;
import sunday.service.teacher.Student2GradeService;

import java.util.List;
import java.util.Map;

/**
 * 学生-成绩
 * Created by yang on 2017/5/27.
 * At 18:56
 */
@Service("student2GradeService")
public class Student2GradeServiceImpl implements Student2GradeService {

    @javax.annotation.Resource(name = "student2GradeMapper")
    private Student2GradeMapper student2GradeMapper;

    @Override
    public List<GradeTaken> selectGradeTaken(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<GradeTaken> gradeTakens = student2GradeMapper.selectGradeTaken(params);
        if (null != gradeTakens && gradeTakens.size() > 0) {
            return gradeTakens;
        }
        return null;
    }

    @Override
    @Transactional
    public boolean updateGrade(GradeTaken studentGrade) {
        boolean result = false;
        if (student2GradeMapper.updateGrade(studentGrade) > 0) {
            result = true;
        }
        return result;
    }

    @Override
    @Transactional
    public boolean updateAnother(Integer studentId, Integer courseId, int score) {
        boolean result = false;
        if (student2GradeMapper.updateAnother(studentId, courseId, score) > 0) {
            result = true;
        }
        return result;
    }
}
