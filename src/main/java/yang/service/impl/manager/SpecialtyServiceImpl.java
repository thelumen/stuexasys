package yang.service.impl.manager;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yang.domain.common.Specialty;
import yang.service.common.CommonService;
import yang.service.manager.SpecialtyService;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/8/31
 * At 8:16
 */
@Service("specialtyService")
public class SpecialtyServiceImpl extends CommonService implements SpecialtyService {

    @Override
    public boolean insert(Specialty specialty) {
        return specialtyMapper.insert(specialty) > 0;
    }

    @Override
    public List<Specialty> select(Map<String, Object> params) {
        List<Specialty> specialties = specialtyMapper.select(params);
        if (null != specialties && specialties.size() > 0) {
            return specialties;
        }
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean delete(Integer specialtyId) {
        return specialtyMapper.delete(specialtyId) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(Specialty specialty) {
        return specialtyMapper.update(specialty) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSpecialtyId(Integer newSpecialtyId, Integer OldSpecialtyId) {
        //更新学生专业号和教师课程联系
        return specialtyMapper.updateSpecialtyIdOfStudent(newSpecialtyId, OldSpecialtyId) > 0
                && specialtyMapper.updateSpecialtyIdOfTeacher(newSpecialtyId, OldSpecialtyId) > 0;
    }
}