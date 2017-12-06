package yang.service.impl.shiro;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yang.dao.shiro.RoleMapper;
import yang.domain.shiro.Role;
import yang.service.shiro.RoleService;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/5/22
 * At 17:32
 */
@Service("roleService")
public class RoleServiceImpl implements RoleService {

    @Autowired
    protected RoleMapper mapper;

    @Override
    public int insert(Role role) {
        return mapper.insert(role);
    }

    @Override
    public List<Role> select(Map<String, Object> params) {
        List<Role> roles = mapper.select(params);
        if (null != roles && roles.size() > 0) {
            return roles;
        }
        return null;
    }

    @Override
    public List<Role> selectByStudentInfo(Map<String, Object> studentInfo) {
        List<Role> roles = mapper.selectByStudentInfo(studentInfo);
        if (null != roles && roles.size() > 0) {
            return roles;
        }
        return null;
    }

    @Override
    public List<Role> selectByTeacherInfo(Map<String, Object> teacherInfo) {
        List<Role> roles = mapper.selectByTeacherInfo(teacherInfo);
        if (null != roles && roles.size() > 0) {
            return roles;
        }
        return null;
    }

    @Override
    public List<Role> selectByManagerInfo(Map<String, Object> managerInfo) {
        List<Role> roles = mapper.selectByManagerInfo(managerInfo);
        if (null != roles && roles.size() > 0) {
            return roles;
        }
        return null;
    }

    @Override
    public boolean link2Teacher(Integer teacherId, Integer roleId) {
        return mapper.link2Teacher(teacherId, roleId) > 0;
    }

    @Override
    public boolean link2Student(Integer studentId, Integer roleId) {
        return mapper.link2Student(studentId, roleId) > 0;
    }

}
