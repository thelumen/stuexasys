package yang.controller.manager;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yang.common.enums.DeleteType;
import yang.common.kit.ValidateKit;
import yang.controller.common.CommonController;
import yang.domain.school.Course;
import yang.domain.school.Specialty;

import java.util.*;

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
    public boolean insertCourse(Course course) {
        //校验
        if (!ValidateKit.validateCourse(course)) {
            return false;
        }
        //课程id不能重复
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("courseId", course.getCourseId());
        }};
        List<Course> courses = courseService.select(params);

        return null == courses && courseService.insert(course);
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
    public boolean deleteCourse(@PathVariable("courseId") Integer courseId) {
        return courseService.delete(courseId);
    }

    /**
     * 获取指定课程
     *
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/course/{courseId}", method = RequestMethod.GET)
    @ResponseBody
    public Course getRowInCourse(@PathVariable("courseId") String courseId) {

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("courseId", courseId);
        }};
        List<Course> courses = courseService.select(params);

        return null != courses ? courses.get(0) : null;
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
    public boolean updateCourse(@RequestBody Course course) {
        //通过校验就更新
        return ValidateKit.validateCourse(course) && courseService.update(course);
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
    public boolean insertSpecialty(@RequestParam(value = "specialtyId") Integer specialtyId,
                                   @RequestParam(value = "year") String year,
                                   @RequestParam(value = "specialtyName") String specialtyName) {
        //校验
        if (specialtyId < 100000 || specialtyId > 999999) {
            return false;
        }
        if (Objects.equals(year, "") || Objects.equals(specialtyName, "")) {
            return false;
        }

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("specialtyId", specialtyId);
        }};
        List<Specialty> specialties = specialtyService.select(params);
        if (null != specialties) {
            return false;
        }

        Specialty s = new Specialty();
        s.setSpecialtyId(specialtyId);
        s.setName(year + specialtyName);

        return specialtyService.insert(s) > 0;
    }

    /**
     * 删除专业
     *
     * @param specialtyId
     * @return
     */
    @RequestMapping(value = "/specialty/delete/{specialtyId}", method = RequestMethod.DELETE)
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public boolean deleteSpecialty(@PathVariable("specialtyId") Integer specialtyId) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("deleteType", DeleteType.DeleteWithSpecialtyId);
            put("specialtyId", new ArrayList<String>() {{
                add(specialtyId.toString());
            }});
        }};
        return studentService.delete(params) && adminStudentService.deleteSpecialty(params);
    }

    /**
     * 获取指定专业信息
     *
     * @param specialtyId
     * @return
     */
    @RequestMapping(value = "/specialty/{specialtyId}", method = RequestMethod.GET)
    @ResponseBody
    public Specialty getRowInSpecialty(@PathVariable("specialtyId") String specialtyId) {

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("specialtyId", specialtyId);
        }};
        List<Specialty> specialties = specialtyService.select(params);

        return null != specialties ? specialties.get(0) : null;
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
    public boolean updateSpecialty(@RequestBody Specialty specialty) {
        //校验通过则更新
        return ValidateKit.validateSpecialty(specialty) && specialtyService.update(specialty);
    }

}
