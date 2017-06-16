package sunday.service.shiro;

import sunday.pojo.shiro.Role;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:32
 */
public interface RoleService {

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
    boolean link2Teacher(Integer teacherId, Integer roleId);

    /**
     * 绑定普通管理员-角色
     *
     * @param managerId
     * @param roleId
     * @return
     */
    boolean link2Manager(short managerId, short roleId);

}
