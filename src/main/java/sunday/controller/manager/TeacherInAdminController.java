package sunday.controller.manager;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sunday.common.kit.CommonKit;
import sunday.controller.common.CommonController;
import sunday.pojo.teacher.Teacher;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/28.
 * At 21:53
 */
@Controller
@RequestMapping("/admin/teacher")
public class TeacherInAdminController extends CommonController{
    /**
     * 教师界面
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
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
    @RequestMapping(value = "/list", method = RequestMethod.POST)
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
}
