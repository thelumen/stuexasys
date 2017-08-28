package sunday.controller.manager;

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


}
