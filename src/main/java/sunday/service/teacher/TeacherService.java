package sunday.service.teacher;

import com.github.pagehelper.Page;
import sunday.pojo.teacher.Teacher;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:33
 */
public interface TeacherService {

    /**
     * 新增教师
     *
     * @param teacher
     * @return
     */
    int insert(Teacher teacher);

    /**
     * 查询教师
     *
     * @param page
     * @param params
     * @return
     */
    List<Teacher> select(Page page, Map<String, Object> params);

    /**
     * 修改教师信息
     *
     * @param teacher
     * @return
     */
    boolean update(Teacher teacher);
}
