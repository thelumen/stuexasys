package sunday.mapper.teacher;

import org.springframework.stereotype.Repository;
import sunday.pojo.school.Course;
import sunday.pojo.school.Specialty;
import sunday.pojo.teacher.CourseTaken;

import java.util.List;
import java.util.Map;

/**
 * 班级,课程
 * Created by yang on 2017/5/25.
 * At 12:12
 */
@Repository
public interface Specialty2CourseMapper {
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
    int insertCourseTaken(CourseTaken courseTaken);

    /**
     * 删除选课信息
     *
     * @param params
     * @return
     */
    int deleteTakenInfo(Map<String, Object> params);


    /**
     * 查询选课信息
     *
     * @param params
     * @return
     */
    List<CourseTaken> selectCourseTaken(Map<String, Object> params);

    List<String> selectSection(Map<String, Object> params);
}
