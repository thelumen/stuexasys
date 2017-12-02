package yang.dao.manager;

import org.springframework.stereotype.Repository;
import yang.domain.manager.Manager;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/15.
 * At 15:51
 */
@Repository
public interface ManagerMapper {
    /**
     * 新增管理员
     *
     * @param manager
     * @return
     */
    int insert(Manager manager);

    /**
     * 查询管理员
     *
     * @param params
     * @return
     */
    List<Manager> select(Map<String, Object> params);


}
