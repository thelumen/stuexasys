package yang.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import yang.common.base.ResultBean;
import yang.common.kit.ChapterKit;
import yang.common.kit.CommonKit;
import yang.common.kit.TeacherKit;
import yang.controller.common.CommonController;
import yang.domain.common.Course;
import yang.domain.common.Specialty;
import yang.domain.teacher.CourseTaken;

import java.util.*;

/**
 * 实为专业和课程控制器
 *
 * @author yang
 * @date 2017/8/24
 * At 22:18
 */
@Controller
public class CourseController extends CommonController {

    /**
     * 转到选课页
     *
     * @return
     */
    @RequestMapping(value = "/course/main", method = RequestMethod.GET)
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
    @RequestMapping(value = "/course/insert", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object takeCourse(@RequestBody CourseTaken courseTaken) {
        //选课结束日期需要比开始日期大
        if (courseTaken.getStarttime().compareTo(courseTaken.getEndtime()) >= 0) {
            return new ResultBean<>("课程结束日期不能小于等于课程开始日期！");
        }
        courseTaken.setTeacherId(TeacherKit.getCurrentTeacherId());
        return new ResultBean<>(specialty2CourseService.insertCourseTaken(courseTaken));
    }

    /**
     * 展示教师选课情况
     *
     * @param params
     * @return
     */
    @RequestMapping(value = "/course/list", method = RequestMethod.POST)
    @ResponseBody
    public Object getTakenInfo(@RequestBody Map<String, Object> params) {
        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", TeacherKit.getCurrentTeacherId());
        }};
        List<CourseTaken> courses = specialty2CourseService.selectCourseTaken(CommonKit.getMapInfo2Page(params), teacherInfo);

        if (null != courses) {
            //设置课程教学状态
            Date currentTime = new Date();
            for (CourseTaken info : courses) {
                if (currentTime.compareTo(info.getStarttime()) < 0) {
                    info.setOn("未开始");
                } else if (info.getEndtime().compareTo(currentTime) < 0) {
                    info.setOn("已结课");
                } else {
                    info.setOn("教学中");
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
    @RequestMapping(value = "/course/delete/{content}", method = RequestMethod.DELETE)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object editCourseTaken(@PathVariable("content") String content) {
        if (Objects.equals(content, "")) {
            return new ResultBean<>(new NullPointerException("未接收到数据！"));
        }
        //此数组有三个数值，teacherId+courseId+specialtyId
        String[] target = content.split("&");
        if (target.length != 3) {
            return new ResultBean<>(new NullPointerException("接收到的数据格式不正确！"));
        }
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", target[0]);
            put("courseId", target[1]);
            put("specialtyId", target[2]);
        }};

        //删除选课信息成功，将删除相应考试信息
        if (specialty2CourseService.deleteTakenInfo(params)) {
            student2ExamService.deleteExamInfo(params);
        }

        return new ResultBean<>(true);
    }

    /**
     * 获取某一教师所教全部课程select
     *
     * @return
     */
    @RequestMapping(value = "/course/single", method = RequestMethod.GET)
    @ResponseBody
    public Object getCoursesFromTeacher() {
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
    @RequestMapping(value = "/course/all", method = RequestMethod.GET)
    @ResponseBody
    public Object getAllCourses() {
        return getCourses(null);
    }

    /**
     * 自定义查询课程select
     *
     * @param params
     * @return
     */
    private Object getCourses(Map<String, Object> params) {
        List<Course> courses = params != null ?
                specialty2CourseService.selectCourse(params) :
                specialty2CourseService.selectAllCourses();
        if (null == courses) {
            return null;
        }
        List<Map<String, Object>> father = new ArrayList<>();
        Map<String, Object> child;
        for (Course course : courses) {
            child = new HashMap<String, Object>() {{
                put("id", course.getCourseId());
                put("text", course.getName());
            }};
            father.add(child);
        }
        return father;
    }

    /**
     * 获取某一教师所教的一门课的全部专业
     *
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/specialty/{courseId}", method = RequestMethod.GET)
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
    @RequestMapping(value = "/course/section/{courseId}", method = RequestMethod.GET)
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
    @RequestMapping(value = "/specialty/all", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getAllSpecialties() {
        return getSpecialties(null);
    }

    /**
     * 获取某一教师所教全部专业select
     *
     * @return
     */
    @RequestMapping(value = "/specialty/single", method = RequestMethod.GET)
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
        List<Specialty> specialties = params != null ?
                specialty2CourseService.selectSpecialty(params) :
                specialty2CourseService.selectAllSpecialties();
        if (null == specialties) {
            return null;
        }
        List<Map<String, Object>> father = new ArrayList<>();
        Map<String, Object> child;
        for (Specialty specialty : specialties) {
            child = new HashMap<String, Object>() {{
                put("id", specialty.getSpecialtyId());
                put("text", specialty.getName());
            }};
            father.add(child);
        }
        return father;
    }
}
