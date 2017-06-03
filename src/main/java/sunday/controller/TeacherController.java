package sunday.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import sunday.common.kit.ShiroKit;
import sunday.pojo.dto.GradePercent;
import sunday.pojo.school.Course;
import sunday.pojo.school.Specialty;
import sunday.pojo.teacher.CourseTaken;
import sunday.pojo.teacher.ExamTaken;
import sunday.pojo.teacher.GradeTaken;
import sunday.service.teacher.SpeCouService;
import sunday.service.teacher.StuExaService;
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

    @javax.annotation.Resource(name = "stuExaService")
    private StuExaService stuExaService;

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
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String main() {
        return "/teacher/main/mainProxy";
    }

    /**
     * 转到附加题评分页
     *
     * @return
     */
    @RequestMapping(value = "/another", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String otherQuestionPage() {
        return "/teacher/another/anotherProxy";
    }

    /**
     * 转到考试信息页
     *
     * @return
     */
    @RequestMapping(value = "/exam", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String examPage() {
        return "/teacher/exam/examProxy";
    }

    /**
     * 添加考试信息
     *
     * @param courseId
     * @param specialtyId
     * @return
     */
    @RequestMapping(value = "/takeExamInfo/{courseId}/{specialtyId}", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> takeExamInfo(@PathVariable("courseId") String courseId,
                                            @PathVariable("specialtyId") String specialtyId) {
        Map<String, Object> info = new HashMap<>();

        Map<String, Object> specouInfo = new HashMap<String, Object>() {{
            put("courseId", courseId);
            put("specialtyId", specialtyId);
        }};
        List<ExamTaken> examTakens = stuExaService.selectExamTaken(null, specouInfo);
        if (null != examTakens) {
            info.put("isSuccess", false);
            return info;
        }

        ExamTaken exam = new ExamTaken();
        exam.setCourseId(courseId);
        exam.setSpecialtyId(specialtyId);
        exam.setStarted(new Byte("1"));

        stuExaService.insertExamInfo(exam);

        info.put("isSuccess", true);
        return info;
    }

    /**
     * 获取考试信息
     *
     * @param params
     * @return
     */
    @RequestMapping(value = "/examInfos", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getExamInfo(@RequestBody Map<String, Object> params) {
        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
        }};
        List<ExamTaken> examTakens = stuExaService.selectExamTaken(getMapInfo2Page(params), teacherInfo);
        if (null != examTakens) {
            return getTakenInfo(examTakens);
        }
        return null;
    }

    /**
     * 更新考试信息
     *
     * @param examInfo
     * @return
     */
    @RequestMapping(value = "/updateExamInfo", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> getChapter(@RequestBody ExamTaken examInfo) throws UnsupportedEncodingException {
        Map<String, Object> info = new HashMap<>();
        //sign信号只有一个为1才能被保存
        byte[] signs = {examInfo.getSign1(), examInfo.getSign2(), examInfo.getSign3(), examInfo.getSign4()};
        int i = 0;
        for (byte b : signs) {
            if (b == (byte) 1) {
                i++;
            }
        }
        if (i == 1) {
            stuExaService.updateExamInfo(examInfo);
            info.put("isSuccess", true);
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 删除考试信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/examInfo/delete/{id}", method = RequestMethod.DELETE)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> deleteExamInfo(@PathVariable("id") String id) {
        Map<String, Object> info = new HashMap<>();
        if (stuExaService.deleteExamInfo(id)) {
            info.put("isSuccess", true);
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 转到成绩统计页面
     *
     * @return
     */
    @RequestMapping(value = "/student/grade", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String studentPage() {
        return "/teacher/grade/gradeProxy";
    }

    /**
     * 统计学生总成绩
     *
     * @param percentInfo
     * @return
     */
    @RequestMapping(value = "/student/assignGrades", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String assignGrades(GradePercent percentInfo) {
        float p1 = 0.0f, p2 = 0.0f, p3 = 0.0f, p4 = 0.0f;
        if (!percentInfo.getPercent1().equals("")) {
            p1 = Float.parseFloat(percentInfo.getPercent1()) / 100.0f;
        }
        if (!percentInfo.getPercent2().equals("")) {
            p2 = Float.parseFloat(percentInfo.getPercent2()) / 100.0f;
        }
        if (!percentInfo.getPercent3().equals("")) {
            p3 = Float.parseFloat(percentInfo.getPercent3()) / 100.0f;
        }
        if (!percentInfo.getPercent4().equals("")) {
            p4 = Float.parseFloat(percentInfo.getPercent4()) / 100.0f;
        }

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("specialtyId", percentInfo.getSpecialtyId());
        }};
        List<GradeTaken> studentGrades = stuGraService.selectGradeTaken(null, params);
        for (GradeTaken studentGrade : studentGrades) {
            float total;
            total = studentGrade.getGrade1() * p1 + studentGrade.getGrade2() * p2 + studentGrade.getGrade3() * p3 + studentGrade.getGrade4() * p4;
            //采用四舍五入方式计算总成绩
            studentGrade.setTotal(new Byte(String.valueOf(Math.round(total))));
            //不更新
            studentGrade.setGrade1((byte) 0);
            studentGrade.setGrade2((byte) 0);
            studentGrade.setGrade3((byte) 0);
            studentGrade.setGrade4((byte) 0);

            stuGraService.updateGrade(studentGrade);
        }

        return "/teacher/grade/gradeProxy";
    }

    /**
     * 获取指定专业学生的成绩
     *
     * @param specialtyId
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/grade/{specialtyId}/{courseId}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getGradeBySpecialtyId(@PathVariable("specialtyId") String specialtyId,
                                                     @PathVariable("courseId") String courseId) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("specialtyId", specialtyId);
            put("courseId", courseId);
        }};
        List<GradeTaken> gradeTakens = stuGraService.selectGradeTaken(null, params);
        return getTakenInfo(gradeTakens);
    }

    /**
     * 获取所教专业所有学生的成绩信息
     *
     * @return
     */
    @RequestMapping(value = "/student/grade/all", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getAllStudentGrade(@RequestBody Map<String, Object> params) {
        //封装list
        List<GradeTaken> target = new ArrayList<>();

        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
        }};
        List<CourseTaken> courseTakens = speCouService.selectCourseTaken(getMapInfo2Page(params), teacherInfo);
        if (null == courseTakens) {
            return null;
        }
        for (CourseTaken course : courseTakens) {
            teacherInfo.put("specialtyName", course.getSpecialtyName());
            teacherInfo.put("courseId", course.getCourseId());
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
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String personPage() {
        return "/teacher/personalPage/personalPageProxy";
    }

    /**
     * 转到选课页
     *
     * @return
     */
    @RequestMapping(value = "/cource", method = RequestMethod.GET)
    @RequiresAuthentication
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
    @RequestMapping(value = "/takeCourse", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
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
        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
        }};
        List<CourseTaken> courses = speCouService.selectCourseTaken(getMapInfo2Page(params), teacherInfo);

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

        return getTakenInfo(courses);
    }

    /**
     * 删除选课信息
     *
     * @param content
     * @return
     */
    @RequestMapping(value = "/course/delete/{content}", method = RequestMethod.DELETE)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
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
     * 获取某一教师所教全部课程select
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
     * 获取某一教师所教的一门课的全部专业
     *
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/getSpecialties/{courseId}", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getSpecialtyByTeacherIdAndCourseId(@PathVariable("courseId") String courseId) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
            put("courseId", courseId);
        }};
        return getSpecialties(params);
    }

    /**
     * 获取某一教师所教全部专业select
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
