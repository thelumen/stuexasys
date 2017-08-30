package sunday.service.manager;

import java.util.List;
import java.util.Map;

/**
 * Created by 花间一壶酒 on 2017/8/30.
 */
public interface AdminStudentService {
    /**
     * 查询专业信息
     *
     * @return
     */
    List<Map<String, Object>> selectSpecialty();
}
