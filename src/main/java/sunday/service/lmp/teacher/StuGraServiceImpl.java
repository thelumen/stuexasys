package sunday.service.lmp.teacher;

import org.springframework.stereotype.Service;
import sunday.mapper.teacher.StuGraMapper;
import sunday.pojo.GradeTaken;
import sunday.service.teacher.StuGraService;

import java.util.List;
import java.util.Map;

/**
 * 学生-成绩
 * Created by yang on 2017/5/27.
 * At 18:56
 */
@Service("stuGraService")
public class StuGraServiceImpl implements StuGraService {

    @javax.annotation.Resource(name = "stuGraMapper")
    private StuGraMapper stuGraMapper;

    @Override
    public List<GradeTaken> selectGradeTaken(Map<String, Object> params) {
        List<GradeTaken> gradeTakens = stuGraMapper.selectGradeTaken(params);
        if (null != gradeTakens && gradeTakens.size() > 0) {
            return gradeTakens;
        }
        return null;
    }
}
