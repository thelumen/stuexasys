package sunday.service;

import com.github.pagehelper.Page;
import sunday.pojo.Course;
import sunday.pojo.Specialty;
import sunday.pojo.dto.TakenInfo;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/25.
 * At 12:11
 */
public interface SpeCouService {
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
     * 查询选课表
     *
     * @param page
     * @param params
     * @return
     */
    List<TakenInfo> selectTakenInfo(Page page, Map<String, Object> params);
}
