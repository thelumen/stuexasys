package yang.service.impl.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yang.dao.manager.SpecialtyMapper;
import yang.domain.common.Specialty;
import yang.service.manager.SpecialtyService;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/8/31
 * At 8:16
 */
@Service("specialtyService")
public class SpecialtyServiceImpl implements SpecialtyService {

    @Autowired
    protected SpecialtyMapper mapper;

    @Override
    public boolean insert(Specialty specialty) {
        return mapper.insert(specialty) > 0;
    }

    @Override
    public List<Specialty> select(Map<String, Object> params) {
        List<Specialty> specialties = mapper.select(params);
        if (null != specialties && specialties.size() > 0) {
            return specialties;
        }
        return null;
    }

    @Override
    public boolean delete(Integer specialtyId) {
        return mapper.delete(specialtyId) > 0;
    }

    @Override
    public boolean update(Specialty specialty) {
        return mapper.update(specialty) > 0;
    }

}
