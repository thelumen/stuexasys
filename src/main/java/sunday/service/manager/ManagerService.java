package sunday.service.manager;

import com.github.pagehelper.Page;
import sunday.pojo.manager.Manager;
import sunday.pojo.school.Student;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/15.
 * At 15:49
 */
public interface ManagerService {
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
     * @param page
     * @param params
     * @return
     */
    List<Manager> select(Page page, Map<String, Object> params);

    /**
     * 管理员查询学生信息
     *
     * @param page
     * @param params
     * @return
     */
    List<Student> selectStuInfo(Page page, Map<String, Object> params);
}
