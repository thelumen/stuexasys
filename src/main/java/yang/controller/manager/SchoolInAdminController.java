package yang.controller.manager;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yang.common.base.ResultBean;
import yang.common.enums.DeleteType;
import yang.controller.common.CommonController;
import yang.domain.common.Course;
import yang.domain.common.Specialty;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/8/30
 * At 16:42
 */
@Controller
@RequestMapping("/admin/school")
public class SchoolInAdminController extends CommonController {

    /**
     * 学校配置主页
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:manager")
    public String main(Model model) {
        getSpecialty(model);
        getCourse(model);
        return "/manager/school/schoolProxy";
    }

    /**
     * 获取专业
     *
     * @param model
     */
    private void getSpecialty(Model model) {
        List<Specialty> specialties = specialtyService.select(null);
        if (null != specialties) {
            model.addAttribute("specialties", specialties);
        }
    }

    /**
     * 查询课程
     *
     * @param model
     */
    private void getCourse(Model model) {
        List<Course> courses = courseService.select(null);
        if (null != courses) {
            model.addAttribute("courses", courses);
        }
    }

    /**
     * 新增课程
     *
     * @param course
     * @return
     */
    @RequestMapping(value = "/course/insert", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public Object insertCourse(Course course) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("courseId", course.getCourseId());
        }};
        List<Course> courses = courseService.select(params);
        if (null != courses) {
            return new ResultBean<>("专业id重复！");
        }
        return new ResultBean<>(courseService.insert(course));
    }

    /**
     * 删除课程
     *
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/course/delete/{courseId}", method = RequestMethod.DELETE)
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public Object deleteCourse(@PathVariable("courseId") Integer courseId) {
        return new ResultBean<>(courseService.delete(courseId));
    }

    /**
     * 更新课程
     *
     * @param course
     * @return
     */
    @RequestMapping(value = "/course/update", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:manager")
    @ResponseBody
    public Object updateCourse(Course course) {
        return new ResultBean<>(courseService.update(course));
    }

    /**
     * 新增专业
     *
     * @param specialtyId
     * @param year
     * @param specialtyName
     * @return
     */
    @RequestMapping(value = "/specialty/add", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public Object insertSpecialty(@RequestParam(value = "specialtyId") Integer specialtyId,
                                  @RequestParam(value = "specialtyName") String specialtyName) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("specialtyId", specialtyId);
        }};
        List<Specialty> specialties = specialtyService.select(params);
        if (null != specialties) {
            return new ResultBean<>("专业已存在！（专业id起冲突）");
        }

        Specialty s = new Specialty();
        s.setSpecialtyId(specialtyId);
        s.setName(specialtyName + "(" + specialtyId + ")");

        return new ResultBean<>(specialtyService.insert(s));
    }

    /**
     * 更新专业
     *
     * @param specialty
     * @return
     */
    @RequestMapping(value = "/specialty/update", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:manager")
    @ResponseBody
    public Object updateSpecialty(Specialty specialty) {
        specialty.setSpecialtyId(null);
        return new ResultBean<>(specialtyService.update(specialty));
    }

    /**
     * 删除专业
     *
     * @param specialtyId
     * @return
     */
    @RequestMapping(value = "/specialty/delete/{specialtyId}", method = RequestMethod.DELETE)
    @RequiresPermissions(value = "shiro:sys:manager")
    @ResponseBody
    public Object deleteSpecialty(@PathVariable("specialtyId") Integer specialtyId) {
        if (specialtyId == 100000) {
            return new ResultBean<>("预留专业不可删除！");
        }
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("deleteType", DeleteType.DeleteWithSpecialtyId);
            put("specialtyId", new ArrayList<String>() {{
                add(specialtyId.toString());
            }});
        }};
        if (studentService.delete(params) && adminStudentService.deleteSpecialty(params)) {
            return new ResultBean<>(true);
        }
        return new ResultBean<>("系统错误！");
    }

}
