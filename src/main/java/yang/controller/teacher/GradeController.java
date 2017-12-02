package yang.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import yang.common.base.ResultBean;
import yang.common.kit.CommonKit;
import yang.common.kit.TeacherKit;
import yang.controller.common.CommonController;
import yang.domain.dto.GradePercent;
import yang.domain.teacher.AnotherTaken;
import yang.domain.teacher.GradeTaken;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @author yang
 * @date 2017/8/24
 * At 22:30
 */
@Controller
@RequestMapping("/grade")
public class GradeController extends CommonController {

    /**
     * 转到成绩统计页面
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String studentPage() {
        return "/teacher/grade/gradeProxy";
    }

    /**
     * 统计学生总成绩
     *
     * @param percentInfo
     * @return
     */
    @RequestMapping(value = "/assign", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object assignGrades(@RequestBody GradePercent percentInfo) {
        float p1 = 0.0f, p2 = 0.0f, p3 = 0.0f, p4 = 0.0f;

        if (!Objects.equals(percentInfo.getPercent1(), "")) {
            p1 = Float.parseFloat(percentInfo.getPercent1()) / 100.0f;
        }
        if (!Objects.equals(percentInfo.getPercent2(), "")) {
            p2 = Float.parseFloat(percentInfo.getPercent2()) / 100.0f;
        }
        if (!Objects.equals(percentInfo.getPercent3(), "")) {
            p3 = Float.parseFloat(percentInfo.getPercent3()) / 100.0f;
        }
        if (!Objects.equals(percentInfo.getPercent4(), "")) {
            p4 = Float.parseFloat(percentInfo.getPercent4()) / 100.0f;
        }

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("specialtyId", percentInfo.getSpecialtyId());
            put("courseId", percentInfo.getCourseId());
        }};
        List<GradeTaken> studentGrades = student2GradeService.selectGradeTaken(null, params);
        if (null == studentGrades) {
            return new ResultBean<>("此专业的学生还未进行过测试！");
        }

        float total;
        for (GradeTaken studentGrade : studentGrades) {
            total = studentGrade.getGrade1() * p1 + studentGrade.getGrade2() * p2 + studentGrade.getGrade3() * p3 + studentGrade.getGrade4() * p4;
            //采用四舍五入方式计算总成绩
            studentGrade.setTotal(Math.round(total));
            student2GradeService.updateGrade(studentGrade);
        }

        return new ResultBean<>(true);
    }

    /**
     * 获取指定专业学生的成绩
     *
     * @param specialtyId
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/{specialtyId}/{courseId}", method = RequestMethod.POST)
    @ResponseBody
    public Object getGradeBySpecialtyId(@RequestBody Map<String, Object> params,
                                        @PathVariable("specialtyId") Integer specialtyId,
                                        @PathVariable("courseId") Integer courseId) {
        Map<String, Object> info = new HashMap<String, Object>() {{
            put("teacherId", TeacherKit.getCurrentTeacherId());
            put("specialtyId", specialtyId);
            put("courseId", courseId);
        }};
        List<GradeTaken> gradeTakens = student2GradeService.selectGradeTaken(CommonKit.getMapInfo2Page(params), info);
        return CommonKit.getTakenInfo(gradeTakens);
    }

    /**
     * 获取所教专业所有学生的成绩信息
     *
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public Object getAllStudentGrade(@RequestBody Map<String, Object> params) {
        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", TeacherKit.getCurrentTeacherId());
        }};
        List<GradeTaken> gradeTakens = student2GradeService.selectGradeTaken(CommonKit.getMapInfo2Page(params), teacherInfo);
        return CommonKit.getTakenInfo(gradeTakens);
    }

    /**
     * 转到附加题评分页
     *
     * @return
     */
    @RequestMapping(value = "/another/main", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String otherQuestionPage() {
        return "/teacher/another/anotherProxy";
    }

    /**
     * 获取某专业学生信息anotherTaken
     *
     * @param courseId
     * @param specialtyId
     * @return
     */
    @RequestMapping(value = "/{courseId}/{specialtyId}/another", method = RequestMethod.GET)
    @ResponseBody
    public List<AnotherTaken> getAnother(@PathVariable("courseId") Integer courseId,
                                         @PathVariable("specialtyId") Integer specialtyId) {
        if (null == courseId || null == specialtyId) {
            return null;
        }
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("courseId", courseId);
            put("specialtyId", specialtyId);
        }};
        return teacher2QuestionService.selectAnother(params);
    }

    /**
     * 查询单个学生附加题答题情况
     *
     * @param content
     * @return
     */
    @RequestMapping(value = "/another/{content}", method = RequestMethod.POST)
    @ResponseBody
    public AnotherTaken getStudentResult(@PathVariable("content") String content) {
        String[] ele = content.split("&");
        //只有三个值
        if (ele.length != 3) {
            return null;
        }
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("id", Long.valueOf(ele[0]));
            put("courseId", ele[1]);
            put("studentId", ele[2]);
        }};
        List<AnotherTaken> takens = teacher2QuestionService.selectAnother(params);

        return null != takens ? takens.get(0) : null;
    }

    /**
     * 更新附加题成绩
     *
     * @param studentId 学号
     * @param courseId  课程号
     * @param score     成绩
     * @return
     */
    @RequestMapping(value = "/{studentId}/{courseId}/{score}", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean recordGrade4(@PathVariable("studentId") Integer studentId,
                                @PathVariable("courseId") Integer courseId,
                                @PathVariable("score") int score) {
        if (null == studentId || null == courseId) {
            return false;
        }
        //前台不做了，后台修改数据
        if (score < 0) {
            score = 0;
        }
        if (score > 100) {
            score = 100;
        }
        return student2GradeService.updateAnother(studentId, courseId, score);
    }
}
