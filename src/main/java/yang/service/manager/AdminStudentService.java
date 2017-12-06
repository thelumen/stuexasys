package yang.service.manager;

import yang.common.enums.MessageInfo;

import java.util.List;
import java.util.Map;

/**
 *
 * @author 花间一壶酒
 * @date 2017/8/30
 */
public interface AdminStudentService {

    /**
     * 删除专业相关
     * 包括与专业关联的教师选课数据
     * @return .
     */
    boolean deleteSpecialty(Map<String,Object> params);

}
