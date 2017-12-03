package yang.service.manager;

import yang.domain.common.Course;

import java.util.List;
import java.util.Map;

/**
 *
 * @author yang
 * @date 2017/8/31
 * At 8:17
 */
public interface CourseService {

    /**
     * 按教师号删除选课信息
     *
     * @param teacherId
     * @return
     */
    int deleteCourseTakenByTeacherId(Integer teacherId);

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
