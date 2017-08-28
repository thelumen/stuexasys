package sunday.controller;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sunday.common.kit.CommonKit;
import sunday.common.kit.ShiroKit;
import sunday.controller.common.CommonController;
import sunday.pojo.manager.Manager;
import sunday.pojo.teacher.Teacher;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/15.
 * At 15:48
 */
@Controller
@RequestMapping("/admin")
public class ManagerController extends CommonController {

    /**
     * 获取当前管理员身份id
     *
     * @return
     */
    private Integer getCurrentManagerId() {
        return ((Manager) ShiroKit.getSession().getAttribute("currentManager")).getManagerId();
    }

    /**
     * 主页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = {"shiro:sys:manager"})
    public String main() {
        return "/manager/main/mainProxy";
    }

    /**
     * 教师界面
     *
     * @return
     */
    @RequestMapping(value = "/teacher", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = {"shiro:sys:manager"})
    public String retTeacher() {
        return "/manager/teacher/teacherProxy";
    }

    /**
     * 获取教师数据
     *
     * @return
     */
    @RequestMapping(value = "/teacher/list", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = {"shiro:sys:manager"})
    @ResponseBody
    public Map<String, Object> getTeachers(@RequestBody Map<String, Object> params) {
        List<Teacher> teachers = teacherService.select(CommonKit.getMapInfo2Page(params), null);
        if (null != teachers) {
            return CommonKit.getTakenInfo(teachers);
        }
        return null;
    }

    @RequestMapping(value = "/student", method = RequestMethod.GET)
    public String EditStudent() {
        return "/manager/student/studentProxy";
    }

    @RequestMapping(value = "/initStudentTable", method = RequestMethod.POST)
    public Map<String, Object> initStudentTable() {

        return null;
    }
}
