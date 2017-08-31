package sunday.controller.manager;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sunday.controller.common.CommonController;
import sunday.pojo.school.Specialty;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

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
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:manager")
    public String main(Model model) {
        getSpecialty(model);
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
     * 新增专业
     *
     * @param specialtyId
     * @param year
     * @param specialtyName
     * @return
     */
    @RequestMapping(value = "/specialty/add", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public boolean insertSpecialty(@RequestParam(value = "specialtyId") Integer specialtyId,
                                   @RequestParam(value = "year") String year,
                                   @RequestParam(value = "specialtyName") String specialtyName) {
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
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public boolean deleteSpecialty(@PathVariable("specialtyId") Integer specialtyId) {
        if (specialtyId < 100000 || specialtyId > 999999) {
            return false;
        }
        return specialtyService.delete(specialtyId);
    }


}
