package sunday.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sunday.common.kit.ShiroKit;
import sunday.pojo.Course;
import sunday.pojo.Specialty;
import sunday.pojo.dto.TakenInfo;
import sunday.service.SpeCouService;
import sunday.service.TeacherService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
     * @param params
     * @return
     */
    @RequestMapping(value = "/takeCourse", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> takeCourse(@RequestBody Map<String, Object> params) {
//        for (Map.Entry<String, Object> entry : params.entrySet()) {
//            System.out.print(" " + entry.getKey() + ":" + entry.getValue());
//        }
        return null;
    }

    @RequestMapping(value = "/tlcls", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getTakenInfo(@RequestBody Map<String, Object> params) {
        Map<String, Object> takenInfo = new HashMap<>();
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
        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", ShiroKit.getSession().getAttribute("currentTeacherId"));
        }};
        List<TakenInfo> infoList = speCouService.selectTakenInfo(page, params);

//        for (TakenInfo info : infoList) {
//            //课程教学状态 setOn()
//        }
        //排序

        PageInfo<TakenInfo> pageInfo = new PageInfo<>(infoList);
        takenInfo.put("total", pageInfo.getTotal());
        takenInfo.put("rows", pageInfo.getList());

        return takenInfo;
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
