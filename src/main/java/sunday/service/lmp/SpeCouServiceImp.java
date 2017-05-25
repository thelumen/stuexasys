package sunday.service.lmp;

import com.github.pagehelper.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.mapper.SpeCouMapper;
import sunday.pojo.Course;
import sunday.pojo.CourseTaken;
import sunday.pojo.Specialty;
import sunday.pojo.dto.TakenInfo;
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

    @Override
    @Transactional
    public int insertCourse(Course course) {
        return speCouMapper.insertCourse(course);
    }

    @Override
    public List<Course> selectCourse(Map<String, Object> params) {
        List<Course> courses = speCouMapper.selectCourse(params);
        if (null != courses && courses.size() > 0) {
            return courses;
        }
        return null;
    }

    @Override
    public List<TakenInfo> selectTakenInfo(Page page, Map<String, Object> params) {
        List<TakenInfo> infoList = speCouMapper.selectTakenInfo(params);
        if (null != infoList && infoList.size() > 0) {
            return infoList;
        }
        return null;
    }

    @Override
    @Transactional
    public int insertCourseTaken(CourseTaken courseTaken) {
        return speCouMapper.insertCourseTaken(courseTaken);
    }
}