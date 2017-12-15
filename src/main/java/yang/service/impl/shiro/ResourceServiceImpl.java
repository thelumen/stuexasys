package yang.service.impl.shiro;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yang.dao.shiro.ResourceMapper;
import yang.domain.shiro.Resource;
import yang.service.shiro.ResourceService;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/5/22
 * At 20:06
 */
@Service("resourceService")
public class ResourceServiceImpl implements ResourceService {

    @Autowired
    protected ResourceMapper mapper;

    @Override
    public int insert(Resource resource) {
        return mapper.insert(resource);
    }

    @Override
    public List<Resource> selectByRoleInfo(Map<String, Object> roleInfo) {
        List<Resource> resources = mapper.selectByRoleInfo(roleInfo);
        if (null != resources && resources.size() > 0) {
            return resources;
        }
        return null;
    }
}
