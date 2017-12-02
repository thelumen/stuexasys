package yang.service.impl.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yang.domain.teacher.Teacher;
import yang.service.common.CommonService;
import yang.service.teacher.TeacherService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:33
 */
@Service("teacherService")
public class TeacherServiceImpl extends CommonService implements TeacherService {

    @Override
    public int insert(Teacher teacher) {
        return teacherMapper.insert(teacher);
    }

    @Override
    public List<Teacher> select(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<Teacher> teachers = teacherMapper.select(params);
        if (null != teachers && teachers.size() > 0) {
            return teachers;
        }
        return null;
    }

    @Override
    @Transactional
    public boolean update(Teacher teacher) {
        return teacherMapper.update(teacher) > 0;
    }

    @Override
    @Transactional
    public boolean delete(int teacherId) {
        return teacherMapper.delete(teacherId) > 0;
    }

}
