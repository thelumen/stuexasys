package sunday.mapper.teacher;

import org.springframework.stereotype.Repository;
import sunday.pojo.Course;
import sunday.pojo.CourseTaken;
import sunday.pojo.Specialty;
import sunday.pojo.dto.TakenInfo;

import java.util.List;
import java.util.Map;

/**
 * 班级,课程
 * Created by yang on 2017/5/25.
 * At 12:12
 */
@Repository
public interface SpeCouMapper {
    /**
     * 新增班级
     *
     * @param specialty
     * @return
     */
    int insertSpecialty(Specialty specialty);

    /**
     * 查询班级
     *
     * @param params
     * @return
     */
    List<Specialty> selectSpecialty(Map<String, Object> params);

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
     * 查询选课信息
     *
     * @param params
     * @return
     */
    List<TakenInfo> selectTakenInfo(Map<String, Object> params);

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
}
