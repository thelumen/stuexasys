package yang.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import yang.common.kit.CommonKit;
import yang.common.kit.TeacherKit;
import yang.controller.common.CommonController;
import yang.domain.teacher.ExamTaken;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
            put("teacherId", TeacherKit.getCurrentTeacherId());
            put("courseId", courseId);
            put("specialtyId", specialtyId);
        }};
        List<ExamTaken> examTakens = student2ExamService.selectExamTaken(null, specouInfo);
        if (null != examTakens) {
            return false;
        }

        ExamTaken exam = new ExamTaken();
        exam.setTeacherId(TeacherKit.getCurrentTeacherId());
        exam.setCourseId(courseId);
        exam.setSpecialtyId(specialtyId);
        exam.setTest(1);
        exam.setStarted(0);

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
    @RequestMapping(value = "/modal/list", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getTableExamInfo() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", TeacherKit.getCurrentTeacherId());
        }};
        List<ExamTaken> examTakens = student2ExamService.selectTableExamInfo(params);
        return CommonKit.getTakenInfo(examTakens);
    }

    /**
     * 更新考试信息
     *
     * @param examInfo
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
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
     * @param info
     * @return
     */
    @RequestMapping(value = "/examInfo/{info}/delete", method = RequestMethod.DELETE)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean deleteExamInfo(@PathVariable("info") String info) {
        String[] strArray = info.split("&");
        if (strArray.length != 3) {
            return false;
        }
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", strArray[0]);
            put("courseId", strArray[1]);
            put("specialtyId", strArray[2]);
        }};

        return student2ExamService.deleteExamInfo(params);
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
    public boolean examStart(@PathVariable("id") Integer id) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("id", id);
            put("started", 1);
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
    public boolean examClose(@PathVariable("id") Integer id) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("id", id);
            put("started", 0);
        }};
        return student2ExamService.startOrCloseExam(params);
    }

}
