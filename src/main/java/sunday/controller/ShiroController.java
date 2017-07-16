package sunday.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import sunday.common.enums.UserTypeEnum;
import sunday.common.kit.ShiroKit;
import sunday.common.kit.StringKit;
import sunday.common.kit.TypeValidateKit;

/**
 * Created by yang on 2017/5/22.
 * At 13:55
 */
@Controller
@RequestMapping("/shiro")
public class ShiroController {

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
        String url = "";
        String userType = TypeValidateKit.validateUserType(type);
        String realAccount = StringKit.trim(account) + userType;
        if (ShiroKit.login(realAccount, password)) {
            for (UserTypeEnum user : UserTypeEnum.values()) {
                if (user.getNum().equals(userType)) {
                    url = user.getUrl();
                }
            }
        } else {
            model.addAttribute("exception", "登入失败，可能原因：1.账号信息错误；2.身份类型错误（管理员？教师？学生？）；3.不存在该账号.");
            url = "/common/error/error";
        }
        return url;
    }

}

