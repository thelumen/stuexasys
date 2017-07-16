package sunday.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sunday.common.kit.ShiroKit;
import sunday.pojo.student.ExamInfo;
import sunday.pojo.student.GradeInfo;
import sunday.pojo.student.StudentInfo;
import sunday.pojo.student.StudentTaken;
import sunday.service.student.StudentService;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/student")
public class StudentController {

    @javax.annotation.Resource(name = "studentService")
    private StudentService studentService;

    /**
     * 从Session中获取当前登录学生的id
     *
     * @return 当前登录学生的id
     */
    private Integer getCurrentStudentId() {
        return (Integer) ShiroKit.getSession().getAttribute("currentStudentId");
    }

    /**
     * 查询并返回当前登录学生的基本信息
     *
     * @return List<Student>
     */
    private List<StudentTaken> getCurrentStudentInfo() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", getCurrentStudentId());
        }};
        return studentService.selectStudentInfo(null, params);
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
     * （遗留问题 待解决）
     */
    @RequestMapping(value = "/main", method = RequestMethod.POST)
    public void homepage(Model model) {
        model.addAttribute("studentInfo", getCurrentStudentInfo().get(0));
        //return "/student/main/mainProxy";
    }

    /**
     * 转到学生 个人信息 页
     * 向 model 中添加学生的人信息 studentInfo,studentCourse,studentGrade
     *
     * @return 个人信息 url
     */
    @RequestMapping(value = "/personPage", method = RequestMethod.GET)
    public String personPage(Model model) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", getCurrentStudentId());
        }};
        model.addAttribute("studentCourse", studentService.selectCourse(null, params));
        model.addAttribute("studentGrade", studentService.selectGrade(null, params));
        model.addAttribute("studentInfo", getCurrentStudentInfo().get(0));
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
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", getCurrentStudentId());
        }};
        model.addAttribute("studentExamInfo", studentService.selectExamInfo(null, params));
        model.addAttribute("studentInfo", getCurrentStudentInfo().get(0));
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
        model.addAttribute("studentInfo", getCurrentStudentInfo().get(0));
        return "/student/resourcesDownload/resourcesDownloadProxy";
    }

    /**
     * 更新学会个人信息
     *
     * @return 成功信号
     */
    @RequestMapping(value = "/updateStudentInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateStudentInfo(@RequestBody StudentInfo studentInfo) {
        boolean isSuccess = false;
        Map<String, Object> msg = new HashMap<String, Object>() {{
            put("msg", "isFail");
        }};
        studentInfo.setStudentId(getCurrentStudentId());
        if (studentService.update(studentInfo)) {
            isSuccess = true;
        }
        if (isSuccess) {
            msg.put("msg", "isSuccess");
            return msg;
        }
        return null;
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
        model.addAttribute("studentInfo", getCurrentStudentInfo().get(0));
        Map<String, Object> data = new HashMap<>();
        if (!"4".equals(examInfo.getTestNum())){
            data.put("generalTest", true);
            data.put("examInfo", examInfo.getCourseId() + "_" + examInfo.getContent() + "_" + examInfo.getTestNum());
        }else {
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
        model.addAttribute("studentInfo", getCurrentStudentInfo().get(0));
        model.addAttribute("testPaper", studentService.selectTestPaper(null, examInfo));
        return "/student/exam/testProxy";
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
        model.addAttribute("studentInfo", getCurrentStudentInfo().get(0));
        model.addAttribute("testPaper", studentService.selectTestPaperAnother(null,examInfo));
        return "/student/exam/testAnotherProxy";
    }

    /**
     * 上传学生测试成绩
     * 测试 一 二 三
     * @param gradeInfo .
     * @return Map
     */
    @RequestMapping(value = "/uploadGrade", method = RequestMethod.POST)
    @ResponseBody
    public Map uploadGrade(@RequestBody GradeInfo gradeInfo) {
        Map<String, Object> info = new HashMap<>();
        gradeInfo.setStudentId(getCurrentStudentId());
        if (studentService.insertGrade(gradeInfo)) {
            info.put("issuccess", true);
        } else info.put("issuccess", false);
        return info;
    }
}
