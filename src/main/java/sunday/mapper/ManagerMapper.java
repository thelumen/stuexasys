package sunday.mapper;

import org.springframework.stereotype.Repository;
import sunday.pojo.Manager;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/15.
 * At 15:51
 */
@Repository
public interface ManagerMapper {
    /**
     * 查询管理员
     *
     * @param params
     * @return
     */
    List<Manager> select(Map<String, Object> params);
}
