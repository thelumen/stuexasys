package sunday.service.lmp;

import org.springframework.stereotype.Service;
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
    @Override
    public List<Role> selectByTeacherInfo(Map<String, Object> teacherInfo) {
        return null;
    }
}
