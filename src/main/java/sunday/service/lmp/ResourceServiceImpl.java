package sunday.service.lmp;

import org.springframework.stereotype.Service;
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
    @Override
    public List<Resource> selectByRoleInfo(Map<String, Object> roleInfo) {
        return null;
    }
}
