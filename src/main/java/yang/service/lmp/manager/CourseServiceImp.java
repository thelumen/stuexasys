package yang.service.lmp.manager;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yang.domain.school.Course;
import yang.service.common.CommonService;
import yang.service.manager.CourseService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/31.
 * At 8:17
 */
@Service("courseService")
public class CourseServiceImp extends CommonService implements CourseService {

    @Override
    @Transactional
    public int deleteCourseTakenByTeacherId(Integer teacherId) {
        return courseMapper.deleteCourseTakenByTeacherId(teacherId);
    }

    @Override
    public List<Course> select(Map<String, Object> params) {
        List<Course> courses = courseMapper.select(params);
        if (null != courses && courses.size() > 0) {
            return courses;
        }
        return null;
    }

    @Override
    public boolean insert(Course course) {
        return courseMapper.insert(course) > 0;
    }

    @Override
    @Transactional
    public boolean delete(Integer courseId) {
        return courseMapper.delete(courseId) > 0;
    }

    @Override
    @Transactional
    public boolean update(Course course) {
        return courseMapper.update(course) > 0;
    }

}
