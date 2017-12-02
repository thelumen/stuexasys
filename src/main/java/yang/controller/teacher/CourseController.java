package yang.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import yang.common.kit.ChapterKit;
import yang.common.kit.CommonKit;
import yang.common.kit.TeacherKit;
import yang.controller.common.CommonController;
import yang.domain.common.Course;
import yang.domain.common.Specialty;
import yang.domain.teacher.CourseTaken;

import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * Created by yang on 2017/8/24.
 * At 22:18
 */
@Controller
@RequestMapping("/course")
public class CourseController extends CommonController {

    /**
     * 转到选课页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String coursePage() {
        return "/teacher/course/courseProxy";
    }

    /**
     * 选课
     *
     * @param courseTaken
     * @return
     */
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean takeCourse(@RequestBody CourseTaken courseTaken) {
        //选课结束日期需要比开始日期大
        if (courseTaken.getStarttime().compareTo(courseTaken.getEndtime()) >= 0) {
            return false;
        }
        courseTaken.setTeacherId(TeacherKit.getCurrentTeacherId());
        return specialty2CourseService.insertCourseTaken(courseTaken) > 0;
    }

    /**
     * 展示教师选课情况
     *
     * @param params
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getTakenInfo(@RequestBody Map<String, Object> params) {
        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", TeacherKit.getCurrentTeacherId());
        }};
        List<CourseTaken> courses = specialty2CourseService.selectCourseTaken(CommonKit.getMapInfo2Page(params), teacherInfo);

        if (null != courses) {
            //添加teacherId并且设置课程教学状态
            Date currentTime = new Date();
            for (CourseTaken info : courses) {
                if (info.getEndtime().compareTo(currentTime) >= 0 && currentTime.compareTo(info.getStarttime()) >= 0) {
                    info.setOn("教学中");
                }
                if (currentTime.compareTo(info.getStarttime()) < 0) {
                    info.setOn("未开始");
                }
                if (info.getEndtime().compareTo(currentTime) < 0) {
                    info.setOn("已结课");
                }
            }
        }
        return CommonKit.getTakenInfo(courses);
    }

    /**
     * 删除选课信息
     *
     * @param content
     * @return
     */
    @RequestMapping(value = "/delete/{content}", method = RequestMethod.DELETE)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean editCourseTaken(@PathVariable("content") String content) throws UnsupportedEncodingException {

        if (Objects.equals(content, "")) {
            return false;
        }
        //此数组有三个数值，teacherId+courseId+specialtyId
        String[] target = content.split("&");
        if (target.length == 3) {
            Map<String, Object> params = new HashMap<String, Object>() {{
                put("teacherId", target[0]);
                put("courseId", target[1]);
                put("specialtyId", target[2]);
            }};

            //删除选课信息成功，将删除相应考试信息
            if (specialty2CourseService.deleteTakenInfo(params)) {
                student2ExamService.deleteExamInfo(params);
            }

            return true;
        }
        return false;
    }

    /**
     * 获取某一教师所教全部课程select
     *
     * @return
     */
    @RequestMapping(value = "/single", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getCoursesFromTeacher() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", TeacherKit.getCurrentTeacherId());
        }};
        return getCourses(params);
    }

    /**
     * 获取全部课程select
     *
     * @return
     */
    @RequestMapping(value = "/all", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getAllCourses() {
        return getCourses(null);
    }

    /**
     * 自定义查询课程select
     *
     * @param params
     * @return
     */
    private List<Map<String, Object>> getCourses(Map<String, Object> params) {
        List<Course> courses;
        if (null != params) {
            courses = specialty2CourseService.selectCourse(params);
        } else {
            courses = specialty2CourseService.selectAllCourses();
        }
        if (null != courses) {
            List<Map<String, Object>> father = new ArrayList<>();
            for (Course course : courses) {
                Map<String, Object> child = new HashMap<String, Object>() {{
                    put("id", course.getCourseId());
                    put("text", course.getName());
                }};
                father.add(child);
            }
            return father;
        }
        return null;
    }

    /**
     * 获取某一教师所教的一门课的全部专业
     *
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/specialties/{courseId}", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getSpecialtyByTeacherIdAndCourseId(@PathVariable("courseId") Integer courseId) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", TeacherKit.getCurrentTeacherId());
            put("courseId", courseId);
        }};
        return getSpecialties(params);
    }

    /**
     * 获取某一课程的所有章节信息
     *
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/section/{courseId}", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getCourseSection(@PathVariable("courseId") Integer courseId) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("courseId", courseId);
        }};
        List<Course> courses = courseService.select(params);
        if (null != courses) {
            int chapterNum = courses.get(0).getChapterNum();
            String[] target = ChapterKit.getLimitedChapters(chapterNum);

            return ChapterKit.getChapterInSelect(target);
        }
        return null;
    }

    /**
     * 获取全部专业select
     *
     * @return
     */
    @RequestMapping(value = "/specialties", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getAllSpecialties() {
        return getSpecialties(null);
    }

    /**
     * 获取某一教师所教全部专业select
     *
     * @return
     */
    @RequestMapping(value = "/specialty", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getSpecialtiesFromTeacher() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", TeacherKit.getCurrentTeacherId());
        }};
        return getSpecialties(params);
    }

    /**
     * 自定义查询专业select
     *
     * @param params
     * @return
     */
    private List<Map<String, Object>> getSpecialties(Map<String, Object> params) {
        List<Specialty> specialties;
        if (null != params) {
            specialties = specialty2CourseService.selectSpecialty(params);
        } else {
            //查询全部专业
            specialties = specialty2CourseService.selectAllSpecialties();
        }
        if (null != specialties) {
            List<Map<String, Object>> father = new ArrayList<>();
            for (Specialty specialty : specialties) {
                Map<String, Object> child = new HashMap<String, Object>() {{
                    put("id", specialty.getSpecialtyId());
                    put("text", specialty.getName());
                }};
                father.add(child);
            }
            return father;
        }
        return null;
    }
}
