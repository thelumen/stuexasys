package sunday.service.lmp.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.mapper.teacher.SpeCouMapper;
import sunday.pojo.school.Course;
import sunday.pojo.school.Specialty;
import sunday.pojo.teacher.CourseTaken;
import sunday.service.teacher.SpeCouService;

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
    public List<Course> selectAllCourses() {
        List<Course> courses = speCouMapper.selectAllCourses();
        if (null != courses && courses.size() > 0) {
            return courses;
        }
        return null;
    }

    @Override
    @Transactional
    public int insertCourseTaken(CourseTaken courseTaken) {
        return speCouMapper.insertCourseTaken(courseTaken);
    }

    @Override
    @Transactional
    public boolean deleteTakenInfo(Map<String, Object> params) {
        boolean result = false;
        if (speCouMapper.deleteTakenInfo(params) > 0) {
            result = true;
        }
        return result;
    }

    @Override
    public List<CourseTaken> selectCourseTaken(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<CourseTaken> courses = speCouMapper.selectCourseTaken(params);
        if (null != courses && courses.size() > 0) {
            return courses;
        }
        return null;
    }

    @Override
    public List<Specialty> selectAllSpecialties() {
        List<Specialty> specialties = speCouMapper.selectAllSpecialties();
        if (null != specialties && specialties.size() > 0) {
            return specialties;
        }
        return null;
    }
}
