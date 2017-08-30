package sunday.controller.manager;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import sunday.controller.common.CommonController;

/**
 * Created by yang on 2017/8/30.
 * At 16:42
 */
@Controller
@RequestMapping("/admin/school")
public class SchoolInAdminController extends CommonController {

    /**
     * 转至学校配置主页
     *
     * @return
     */
    @RequestMapping(value = "/main",method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:manager")
    public String main(){
        return "/manager/school/schoolProxy";
    }

}
