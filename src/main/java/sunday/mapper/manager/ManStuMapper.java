package sunday.mapper.manager;

import org.springframework.stereotype.Repository;
import sunday.pojo.school.Student;

import java.util.List;
import java.util.Map;

/**
 * Created by 花间一壶酒 on 2017/8/28.
 */

@Repository
public interface ManStuMapper {
    /**
     * 管理员查询学生
     *
     * @param params 查询条件
     * @return 学生列表.
     */
    List<Student> selectStuInfo(Map<String, Object> params);
}
