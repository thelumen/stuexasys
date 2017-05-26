package sunday.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import sunday.common.kit.ShiroKit;
import sunday.pojo.Course;
import sunday.pojo.CourseTaken;
import sunday.pojo.Specialty;
import sunday.pojo.dto.TakenInfo;
import sunday.service.SpeCouService;
import sunday.service.TeacherService;

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
     * 转到个人页
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
            put("teacherId", teacherId);
        }};
        List<TakenInfo> infoList = speCouService.selectTakenInfo(page, params);
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
