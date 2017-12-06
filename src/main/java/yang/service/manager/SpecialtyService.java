package yang.service.manager;

import yang.domain.common.Specialty;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/8/31
 * At 8:15
 */
public interface SpecialtyService {
    /**
     * 新增专业
     *
     * @param specialty
     * @return
     */
    boolean insert(Specialty specialty);

    /**
     * 查询专业
     *
     * @param params
     * @return
     */
    List<Specialty> select(Map<String, Object> params);

    /**
     * 删除专业
     *
     * @param specialtyId
     * @return
     */
    boolean delete(Integer specialtyId);

    /**
     * 更新专业
     *
     * @param specialty
     * @return
     */
    boolean update(Specialty specialty);

}
