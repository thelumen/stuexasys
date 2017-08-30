package sunday.controller.manager;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sunday.common.enums.RoleEnum;
import sunday.common.kit.CommonKit;
import sunday.common.kit.EncryptKit;
import sunday.controller.common.CommonController;
import sunday.pojo.teacher.Teacher;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/28.
 * At 21:53
 */
@Controller
@RequestMapping("/admin/teacher")
public class TeacherInAdminController extends CommonController {

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

    /**
     * 转至添加教师界面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/insert", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:admin")
    public String insert(Model model) {
        model.addAttribute("action", "insert");
        return "/manager/teacher/formProxy";
    }

    /**
     * 新增教师
     *
     * @param teacher
     * @return
     */
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:admin")
    public String insert(Teacher teacher) {
        teacher.setPassword(EncryptKit.md5(teacher.getPassword()));
        if (teacherService.insert(teacher) > 0) {
            //添加权限
            roleService.link2Teacher(teacher.getTeacherId(), RoleEnum.TEACHER.getRoleId());
        }
        return "/manager/teacher/teacherProxy";
    }

    /**
     * 删除教师（仅限超管）
     *
     * @param teacherId
     * @return
     */
    @RequestMapping(value = "/delete/{teacherId}", method = RequestMethod.DELETE)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public boolean delete(@PathVariable(value = "teacherId") int teacherId) {
        return teacherService.delete(teacherId);
    }

    /**
     * 转至教师信息页
     *
     * @param model
     * @param teacherId
     * @return
     */
    @RequestMapping(value = "/edit/{teacherId}", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:manager")
    public String edit(Model model, @PathVariable(value = "teacherId") Integer teacherId) {
        getTeacherInfo(model, teacherId);
        model.addAttribute("action", "edit");
        return "/manager/teacher/formProxy";
    }

    /**
     * 以教工号获取教师信息
     *
     * @param model
     * @param teacherId
     */
    private void getTeacherInfo(Model model, Integer teacherId) {
        Map<String, Object> teacherParms = new HashMap<String, Object>() {{
            put("teacherId", teacherId);
        }};
        List<Teacher> teachers = teacherService.select(null, teacherParms);
        if (null != teachers) {
            model.addAttribute("teacherInfo", teachers.get(0));
        }
    }

    /**
     * 修改教师（仅限超管）
     *
     * @param teacher
     * @return
     */
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:manager")
    public String edit(Teacher teacher) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("id", teacher.getId());
        }};
        List<Teacher> teachers = teacherService.select(null, params);
        if (null != teachers) {
            Teacher t = teachers.get(0);
            //如果修改密码了，就加密
            if (!t.getPassword().equals(teacher.getPassword())) {
                teacher.setPassword(EncryptKit.md5(teacher.getPassword()));
            }
            //教工号不能变
            teacher.setTeacherId(t.getTeacherId());
            teacherService.update(teacher);
        }

        return "/manager/teacher/teacherProxy";
    }
}
