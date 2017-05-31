package sunday.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import sunday.common.kit.ShiroKit;
import sunday.pojo.school.Student;
import sunday.service.student.StudentService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 花间一壶酒 on 2017/5/29.
 */
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
    private String getCurrentStudentId() {
        return (String) ShiroKit.getSession().getAttribute("currentStudentId");
    }

    /**
     * 查询并返回当前登录学生的基本信息
     *
     * @return List<Student>
     */
    private List<Student> getCurrentStudentInfo() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", getCurrentStudentId());
        }};
        return studentService.select(null, params);
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
     *
     */
    @RequestMapping(value = "/main", method = RequestMethod.POST)
    public void homepage(Model model) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", getCurrentStudentId());
        }};
        //查询学生信息
        List<Student> studentList = studentService.select(null, params);
        //返回相关内容
        model.addAttribute("studentInfo", studentList.get(0));
        //return "/student/main/mainProxy";
    }

    /**
     * 转到学生 个人信息 页
     * 向 model 中添加学生的人信息 studentInfo
     *
     * @return 个人信息 url
     */
    @RequestMapping(value = "/personPage", method = RequestMethod.GET)
    public String personPage(Model model) {
        model.addAttribute("studentInfo", getCurrentStudentInfo().get(0));
        return "/student/personPage/personPageProxy";
    }

    /**
     * 转到学生 测试 页
     * 向 model 中添加学生的人信息 studentInfo
     *
     * @return 测试 url
     */
    @RequestMapping(value = "/exam", method = RequestMethod.GET)
    public String exam(Model model) {
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
}
