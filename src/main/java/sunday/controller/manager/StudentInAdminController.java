package sunday.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import sunday.controller.common.CommonController;

import java.util.Map;

/**
 * Created by yang on 2017/8/29.
 * At 7:34
 */
@Controller
@RequestMapping("/admin/student")
public class StudentInAdminController extends CommonController{

    @RequestMapping(value = "/student", method = RequestMethod.GET)
    public String EditStudent() {
        return "/manager/student/studentProxy";
    }

    @RequestMapping(value = "/initStudentTable", method = RequestMethod.POST)
    public Map<String, Object> initStudentTable() {

        return null;
    }

}
