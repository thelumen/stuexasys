package sunday.service.lmp;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.mapper.SpeCouMapper;
import sunday.pojo.Specialty;
import sunday.service.SpeCouService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/25.
 * At 12:11
 */
@Service("speCouService")
public class SpeCouServiceImp implements SpeCouService {

    @javax.annotation.Resource(name = "speCouMapper")
    private SpeCouMapper speCouMapper;

    @Override
    @Transactional
    public int insertSpecialty(Specialty specialty) {
        return speCouMapper.insertSpecialty(specialty);
    }

    @Override
    public List<Specialty> selectSpecialty(Map<String, Object> params) {
        List<Specialty> specialties = speCouMapper.selectSpecialty(params);
        if (null != specialties && specialties.size() > 0) {
            return specialties;
        }
        return null;
    }
}
