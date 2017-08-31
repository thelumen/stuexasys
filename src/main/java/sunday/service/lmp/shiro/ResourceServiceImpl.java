package sunday.service.lmp.shiro;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.pojo.shiro.Resource;
import sunday.service.common.CommonService;
import sunday.service.shiro.ResourceService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 20:06
 */
@Service("resourceService")
public class ResourceServiceImpl extends CommonService implements ResourceService {

    @Override
    @Transactional
    public int insert(Resource resource) {
        return resourceMapper.insert(resource);
    }

    @Override
    public List<Resource> selectByRoleInfo(Map<String, Object> roleInfo) {
        List<Resource> resources = resourceMapper.selectByRoleInfo(roleInfo);
        if (null != resources && resources.size() > 0) {
            return resources;
        }
        return null;
    }
}
