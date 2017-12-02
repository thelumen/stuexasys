package yang.dao.manager;

import org.springframework.stereotype.Repository;
import yang.domain.school.Specialty;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/31.
 * At 8:18
 */
@Repository
public interface SpecialtyMapper {
    /**
     * 新增专业
     *
     * @param specialty
     * @return
     */
    int insert(Specialty specialty);

    /**
     * 查询专业
     *
     * @return
     * @param params
     */
    List<Specialty> select(Map<String, Object> params);

    /**
     * 删除专业
     *
     * @param specialtyId
     * @return
     */
    int delete(Integer specialtyId);

    /**
     * 更新专业
     *
     * @param specialty
     * @return
     */
    int update(Specialty specialty);
}
