package yang.controller.manager;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author yang
 * @date 2017/5/15
 * At 15:48
 */
@Controller
@RequestMapping("/admin")
public class ManagerController {

    /**
     * 主页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresPermissions(value = {"shiro:sys:manager"})
    public String main() {
        return "/manager/main/mainProxy";
    }

}
