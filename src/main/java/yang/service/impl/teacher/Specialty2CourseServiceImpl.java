package yang.service.impl.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yang.dao.teacher.Specialty2CourseMapper;
import yang.domain.common.Course;
import yang.domain.common.Specialty;
import yang.domain.teacher.CourseTaken;
import yang.service.teacher.Specialty2CourseService;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/5/25
 * At 12:11
 */
@Service("specialty2CourseService")
public class Specialty2CourseServiceImpl implements Specialty2CourseService {

    @Autowired
    protected Specialty2CourseMapper mapper;

    @Override
    public List<Specialty> selectSpecialty(Map<String, Object> params) {
        List<Specialty> specialties = mapper.selectSpecialty(params);
        if (null != specialties && specialties.size() > 0) {
            return specialties;
        }
        return null;
    }

    @Override
    public List<Course> selectCourse(Map<String, Object> params) {
        List<Course> courses = mapper.selectCourse(params);
        if (null != courses && courses.size() > 0) {
            return courses;
        }
        return null;
    }

    @Override
    public List<Course> selectAllCourses() {
        List<Course> courses = mapper.selectAllCourses();
        if (null != courses && courses.size() > 0) {
            return courses;
        }
        return null;
    }

    @Override
    public boolean insertCourseTaken(CourseTaken courseTaken) {
        return mapper.insertCourseTaken(courseTaken) > 0;
    }

    @Override
    public boolean deleteTakenInfo(Map<String, Object> params) {
        return mapper.deleteTakenInfo(params) > 0;
    }

    @Override
    public List<CourseTaken> selectCourseTaken(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<CourseTaken> courses = mapper.selectCourseTaken(params);
        if (null != courses && courses.size() > 0) {
            return courses;
        }
        return null;
    }

    @Override
    public List<Specialty> selectAllSpecialties() {
        List<Specialty> specialties = mapper.selectAllSpecialties();
        if (null != specialties && specialties.size() > 0) {
            return specialties;
        }
        return null;
    }

}
