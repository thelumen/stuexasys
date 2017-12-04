package yang.dao.manager;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import yang.domain.common.Specialty;

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
    int delete(Integer specialtyId);

    /**
     * 更新专业
     *
     * @param specialty
     * @return
     */
    int update(Specialty specialty);

    /**
     * 更新学生专业号
     *
     * @param newSpecialtyId
     * @param oldSpecialtyId
     * @return
     */
    int updateSpecialtyIdOfStudent(@Param("newSpecialtyId") Integer newSpecialtyId, @Param("oldSpecialtyId") Integer oldSpecialtyId);

    /**
     * 更新教师选课相关专业号
     *
     * @param newSpecialtyId
     * @param oldSpecialtyId
     * @return
     */
    int updateSpecialtyIdOfTeacher(@Param("newSpecialtyId") Integer newSpecialtyId, @Param("oldSpecialtyId") Integer oldSpecialtyId);
}
