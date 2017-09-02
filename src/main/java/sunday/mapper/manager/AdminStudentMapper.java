package sunday.mapper.manager;

import org.springframework.stereotype.Repository;
import sunday.pojo.dto.Specialty2Course;
import sunday.pojo.school.Specialty;

import java.util.List;
import java.util.Map;

/**
 * Created by 花间一壶酒 on 2017/8/30.
 */

@Repository
public interface AdminStudentMapper {

    /**
     * 查询专业信息
     *
     * @return .
     */
    List<Specialty> selectSpecialty();

    /**
     * 删除专业
     *
     * @param params .
     * @return .
     */
    int deleteSpecialty(Map<String,Object> params);

    /**
     *删除与专业相关的教师选课
     *
     * @param params .
     * @return .
     */
    int deleteTeacher2Course(Map<String,Object> params);

    /**
     * 查询与专业相关的教师选课
     *
     * @param params .
     * @return .
     */
    List<Specialty2Course> selectTeacher2Course(Map<String,Object> params);
}
