package sunday.mapper.manager;

import org.springframework.stereotype.Repository;
import sunday.pojo.school.Course;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/31.
 * At 8:18
 */
@Repository
public interface CourseMapper {
    /**
     * 查询课程
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
    int insert(Course course);

    /**
     * 删除课程
     *
     * @param courseId
     * @return
     */
    int delete(Integer courseId);

    /**
     * 按教师号删除选课信息
     *
     * @param teacherId
     * @return
     */
    int deleteCourseTakenByTeacherId(Integer teacherId);

    /**
     * 更新课程
     *
     * @param course
     * @return
     */
    int update(Course course);
}
