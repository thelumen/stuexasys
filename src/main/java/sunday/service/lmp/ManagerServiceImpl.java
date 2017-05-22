package sunday.service.lmp;

import com.github.pagehelper.Page;
import org.springframework.stereotype.Service;
import sunday.pojo.Manager;
import sunday.service.ManagerService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/15.
 * At 15:49
 */
@Service("managerService")
public class ManagerServiceImpl implements ManagerService {
    @Override
    public List<Manager> select(Page page, Map<String, Object> params) {
        return null;
    }
}
