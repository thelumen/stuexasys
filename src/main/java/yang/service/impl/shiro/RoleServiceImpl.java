package yang.service.impl.shiro;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yang.domain.shiro.Role;
import yang.service.common.CommonService;
import yang.service.shiro.RoleService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:32
 */
@Service("roleService")
public class RoleServiceImpl extends CommonService implements RoleService {

    @Override
    @Transactional
    public int insert(Role role) {
        return roleMapper.insert(role);
    }

    @Override
    public List<Role> select(Map<String, Object> params) {
        List<Role> roles = roleMapper.select(params);
        if (null != roles && roles.size() > 0) {
            return roles;
        }
        return null;
    }

    @Override
    public List<Role> selectByStudentInfo(Map<String, Object> studentInfo) {
        List<Role> roles = roleMapper.selectByStudentInfo(studentInfo);
        if (null != roles && roles.size() > 0) {
            return roles;
        }
        return null;
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

    @Override
    @Transactional
    public boolean link2Teacher(Integer teacherId, Integer roleId) {
        boolean result = false;
        if (roleMapper.link2Teacher(teacherId, roleId) > 0) {
            result = true;
        }
        return result;
    }

    @Override
    @Transactional
    public boolean link2Manager(short managerId, short roleId) {
        boolean result = false;
        if (roleMapper.link2Manager(managerId, roleId) > 0) {
            result = true;
        }
        return result;
    }

}
