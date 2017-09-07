package sunday.controller.manager;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import sunday.common.enums.UpdateType;
import sunday.common.kit.CommonKit;
import sunday.controller.common.CommonController;
import sunday.pojo.student.StudentInfo;
import sunday.pojo.student.StudentTaken;

import java.util.*;

/**
 * Created by yang on 2017/8/29.
 * At 7:34
 */
@Controller
@RequestMapping("/admin/student")
public class StudentInAdminController extends CommonController {

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:manager")
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
    public Map<String, Object> initStudentTable(@RequestBody Map<String, Object> params,
                                                @PathVariable(value = "selectOption") Integer selectOption) {
        Map<String, Object> selectOptionMap = new HashMap<>();
        if (selectOption == 1) {
            selectOptionMap.put("specialtyId", new ArrayList<String>(){{add("100000");}});
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
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:manager")
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
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public boolean deleteStudent(@RequestBody StudentInfo studentInfo) {
        return studentService.delete(studentInfo);
    }

    /**
     * 加载专业信息
     *
     * @return
     */
    @RequestMapping(value = "/specialtyGet", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> loadSpecialty() {
        return adminStudentService.selectSpecialty();
    }

    @RequestMapping(value = "/loadStudent/{specialty}/{studentId}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectStudent(
            @RequestBody Map<String, Object> params,
            @PathVariable(value = "specialty") String specialtyId,
            @PathVariable(value = "studentId") String studentId) {
        Map<String, Object> selectOption = new HashMap<>();
        if ("0".equals(specialtyId)) {
            selectOption.put("specialtyId", null);
        } else {
            selectOption.put("specialtyId", Arrays.asList(specialtyId.split(",")));
        }
        if ("0".equals(studentId)) {
            selectOption.put("studentId", null);
        } else {
            selectOption.put("studentId", studentId);
        }
        List<StudentTaken> studentTakenList = studentService.selectStudentInfo(CommonKit.getMapInfo2Page(params), selectOption);
        if (null != studentTakenList && studentTakenList.size() != 0) {
            return CommonKit.getTakenInfo(studentTakenList);
        }
        return null;
    }
}
