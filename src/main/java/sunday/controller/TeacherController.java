package sunday.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sunday.common.kit.ShiroKit;
import sunday.pojo.school.Course;
import sunday.pojo.school.Specialty;
import sunday.pojo.teacher.CourseTaken;
import sunday.pojo.teacher.GradeTaken;
import sunday.service.teacher.SpeCouService;
import sunday.service.teacher.StuGraService;
import sunday.service.teacher.TeacherService;

import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * Created by yang on 2017/5/25.
 * At 10:09
 */
@Controller
@RequestMapping("/teacher")
public class TeacherController {

    @javax.annotation.Resource(name = "teacherService")
    private TeacherService teacherService;

    @javax.annotation.Resource(name = "speCouService")
    private SpeCouService speCouService;

    @javax.annotation.Resource(name = "stuGraService")
    private StuGraService stuGraService;

    /**
     * 获取当前登录教师id
     *
     * @return
     */
    private String getCurrentTeacherId() {
        return (String) ShiroKit.getSession().getAttribute("currentTeacherId");
    }

    /**
     * 转到教师主页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main() {
        return "/teacher/main/mainProxy";
    }

    /**
     * 转到成绩统计页面
     *
     * @return
     */
    @RequestMapping(value = "/student/grades", method = RequestMethod.GET)
    public String studentPage(Model model) {
        model.addAttribute("action", "all");
        return "/teacher/grade/gradeProxy";
    }

    /**
     * 获取指定专业学生的成绩
     *
     * @param specialtyId
     * @return
     */
    @RequestMapping(value = "/grade/{specialtyId}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getGradeBySpecialtyId(@PathVariable("specialtyId") String specialtyId) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("specialtyId", specialtyId);
        }};
        List<CourseTaken> courseTakens = speCouService.selectCourseTaken(null, params);
        return getTakenInfo(courseTakens);
    }

    /**
     * 获取所教专业所有学生的成绩信息
     *
     * @param params
     * @return
     */
    @RequestMapping(value = "/student/grade/all", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> getAllStudentGrade() {
        Map<String, Object> takenInfo = new HashMap<>();
        //封装list
        List<GradeTaken> target = new ArrayList<>();

        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
        }};
        List<CourseTaken> courseTakens = speCouService.selectCourseTaken(null, takenInfo);
        for (CourseTaken course : courseTakens) {
            teacherInfo.put("specialtyName", course.getSpecialtyName());
            List<GradeTaken> gradeTakens = stuGraService.selectGradeTaken(null, teacherInfo);
            //本可不用，但是没有学生-专业表数据导致出现java.lang.NullPointerException
            if (null == gradeTakens) {
                continue;
            }
            target.addAll(gradeTakens);
        }

        return getTakenInfo(target);
    }

    /**
     * 转到个人信息页
     *
     * @return
     */
    @RequestMapping(value = "/person", method = RequestMethod.GET)
    public String personPage() {
        return "/teacher/personalPage/personalPageProxy";
    }

    /**
     * 转到选课页
     *
     * @return
     */
    @RequestMapping(value = "/cources", method = RequestMethod.GET)
    public String coursePage() {
        return "/teacher/course/courseProxy";
    }

    /**
     * 选课
     *
     * @param courseTaken
     * @return
     */
    @RequestMapping(value = "/takeCourse", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> takeCourse(@RequestBody CourseTaken courseTaken) {
        Map<String, Object> info = new HashMap<>();
        courseTaken.setTeacherId(getCurrentTeacherId());
        if (speCouService.insertCourseTaken(courseTaken) > 0) {
            info.put("isSuccess", true);
        }
        return info;
    }

    /**
     * 展示教师选课情况
     *
     * @param params
     * @return
     */
    @RequestMapping(value = "/tlcls", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getTakenInfo(@RequestBody Map<String, Object> params) {
        Map<String, Object> takenInfo = new HashMap<>();

        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
        }};
        List<CourseTaken> courses = speCouService.selectCourseTaken(getMapInfo2Page(params), teacherInfo);

        //添加teacherId并且设置课程教学状态
        Date currentTime = new Date();
        for (CourseTaken info : courses) {
            if (info.getEndtime().compareTo(currentTime) >= 0 && currentTime.compareTo(info.getStarttime()) >= 0) {
                info.setOn(true);
            }
        }

        return getTakenInfo(courses);
    }

    /**
     * 删除选课信息
     *
     * @param content
     * @return
     */
    @RequestMapping(value = "/course/delete/{content}", method = RequestMethod.DELETE)
    @ResponseBody
    public Map<String, Object> editCourseTaken(@PathVariable("content") String content) throws UnsupportedEncodingException {
        Map<String, Object> info = new HashMap<>();
        //此数组有三个数值，teacherId+courseName+specialtyName
        //这种写法并不好
        String[] target = new String(content.getBytes("ISO8859-1"), "utf-8").split("&");

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", target[0]);
            put("courseName", target[1]);
            put("specialtyName", target[2]);
        }};

        if (speCouService.deleteTakenInfo(params)) {
            info.put("isSuccess", true);
        }
        return info;
    }

    /**
     * 获取table所需格式
     *
     * @param target
     * @return
     */
    private Map<String, Object> getTakenInfo(List<?> target) {
        Map<String, Object> takenInfo = new HashMap<>();

        PageInfo<?> pageInfo = new PageInfo<>(target);

        takenInfo.put("total", pageInfo.getTotal());
        takenInfo.put("rows", pageInfo.getList());

        return takenInfo;
    }

    /**
     * 从map中获取page信息
     *
     * @param params
     * @return
     */
    private Page getMapInfo2Page(Map<String, Object> params) {
        Page page = new Page();

        if (null != params.get("pageNum")) {
            page.setPageNum(Integer.parseInt(params.get("pageNum").toString()));
        }
        if (null != params.get("pageSize")) {
            page.setPageSize(Integer.parseInt(params.get("pageSize").toString()));
        }
        if (null != params.get("sort")) {
            page.setOrderBy(params.get("sort") + " " + params.get("order"));
        }
        return page;
    }

    /**
     * 获取教师-课程select
     *
     * @return
     */
    @RequestMapping(value = "/getCourse", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getCoursesFromTeacher() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
        }};
        return getCourses(params);
    }

    /**
     * 获取全部课程select
     *
     * @return
     */
    @RequestMapping(value = "/getCourses", method = RequestMethod.GET)
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
            courses = speCouService.selectCourse(params);
        } else {
            courses = speCouService.selectAllCourses();
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
     * 获取教师-专业select
     *
     * @return
     */
    @RequestMapping(value = "/getSpecialty", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getSpecialtiesFromTeacher() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
        }};
        return getSpecialties(params);
    }

    /**
     * 获取全部专业select
     *
     * @return
     */
    @RequestMapping(value = "/getSpecialties", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getAllSpecialties() {
        return getSpecialties(null);
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
            specialties = speCouService.selectSpecialty(params);
        } else {
            //查询全部专业
            specialties = speCouService.selectAllSpecialties();
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
