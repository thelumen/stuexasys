package sunday.service;

import com.github.pagehelper.Page;
import sunday.pojo.Teacher;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:33
 */
public interface TeacherService {
    /**
     * 查询教师
     *
     * @param page
     * @param params
     * @return
     */
    List<Teacher> select(Page page, Map<String, Object> params);
}
