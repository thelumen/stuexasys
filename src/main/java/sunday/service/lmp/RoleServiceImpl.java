package sunday.service.lmp;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.mapper.RoleMapper;
import sunday.pojo.Role;
import sunday.service.RoleService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:32
 */
@Service("roleService")
public class RoleServiceImpl implements RoleService {
    @javax.annotation.Resource(name = "roleMapper")
    private RoleMapper roleMapper;

    @Override
    @Transactional
    public int insert(Role role) {
        return roleMapper.insert(role);
    }

    @Override
    public List<Role> selectByTeacherInfo(Map<String, Object> teacherInfo) {
        List<Role> roles = roleMapper.selectByTeacherInfo(teacherInfo);
        if (null != roles && roles.size() > 0) {
            return roles;
        }
        return null;
    }

    @Override
    public List<Role> selectByManagerInfo(Map<String, Object> managerInfo) {
        List<Role> roles = roleMapper.selectByManagerInfo(managerInfo);
        if (null != roles && roles.size() > 0) {
            return roles;
        }
        return null;
    }
}
