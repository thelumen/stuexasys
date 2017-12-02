package yang.service.impl.manager;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yang.domain.manager.Manager;
import yang.service.common.CommonService;
import yang.service.manager.ManagerService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/15.
 * At 15:49
 */
@Service("managerService")
public class ManagerServiceImpl extends CommonService implements ManagerService {

    @Override
    @Transactional
    public int insert(Manager manager) {
        return managerMapper.insert(manager);
    }

    @Override
    public List<Manager> select(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<Manager> managers = managerMapper.select(params);
        if (null != managers && managers.size() > 0) {
            return managers;
        }
        return null;
    }

}