package yang.service.impl.manager;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yang.dao.manager.ManagerMapper;
import yang.domain.manager.Manager;
import yang.service.manager.ManagerService;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/5/15
 * At 15:49
 */
@Service("managerService")
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    protected ManagerMapper mapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insert(Manager manager) {
        return mapper.insert(manager);
    }

    @Override
    public List<Manager> select(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<Manager> managers = mapper.select(params);
        if (null != managers && managers.size() > 0) {
            return managers;
        }
        return null;
    }

}
