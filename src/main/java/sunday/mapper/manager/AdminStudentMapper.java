package sunday.mapper.manager;

import org.springframework.stereotype.Repository;
import sunday.pojo.school.Specialty;

import java.util.List;

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
}
