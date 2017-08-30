package sunday.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sunday.common.enums.UpdateType;
import sunday.common.kit.ResourceFileKit;
import sunday.common.kit.ShiroKit;
import sunday.controller.common.CommonController;
import sunday.pojo.shiro.ShiroInfo;
import sunday.pojo.student.ExamInfo;
import sunday.pojo.student.GradeInfo;
import sunday.pojo.student.StudentInfo;
import sunday.pojo.student.TestPaper;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/student")
public class StudentController extends CommonController {

    /**
     * 从Session中获取当前登录学生的信息
     *
     * @return 当前登录学生的信息
     */
    private ShiroInfo getCurrentStudent() {
        return (ShiroInfo) ShiroKit.getSession().getAttribute("currentStudent");
    }

    /**
     * 用于获取学生 int 类型的学号
     *
     * @return 当前登录学生的id（int）
     */
    private int getStudentIdWithInt() {
        return getCurrentStudent().getUserId();
    }

    /**
     * 用于获取学生 Map 类型的学号
     *
     * @return 当前登录学生的id（Map）
     */
    private Map<String, Object> getStudentIdWithMap() {
        return new HashMap<String, Object>() {{
            put("studentId", getCurrentStudent().getUserId());
        }};
    }

    /**
     * 转到学生主页
     *
     * @return 主页url
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main() {
        return "/student/main/mainProxy";
    }

    /**
     * 显示学生主页
     *
     * @return 主页url
     */
    @RequestMapping(value = "/main", method = RequestMethod.POST)
    public String homepage() {
        return "/student/main/mainProxy";
    }

    /**
     * 转到学生 个人信息 页
     * 向 model 中添加学生的人信息 studentInfo,studentCourse,studentGrade
     *
     * @return 个人信息 url
     */
    @RequestMapping(value = "/personPage", method = RequestMethod.GET)
    public String personPage(Model model) {
        model.addAttribute("studentCourse", studentService.selectCourse(null, getStudentIdWithMap()));
        model.addAttribute("studentGrade", studentService.selectGrade(null, getStudentIdWithMap()));
        model.addAttribute("studentInfo", studentService.selectStudentInfo(null, getStudentIdWithMap()).get(0));
        return "/student/personPage/personPageProxy";
    }

    /**
     * 转到学生 测试 页
     * 向 model 中添加学生的人信息 studentInfo,studentExamInfo
     *
     * @return 测试 url
     */
    @RequestMapping(value = "/exam", method = RequestMethod.GET)
    public String exam(Model model) {
        model.addAttribute("studentExamInfo", studentService.selectExamInfo(null, getStudentIdWithMap()));
        return "/student/exam/examProxy";
    }

    /**
     * 转到学生 资源下载 页
     * 向 model 中添加学生的人信息 studentInfo
     *
     * @return 资源下载 url
     */
    @RequestMapping(value = "/resourcesDownload", method = RequestMethod.GET)
    public String resourceDownload(Model model) {
        model.addAttribute("resourceInfo", ResourceFileKit.getResourceInfo());
        return "/student/resourcesDownload/resourcesDownloadProxy";
    }

    /**
     * 更新学生个人信息
     *
     * @return 成功信号
     */
    @RequestMapping(value = "/updateStudentInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateStudentInfo(@RequestBody StudentInfo studentInfo) {
        Map<String, Object> msg = new HashMap<String, Object>() {{
            put("isSuccess", false);
        }};
        studentInfo.setStudentId(getStudentIdWithInt());
        studentInfo.setUpdateType(UpdateType.StuSet);
        if (studentService.update(studentInfo)) {
            msg.put("isSuccess", true);
        }
        return msg;
    }

    /**
     * 返回 测试题 试卷开始路径
     *
     * @param examInfo .
     * @return 测试页面
     */
    @RequestMapping(value = "/readyTest", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> readyTest(@RequestBody ExamInfo examInfo, Model model) {
        Map<String, Object> data = new HashMap<>();
        if (!"4".equals(examInfo.getTestNum())) {
            data.put("generalTest", true);
            data.put("examInfo", examInfo.getCourseId() + "_" + examInfo.getContent() + "_" + examInfo.getTestNum());
        } else {
            data.put("generalTest", false);
            data.put("examInfo", examInfo.getCourseId());
        }
        return data;
    }

    /**
     * 返回 普通测试 试题页面
     *
     * @return url
     */
    @RequestMapping(value = "/startTest", method = RequestMethod.GET)
    public String startTest(HttpServletRequest request, Model model) {
        String examInfo1 = request.getParameter("examInfo");
        String[] s = examInfo1.split("_");
        ExamInfo examInfo = new ExamInfo();
        examInfo.setCourseId(Integer.valueOf(s[0]));
        examInfo.setContent(s[1]);
        examInfo.setTestNum(s[2]);
        TestPaper testPaper = studentService.selectTestPaper(null, examInfo);
        model.addAttribute("exception", "后台数据异常");
        if (null != testPaper) {
            model.addAttribute("testPaper", testPaper);
            return "/student/exam/testProxy";
        } else return "/common/error/error";
    }

    /**
     * 返回 附加题 测试页面
     *
     * @return String
     */
    @RequestMapping(value = "/startTestAnother", method = RequestMethod.GET)
    public String startTestAnother(HttpServletRequest request, Model model) {
        String examInfo1 = request.getParameter("examInfo");
        String[] s = examInfo1.split("_");
        ExamInfo examInfo = new ExamInfo();
        examInfo.setCourseId(Integer.valueOf(s[0]));
        model.addAttribute("testPaper", studentService.selectTestPaperAnother(null, getStudentIdWithInt(), examInfo));
        return "/student/exam/testAnotherProxy";
    }

    /**
     * 上传学生测试成绩或者答案
     *
     * @param gradeInfo .
     * @return Map
     */
    @RequestMapping(value = "/uploadGrade", method = RequestMethod.POST)
    @ResponseBody
    public Map uploadGrade(@RequestBody GradeInfo gradeInfo) {
        Map<String, Object> info = new HashMap<>();
        gradeInfo.setStudentId(getStudentIdWithInt());
        if (studentService.insertGrade(gradeInfo)) {
            info.put("issuccess", true);
        } else info.put("issuccess", false);
        return info;
    }
}
