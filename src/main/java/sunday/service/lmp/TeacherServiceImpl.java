package sunday.service.lmp;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import sunday.mapper.TeacherMapper;
import sunday.pojo.Teacher;
import sunday.service.TeacherService;

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
