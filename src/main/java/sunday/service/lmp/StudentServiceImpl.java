package sunday.service.lmp;

import com.github.pagehelper.Page;
import org.springframework.stereotype.Service;
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
    @Override
    public List<Student> select(Page page, Map<String, Object> params) {
        return null;
    }
}
