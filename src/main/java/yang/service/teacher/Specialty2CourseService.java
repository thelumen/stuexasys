package yang.service.teacher;

import com.github.pagehelper.Page;
import yang.domain.common.Course;
import yang.domain.common.Specialty;
import yang.domain.teacher.CourseTaken;

import java.util.List;
import java.util.Map;

/**
 * 专业-课程
 * Created by yang on 2017/5/25.
 * At 12:11
 */
public interface Specialty2CourseService {
    /**
     * 新增专业
     *
     * @param specialty
     * @return
     */
    int insertSpecialty(Specialty specialty);

    /**
     * 查询专业
     *
     * @param params
     * @return
     */
    List<Specialty> selectSpecialty(Map<String, Object> params);

    /**
     * 查询全部专业
     *
     * @return
     */
    List<Specialty> selectAllSpecialties();

    /**
     * 新增课程
     *
     * @param course
     * @return
     */
    int insertCourse(Course course);

    /**
     * 查询课程
     *
     * @param params
     * @return
     */
    List<Course> selectCourse(Map<String, Object> params);

    /**
     * 查询全部课程
     *
     * @return
     */
    List<Course> selectAllCourses();

    /**
     * 新增选课信息
     *
     * @param courseTaken
     * @return
     */
    boolean insertCourseTaken(CourseTaken courseTaken);

    /**
     * 删除选课信息
     *
     * @param params
     * @return
     */
    boolean deleteTakenInfo(Map<String, Object> params);

    /**
     * 查询选课信息
     *
     * @param page
     * @param params
     * @return
     */
    List<CourseTaken> selectCourseTaken(Page page, Map<String, Object> params);

}
