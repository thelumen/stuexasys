package sunday.service.lmp.manager;

import org.springframework.stereotype.Service;
import sunday.mapper.manager.AdminStudentMapper;
import sunday.service.manager.AdminStudentService;

import java.util.List;
import java.util.Map;

/**
 * Created by 花间一壶酒 on 2017/8/30.
 */

@Service("adminStudentService")
public class AdminStudentServiceImpl implements AdminStudentService {

    @javax.annotation.Resource(name = "adminStudentMapper")
    private AdminStudentMapper adminStudentMapper;

    @Override
    public List<Map<String, Object>> selectSpecialty() {

        return null;
    }
}
