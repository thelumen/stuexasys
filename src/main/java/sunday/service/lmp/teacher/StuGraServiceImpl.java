package sunday.service.lmp.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import sunday.mapper.teacher.StuGraMapper;
import sunday.pojo.teacher.GradeTaken;
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
    public List<GradeTaken> selectGradeTaken(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<GradeTaken> gradeTakens = stuGraMapper.selectGradeTaken(params);
        if (null != gradeTakens && gradeTakens.size() > 0) {
            return gradeTakens;
        }
        return null;
    }
}
