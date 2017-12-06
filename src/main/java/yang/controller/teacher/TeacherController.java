package yang.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import yang.common.base.ResultBean;
import yang.common.kit.EncryptKit;
import yang.common.kit.StringKit;
import yang.controller.common.CommonController;
import yang.domain.teacher.Teacher;

import java.util.Objects;

/**
 * @author yang
 * @date 2017/5/25
 * At 10:09
 */
@Controller
@RequestMapping("/teacher")
public class TeacherController extends CommonController {

    /**
     * 转到教师主页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String main() {
        return "/teacher/main/mainProxy";
    }

    /**
     * 修改教师信息
     *
     * @param teacher
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object updateInfo(@RequestBody Teacher teacher) {
        String pwd = teacher.getPassword().trim();
        if (StringKit.isBank(pwd) || pwd.length() < 3) {
            return new ResultBean<>("密码不为空且不能小于3位：)");
        }
        if (!Objects.equals(teacher.getPassword(), "******")) {
            teacher.setPassword(EncryptKit.md5(pwd));
        } else {
            teacher.setPassword(null);
        }
        return new ResultBean<>(teacherService.update(teacher));
    }

}
