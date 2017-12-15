package yang.service.impl.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yang.dao.teacher.TeacherMapper;
import yang.domain.teacher.Teacher;
import yang.service.teacher.TeacherService;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/5/22
 * At 17:33
 */
@Service("teacherService")
public class TeacherServiceImpl implements TeacherService {

    @Autowired
    protected TeacherMapper mapper;

    @Override
    public int insert(Teacher teacher) {
        return mapper.insert(teacher);
    }

    @Override
    public List<Teacher> select(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<Teacher> teachers = mapper.select(params);
        if (null != teachers && teachers.size() > 0) {
            return teachers;
        }
        return null;
    }

    @Override
    public boolean update(Teacher teacher) {
        return mapper.update(teacher) > 0;
    }

    @Override
    public boolean delete(int teacherId) {
        return mapper.delete(teacherId) > 0;
    }

}
