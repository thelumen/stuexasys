package sunday.service.lmp.teacher;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.mapper.teacher.Specialty2CourseMapper;
import sunday.pojo.school.Course;
import sunday.pojo.school.Specialty;
import sunday.pojo.teacher.CourseTaken;
import sunday.service.common.CommonService;
import sunday.service.teacher.Specialty2CourseService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/25.
 * At 12:11
 */
@Service("specialty2CourseService")
public class Specialty2CourseServiceImp extends CommonService implements Specialty2CourseService {

    @Override
    public int insertSpecialty(Specialty specialty) {
        return specialty2CourseMapper.insertSpecialty(specialty);
    }

    @Override
    public List<Specialty> selectSpecialty(Map<String, Object> params) {
        List<Specialty> specialties = specialty2CourseMapper.selectSpecialty(params);
        if (null != specialties && specialties.size() > 0) {
            return specialties;
        }
        return null;
    }

    @Override
    public int insertCourse(Course course) {
        return specialty2CourseMapper.insertCourse(course);
    }

    @Override
    public List<Course> selectCourse(Map<String, Object> params) {
        List<Course> courses = specialty2CourseMapper.selectCourse(params);
        if (null != courses && courses.size() > 0) {
            return courses;
        }
        return null;
    }

    @Override
    public List<Course> selectAllCourses() {
        List<Course> courses = specialty2CourseMapper.selectAllCourses();
        if (null != courses && courses.size() > 0) {
            return courses;
        }
        return null;
    }

    @Override
    public int insertCourseTaken(CourseTaken courseTaken) {
        return specialty2CourseMapper.insertCourseTaken(courseTaken);
    }

    @Override
    @Transactional
    public boolean deleteTakenInfo(Map<String, Object> params) {
        boolean result = false;
        if (specialty2CourseMapper.deleteTakenInfo(params) > 0) {
            result = true;
        }
        return result;
    }

    @Override
    public List<CourseTaken> selectCourseTaken(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<CourseTaken> courses = specialty2CourseMapper.selectCourseTaken(params);
        if (null != courses && courses.size() > 0) {
            return courses;
        }
        return null;
    }

    @Override
    public List<Specialty> selectAllSpecialties() {
        List<Specialty> specialties = specialty2CourseMapper.selectAllSpecialties();
        if (null != specialties && specialties.size() > 0) {
            return specialties;
        }
        return null;
    }
}
