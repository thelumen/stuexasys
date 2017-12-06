package yang.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import yang.common.enums.UserTypeEnum;
import yang.common.kit.EncryptKit;
import yang.common.kit.ShiroKit;
import yang.common.kit.StringKit;
import yang.controller.common.CommonController;

/**
 * @author yang
 * @date 2017/5/22
 * At 13:55
 */
@Controller
@RequestMapping("/shiro")
public class ShiroController extends CommonController {

    /**
     * 转至登录页面
     *
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "/common/user/login";
    }

    /**
     * 退出
     *
     * @return
     */
    @RequestMapping("/logout")
    public String logout() {
        ShiroKit.getSubject().logout();
        return "/common/user/login";
    }

    /**
     * 登录
     *
     * @param account  账号
     * @param password 密码
     * @param type     用户类型
     * @param model
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(String account, String password, String type, Model model) {
        String realAccount = StringKit.trim(account) + type;
        String url = "";
        if (ShiroKit.login(realAccount, EncryptKit.md5(password))) {
            for (UserTypeEnum user : UserTypeEnum.values()) {
                if (user.getNum().equals(type)) {
                    url = user.getUrl();
                }
            }
        } else {
            model.addAttribute("exception", "登入失败，可能原因：1.账号信息错误；2.身份类型错误（管理员？教师？学生？）；3.不存在该账号.");
            url = "/common/user/login";
        }
        return url;
    }

}

