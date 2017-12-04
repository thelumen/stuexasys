package yang.controller.manager;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import yang.common.base.ResultBean;
import yang.common.enums.RoleEnum;
import yang.common.kit.CommonKit;
import yang.common.kit.EncryptKit;
import yang.controller.common.CommonController;
import yang.domain.teacher.Teacher;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @author yang
 * @date 2017/8/28
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
    @ResponseBody
    public Object getTeachers(@RequestBody Map<String, Object> params) {
        List<Teacher> teachers = teacherService.select(CommonKit.getMapInfo2Page(params), null);
        return CommonKit.getTakenInfo(teachers);
    }

    /**
     * 新增教师
     *
     * @param teacher
     * @return
     */
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public Object insert(Teacher teacher) {
        Map<String, Object> teacherParams = new HashMap<String, Object>() {{
            put("teacherId", teacher.getTeacherId());
        }};
        List<Teacher> teachers = teacherService.select(null, teacherParams);
        if (null != teachers) {
            return new ResultBean<>("教师Id重复！");
        }
        teacher.setPassword(EncryptKit.md5(teacher.getPassword()));
        if (Objects.equals(teacher.getPosition(), "")) {
            teacher.setPosition("nothing");
        }
        if (Objects.equals(teacher.getOffice(), "")) {
            teacher.setOffice("nothing");
        }
        if (Objects.equals(teacher.getName(), "")) {
            teacher.setName("teacher");
        }
        if (teacherService.insert(teacher) > 0) {
            //添加权限
            roleService.link2Teacher(teacher.getTeacherId(), RoleEnum.TEACHER.getRoleId());
        }
        return new ResultBean<>(true);
    }

    /**
     * 删除教师（仅限超管）
     *
     * @param teacherId
     * @return
     */
    @RequestMapping(value = "/delete/{teacherId}", method = RequestMethod.DELETE)
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public Object delete(@PathVariable(value = "teacherId") Integer teacherId) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", teacherId);
        }};
        return new ResultBean<>(teacherService.delete(teacherId));
    }

    /**
     * 修改教师
     *
     * @param teacher
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:manager")
    @ResponseBody
    public Object edit(Teacher teacher) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("id", teacher.getId());
        }};
        List<Teacher> teachers = teacherService.select(null, params);
        if (null == teachers) {
            return new ResultBean<>("该教师信息已不存在！");
        }
        Teacher t = teachers.get(0);
        //如果修改密码了，就加密
        if (!t.getPassword().equals(teacher.getPassword())) {
            teacher.setPassword(EncryptKit.md5(teacher.getPassword()));
        }
        return new ResultBean<>(teacherService.update(teacher));
    }

}
