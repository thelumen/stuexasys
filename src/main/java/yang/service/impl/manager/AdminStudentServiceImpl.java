package yang.service.impl.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yang.dao.manager.AdminStudentMapper;
import yang.service.manager.AdminStudentService;

import java.util.Map;

/**
 * @author 花间一壶酒
 * @date 2017/8/30
 */
@Service("adminStudentService")
public class AdminStudentServiceImpl implements AdminStudentService {

    @Autowired
    protected AdminStudentMapper mapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteSpecialty(Map<String, Object> params) {
        return ((mapper.selectTeacher2Course(params).size() <= 0 ||
                mapper.deleteTeacher2Course(params) > 0) && mapper.deleteSpecialty(params) > 0);
    }

}
