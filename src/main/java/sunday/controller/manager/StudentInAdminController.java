package sunday.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import sunday.common.enums.UpdateType;
import sunday.common.kit.CommonKit;
import sunday.controller.common.CommonController;
import sunday.pojo.student.StudentInfo;
import sunday.pojo.student.StudentTaken;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/29.
 * At 7:34
 */
@Controller
@RequestMapping("/admin/student")
public class StudentInAdminController extends CommonController {

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String EditStudent() {
        return "/manager/student/studentProxy";
    }

    /**
     * 初始化学生信息表
     *
     * @param params       分页参数.
     * @param selectOption 预留显示.
     * @return 格式化的信息.
     */
    @RequestMapping(value = "/initStudentTable/{selectOption}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> initStudentTable(@RequestBody Map<String, Object> params, @PathVariable(value = "selectOption") Integer selectOption) {
        Map<String, Object> selectOptionMap = new HashMap<>();
        if (selectOption == 1) {
            selectOptionMap.put("specialtyId", 100000);
        }
        List<StudentTaken> studentTakenList = studentService.selectStudentInfo(CommonKit.getMapInfo2Page(params), selectOptionMap);
        if (null != studentTakenList && studentTakenList.size() != 0) {
            return CommonKit.getTakenInfo(studentTakenList);
        }
        return null;
    }

    /**
     * 保存学生信息的修改
     *
     * @param studentInfo
     * @return
     */
    @RequestMapping(value = "/studentInfoSave", method = RequestMethod.POST)
    @ResponseBody
    public boolean saveStudentInfo(@RequestBody StudentInfo studentInfo) {
        studentInfo.setUpdateType(UpdateType.AdminSet);
        return studentService.update(studentInfo);
    }

    /**
     * 删除学生
     *
     * @param studentInfo .
     * @return .
     */
    @RequestMapping(value = "/studentInfoDel", method = RequestMethod.POST)
    @ResponseBody
    public boolean deleteStudent(@RequestBody StudentInfo studentInfo) {
        return studentService.delete(studentInfo);
    }

    @RequestMapping(value = "/specialtyGet",method = RequestMethod.POST)
    @ResponseBody
    public List<Map<String, Object>> loadSpecialty(){
        return adminStudentService.selectSpecialty();
    }
}
