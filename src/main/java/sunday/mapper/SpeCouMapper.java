package sunday.mapper;

import org.springframework.stereotype.Repository;
import sunday.pojo.Specialty;

import java.util.List;
import java.util.Map;

/**
 * 班级,课程
 * Created by yang on 2017/5/25.
 * At 12:12
 */
@Repository
public interface SpeCouMapper {
    /**
     * 新增班级
     *
     * @param specialty
     * @return
     */
    int insertSpecialty(Specialty specialty);

    /**
     * 查询班级
     *
     * @param params
     * @return
     */
    List<Specialty> selectSpecialty(Map<String, Object> params);
}
