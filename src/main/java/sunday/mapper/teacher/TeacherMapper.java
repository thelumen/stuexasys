package sunday.mapper.teacher;

import org.springframework.stereotype.Repository;
import sunday.pojo.Teacher;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/24.
 * At 8:59
 */
@Repository
public interface TeacherMapper {
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
     * @param params
     * @return
     */
    List<Teacher> select(Map<String, Object> params);

}
