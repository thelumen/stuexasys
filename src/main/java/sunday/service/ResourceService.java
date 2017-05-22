package sunday.service;

import sunday.pojo.Resource;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 20:06
 */
public interface ResourceService {
    /**
     * 以角色信息查询权限
     *
     * @param roleInfo
     * @return
     */
    List<Resource> selectByRoleInfo(Map<String, Object> roleInfo);
}
