package sunday.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sunday.common.kit.ShiroKit;
import sunday.pojo.dto.TakenInfo;
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
     * 转到教师主页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main() {
        return "/teacher/main/mainProxy";
    }

    /**
     * 转到学生管理页面
     *
     * @return
     */
    @RequestMapping(value = "/students", method = RequestMethod.GET)
    public String studentPage(Model model) {
        model.addAttribute("action", "all");
        return "/teacher/student/studentProxy";
    }

    /**
     * 获取所教班级所有学生的成绩信息
     *
     * @param params
     * @return
     */
    @RequestMapping(value = "/student/grade/all", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> getAllStudentGrade(@RequestBody Map<String, Object> params) {
        Map<String, Object> takenInfo = new HashMap<>();
        String teacherId = (String) ShiroKit.getSession().getAttribute("currentTeacherId");
        List<GradeTaken> target = new ArrayList<>();

        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", teacherId);
        }};
        List<TakenInfo> takenInfos = speCouService.selectTakenInfo(null, takenInfo);
        for (TakenInfo info : takenInfos) {
            teacherInfo.put("specialtyName", info.getSpecialtyName());
            List<GradeTaken> gradeTakens = stuGraService.selectGradeTaken(null, teacherInfo);
            //本可不用，但是学生-专业表数据未填导致出现java.lang.NullPointerException
            if (null == gradeTakens) {
                continue;
            }
            for (GradeTaken taken : gradeTakens) {
                target.add(taken);
            }
        }

        PageInfo<GradeTaken> pageInfo = new PageInfo<>(target);

        takenInfo.put("total", pageInfo.getTotal());
        takenInfo.put("rows", pageInfo.getList());

        return takenInfo;
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
        courseTaken.setTeacherId(ShiroKit.getSession().getAttribute("currentTeacherId").toString());
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
        String teacherId = (String) ShiroKit.getSession().getAttribute("currentTeacherId");
        Map<String, Object> takenInfo = new HashMap<>();

        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", teacherId);
        }};
        List<TakenInfo> infoList = speCouService.selectTakenInfo(getMapInfo2Page(params), teacherInfo);
        //按开课时间升序
        Collections.sort(infoList, new Comparator<TakenInfo>() {
            @Override
            public int compare(TakenInfo o1, TakenInfo o2) {
                return o1.getStarttime().compareTo(o2.getStarttime());
            }
        });
        //添加teacherId并且设置课程教学状态
        Date currentTime = new Date();
        for (TakenInfo info : infoList) {
            if (info.getEndtime().compareTo(currentTime) >= 0) {
                info.setOn(true);
            }
        }

        PageInfo<TakenInfo> pageInfo = new PageInfo<>(infoList);

        takenInfo.put("total", pageInfo.getTotal());
        takenInfo.put("rows", pageInfo.getList());

        return takenInfo;
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
     * 获取课程select
     *
     * @return
     */
    @RequestMapping(value = "/getCourses", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getCourses() {
        List<Course> courses = speCouService.selectCourse(null);
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
     * 获取专业select
     *
     * @return
     */
    @RequestMapping(value = "/getSpecialties", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getSpecialties() {
        List<Specialty> specialties = speCouService.selectSpecialty(null);
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
