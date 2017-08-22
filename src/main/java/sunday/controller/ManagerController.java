package sunday.controller;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import sunday.common.kit.ShiroKit;
import sunday.pojo.manager.Manager;

/**
 * Created by yang on 2017/5/15.
 * At 15:48
 */
@Controller
@RequestMapping("/admin")
public class ManagerController {

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
}
