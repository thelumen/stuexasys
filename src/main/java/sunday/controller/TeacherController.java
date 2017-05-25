package sunday.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import sunday.service.TeacherService;

/**
 * Created by yang on 2017/5/25.
 * At 10:09
 */
@Controller
@RequestMapping("/teacher")
public class TeacherController {
    @javax.annotation.Resource(name = "teacherService")
    private TeacherService teacherService;

    /**
     * 转到教师主页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main() {
        return "/teacher/main/mainProxy";
    }





}
