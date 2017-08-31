package sunday.service.lmp.manager;

import org.springframework.stereotype.Service;
import sunday.mapper.manager.AdminStudentMapper;
import sunday.pojo.school.Specialty;
import sunday.service.manager.AdminStudentService;

import java.util.ArrayList;
import java.util.HashMap;
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
        List<Specialty> specialtyList = adminStudentMapper.selectSpecialty();
        List<Map<String, Object>> mapList = new ArrayList<>();
        if(null!=specialtyList){
            for (Specialty specialty : specialtyList) {
                Map<String, Object> aSpecialtyInfo = new HashMap<String, Object>() {{
                    put("id", specialty.getSpecialtyId());
                    put("text", specialty.getName());
                }};
                mapList.add(aSpecialtyInfo);
            }
            if (mapList.size() > 0) {
                return mapList;
            }
        }
        return null;
    }
}
