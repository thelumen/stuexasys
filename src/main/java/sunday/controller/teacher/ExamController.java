package sunday.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import sunday.common.kit.CommonKit;
import sunday.common.kit.TeacherKit;
import sunday.controller.common.CommonController;
import sunday.pojo.teacher.ExamTaken;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Created by yang on 2017/8/24.
 * At 21:38
 */
@Controller
@RequestMapping("/exam")
public class ExamController extends CommonController {

    /**
     * 转到考试信息页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String examPage() {
        return "/teacher/exam/examProxy";
    }

    /**
     * 添加考试信息
     *
     * @param courseId
     * @param specialtyId
     * @return
     */
    @RequestMapping(value = "/examInfo/{courseId}/{specialtyId}/insert", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean takeExamInfo(@PathVariable("courseId") Integer courseId,
                                @PathVariable("specialtyId") Integer specialtyId) {
        if (null == courseId || null == specialtyId) {
            return false;
        }

        Map<String, Object> specouInfo = new HashMap<String, Object>() {{
            put("courseId", courseId);
            put("specialtyId", specialtyId);
        }};
        List<ExamTaken> examTakens = student2ExamService.selectExamTaken(null, specouInfo);
        if (null != examTakens) {
            return false;
        }

        ExamTaken exam = new ExamTaken();
        exam.setCourseId(courseId);
        exam.setSpecialtyId(specialtyId);
        exam.setStarted(1);

        return student2ExamService.insertExamInfo(exam) > 0;
    }

    /**
     * 获取考试信息
     *
     * @param params
     * @return
     */
    @RequestMapping(value = "/examInfos", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getExamInfo(@RequestBody Map<String, Object> params) {
        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", TeacherKit.getCurrentTeacherId());
        }};
        List<ExamTaken> examTakens = student2ExamService.selectExamTaken(CommonKit.getMapInfo2Page(params), teacherInfo);

        return CommonKit.getTakenInfo(examTakens);
    }

    /**
     * 获取modal中table的考试信息
     *
     * @return
     */
    @RequestMapping(value = "/modal/examInfo/list", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getTableExamInfo() {
        List<ExamTaken> examTakens = student2ExamService.selectTableExamInfo();
        if (null != examTakens) {
            return CommonKit.getTakenInfo(examTakens);
        }
        return null;
    }

    /**
     * 更新考试信息
     *
     * @param examInfo
     * @return
     */
    @RequestMapping(value = "/examInfo/update", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean getChapter(@RequestBody ExamTaken examInfo) throws UnsupportedEncodingException {

        //sign信号只有一个为1才能被保存
        int[] signs = {examInfo.getSign1(), examInfo.getSign2(), examInfo.getSign3(), examInfo.getSign4()};
        int i = 0;
        for (int b : signs) {
            if (b == 1) {
                i++;
            }
        }

        return i == 1 && student2ExamService.updateExamInfo(examInfo) > 0;
    }

    /**
     * 删除考试信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/examInfo/{id}/delete", method = RequestMethod.DELETE)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean deleteExamInfo(@PathVariable("id") String id) {

        return student2ExamService.deleteExamInfo(id);
    }

    /**
     * 开启考试
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/{id}/start", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean examStart(@PathVariable("id") String id) {

        if (id == null || Objects.equals(id, "")) {
            return false;
        }

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("id", id);
            put("test", 1);
        }};

        return student2ExamService.startOrCloseExam(params);
    }

    /**
     * 关闭考试
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/{id}/close", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean examClose(@PathVariable("id") String id) {

        if (id == null || Objects.equals(id, "")) {
            return false;
        }

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("id", id);
            put("test", 0);
        }};

        return student2ExamService.startOrCloseExam(params);
    }

}
