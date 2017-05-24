package sunday.service.lmp;

import org.springframework.stereotype.Service;
import sunday.mapper.ResourceMapper;
import sunday.pojo.Resource;
import sunday.service.ResourceService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 20:06
 */
@Service("resourceService")
public class ResourceServiceImpl implements ResourceService {

    @javax.annotation.Resource(name = "resourceMapper")
    private ResourceMapper resourceMapper;

    @Override
    public List<Resource> selectByRoleInfo(Map<String, Object> roleInfo) {
        List<Resource> resources = resourceMapper.selectByRoleInfo(roleInfo);
        if (null != resources && resources.size() > 0) {
            return resources;
        }
        return null;
    }
}
