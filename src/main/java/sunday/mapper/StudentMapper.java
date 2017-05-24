package sunday.mapper;

import org.springframework.stereotype.Repository;
import sunday.pojo.Student;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/24.
 * At 8:56
 */
@Repository
public interface StudentMapper {
    /**
     * 查询学生
     *
     * @param params
     * @return
     */
    List<Student> select(Map<String, Object> params);
}
