package sunday.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import sunday.common.kit.ShiroKit;
import sunday.service.student.StudentService;

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


}
