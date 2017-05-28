package sunday.service.lmp.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.mapper.teacher.TeacherMapper;
import sunday.pojo.teacher.Teacher;
import sunday.service.teacher.TeacherService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:33
 */
@Service("teacherService")
public class TeacherServiceImpl implements TeacherService {
    @javax.annotation.Resource(name = "teacherMapper")
    private TeacherMapper teacherMapper;

    @Override
    @Transactional
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
}
