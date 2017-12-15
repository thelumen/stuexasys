package yang.service.impl.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yang.dao.manager.CourseMapper;
import yang.domain.common.Course;
import yang.service.manager.CourseService;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/31.
 * At 8:17
 */
@Service("courseService")
public class CourseServiceImpl implements CourseService {

    @Autowired
    protected CourseMapper mapper;

    @Override
    public List<Course> select(Map<String, Object> params) {
        List<Course> courses = mapper.select(params);
        if (null != courses && courses.size() > 0) {
            return courses;
        }
        return null;
    }

    @Override
    public boolean insert(Course course) {
        return mapper.insert(course) > 0;
    }

    @Override
    public boolean delete(Integer courseId) {
        return mapper.delete(courseId) > 0;
    }

    @Override
    public boolean update(Course course) {
        return mapper.update(course) > 0;
    }

}
