package sunday.mapper;

import org.springframework.stereotype.Repository;
import sunday.pojo.Resource;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/24.
 * At 8:51
 */
@Repository
public interface ResourceMapper {
    /**
     * 新增资源
     *
     * @param resource
     * @return
     */
    int insert(Resource resource);

    /**
     * 查询角色对应资源
     *
     * @param roleInfo
     * @return
     */
    List<Resource> selectByRoleInfo(Map<String, Object> roleInfo);


}
