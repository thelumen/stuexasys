package sunday.service;

import com.github.pagehelper.Page;
import sunday.pojo.Manager;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/15.
 * At 15:49
 */
public interface ManagerService {
    /**
     * 查询管理员
     *
     * @param page
     * @param params
     * @return
     */
    List<Manager> select(Page page, Map<String, Object> params);
}
