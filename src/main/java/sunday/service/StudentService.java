package sunday.service;

import com.github.pagehelper.Page;
import sunday.pojo.Student;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:35
 */
public interface StudentService {
    /**
     * 查询学生
     *
     * @param page
     * @param params
     * @return
     */
    List<Student> select(Page page, Map<String, Object> params);
}