package yang.service.impl.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yang.dao.teacher.Student2GradeMapper;
import yang.domain.teacher.GradeTaken;
import yang.service.teacher.Student2GradeService;

import java.util.List;
import java.util.Map;

/**
 * 学生-成绩
 *
 * @author yang
 * @date 2017/5/27
 * At 18:56
 */
@Service("student2GradeService")
public class Student2GradeServiceImpl implements Student2GradeService {

    @Autowired
    protected Student2GradeMapper mapper;

    @Override
    public List<GradeTaken> selectGradeTaken(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<GradeTaken> gradeTakens = mapper.selectGradeTaken(params);
        if (null != gradeTakens && gradeTakens.size() > 0) {
            return gradeTakens;
        }
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateGrade(GradeTaken studentGrade) {
        return mapper.updateGrade(studentGrade) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateAnother(Integer studentId, Integer courseId, int score) {
        return mapper.updateAnother(studentId, courseId, score) > 0;
    }
}
