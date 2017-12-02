package yang.service.shiro;

import yang.domain.shiro.Resource;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 20:06
 */
public interface ResourceService {
    /**
     * 新增资源
     *
     * @param resource
     * @return
     */
    int insert(Resource resource);

    /**
     * 以角色信息查询权限
     *
     * @param roleInfo
     * @return
     */
    List<Resource> selectByRoleInfo(Map<String, Object> roleInfo);

}
