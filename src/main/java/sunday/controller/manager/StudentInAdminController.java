package sunday.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sunday.common.kit.CommonKit;
import sunday.controller.common.CommonController;
import sunday.pojo.student.StudentTaken;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/29.
 * At 7:34
 */
@Controller
@RequestMapping("/admin/student")
public class StudentInAdminController extends CommonController{

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String EditStudent() {
        return "/manager/student/studentProxy";
    }

    /**
     * 初始化学生表
     * 默认加载信息异常的学生
     * @param params
     * @return
     */
    @RequestMapping(value = "/initStudentTable", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> initStudentTable(@RequestBody Map<String,Object> params) {
        List<StudentTaken> studentTakenList = studentService.selectStudentInfo(CommonKit.getMapInfo2Page(params), null);
        if(null!=studentTakenList&&studentTakenList.size()!=0){
            return CommonKit.getTakenInfo(studentTakenList);
        }
        return null;
    }

    @RequestMapping(value = "/studentInfoSave",method = RequestMethod.POST)
    @ResponseBody
    public String saveStudentInfo(){

        return null;
    }
}
