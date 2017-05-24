package sunday.service;

import sunday.pojo.Role;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:32
 */
public interface RoleService {
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
}
