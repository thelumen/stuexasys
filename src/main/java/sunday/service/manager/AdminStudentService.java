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
     * @return .
     */
    List<Map<String, Object>> selectSpecialty();

    /**
     * 删除专业相关
     * 包括与专业关联的教师选课数据
     * @return .
     */
    boolean deleteSpecialty(Map<String,Object> params);

    /**
     * 上传学生表处理
     *
     * @param params .
     * @return .
     */
    boolean uploadStudentHandle(Map<String,Object> params);
}
