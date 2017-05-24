package sunday.mapper;

import org.springframework.stereotype.Repository;
import sunday.pojo.Role;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/24.
 * At 8:54
 */
@Repository
public interface RoleMapper {
    /**
     * 查询教师角色
     *
     * @param teacherInfo
     * @return
     */
    List<Role> selectByTeacherInfo(Map<String, Object> teacherInfo);

    /**
     * 查询管理员角色
     *
     * @param managerInfo
     * @return
     */
    List<Role> selectByManagerInfo(Map<String, Object> managerInfo);
}
