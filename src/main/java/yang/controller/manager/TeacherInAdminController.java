package yang.controller.manager;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
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
    public Map<String, Object> getTeachers(@RequestBody Map<String, Object> params) {
        List<Teacher> teachers = teacherService.select(CommonKit.getMapInfo2Page(params), null);
        return CommonKit.getTakenInfo(teachers);
    }

    /**
     * 转至添加教师界面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/insert", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:manager")
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
    @RequiresPermissions(value = "shiro:sys:admin")
    public String insert(Teacher teacher) {
        Map<String, Object> teacherParams = new HashMap<String, Object>() {{
            put("teacherId", teacher.getTeacherId());
        }};
        List<Teacher> teachers = teacherService.select(null, teacherParams);
        if (null == teachers) {
            teacher.setPassword(EncryptKit.md5(teacher.getPassword()));
            if (Objects.equals(teacher.getPosition(), "")) {
                teacher.setPosition("Nothing To Show");
            }
            if (Objects.equals(teacher.getOffice(), "")) {
                teacher.setOffice("Nothing To Show");
            }
            if (Objects.equals(teacher.getName(), "")) {
                teacher.setName("Teacher X");
            }
            if (teacherService.insert(teacher) > 0) {
                //添加权限
                roleService.link2Teacher(teacher.getTeacherId(), RoleEnum.TEACHER.getRoleId());
            }
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
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public boolean delete(@PathVariable(value = "teacherId") int teacherId) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", teacherId);
        }};
        return student2ExamService.deleteExamInfo(params) && courseService.deleteCourseTakenByTeacherId(teacherId) > 0 && teacherService.delete(teacherId);
    }

    /**
     * 转至教师信息页
     *
     * @param model
     * @param teacherId
     * @return
     */
    @RequestMapping(value = "/edit/{teacherId}", method = RequestMethod.GET)
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
     * 修改教师
     *
     * @param teacher
     * @return
     */
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
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