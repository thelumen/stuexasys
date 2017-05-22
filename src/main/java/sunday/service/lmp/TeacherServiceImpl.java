package sunday.service.lmp;

import com.github.pagehelper.Page;
import org.springframework.stereotype.Service;
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
    @Override
    public List<Teacher> select(Page page, Map<String, Object> params) {
        return null;
    }
}
