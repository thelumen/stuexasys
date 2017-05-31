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
     * @return
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


}
