package sunday.mapper.shiro;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import sunday.pojo.shiro.Role;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/24.
 * At 8:54
 */
@Repository
public interface RoleMapper {
    /**
     * 查询角色
     *
     * @param params
     * @return
     */
    List<Role> select(Map<String, Object> params);

    /**
     * 新增角色
     *
     * @param role
     * @return
     */
    int insert(Role role);

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

    /**
     * 绑定教师-角色
     *
     * @param teacherId
     * @param roleId
     * @return
     */
    int link2Teacher(@Param("teacherId") Integer teacherId, @Param("roleId") Integer roleId);

    /**
     * 绑定普通管理员-角色
     *
     * @param managerId
     * @param roleId
     * @return
     */
    int link2Manager(@Param("managerId") short managerId, @Param("roleId") short roleId);
}
