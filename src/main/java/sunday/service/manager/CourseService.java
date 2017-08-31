package sunday.service.manager;

import sunday.pojo.school.Course;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/31.
 * At 8:17
 */
public interface CourseService {

    /**
     * 查找课程
     *
     * @param params
     * @return
     */
    List<Course> select(Map<String, Object> params);

    /**
     * 新增课程
     *
     * @param course
     * @return
     */
    boolean insert(Course course);

    /**
     * 删除课程
     *
     * @param courseId
     * @return
     */
    boolean delete(Integer courseId);

    /**
     * 更新课程
     *
     * @param course
     * @return
     */
    boolean update(Course course);
}
