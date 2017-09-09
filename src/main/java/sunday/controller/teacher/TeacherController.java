package sunday.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sunday.common.kit.EncryptKit;
import sunday.controller.common.CommonController;
import sunday.pojo.teacher.Teacher;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/25.
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
    public boolean updateInfo(@RequestBody Teacher teacher) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", teacher.getTeacherId());
        }};
        List<Teacher> teachers = teacherService.select(null, params);
        if (null != teachers) {
            Teacher t = teachers.get(0);
            //后台接收的密码是加密了的
            if (!teacher.getPassword().equals(t.getPassword())) {
                String password = teacher.getPassword();
                teacher.setPassword(EncryptKit.md5(password));
            } else {
                teacher.setPassword(null);
            }
            return teacherService.update(teacher);
        }
        return false;
    }

}
