package sunday.service.lmp;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import sunday.mapper.StudentMapper;
import sunday.pojo.Student;
import sunday.service.StudentService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:35
 */
@Service("studentService")
public class StudentServiceImpl implements StudentService {

    @javax.annotation.Resource(name = "studentMapper")
    private StudentMapper studentMapper;

    @Override
    public List<Student> select(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<Student> students = studentMapper.select(params);
        if (null != students && students.size() > 0) {
            return students;
        }
        return null;
    }
}
