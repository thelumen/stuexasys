package yang.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import yang.common.base.ResultBean;
import yang.common.kit.CommonKit;
import yang.common.kit.StringKit;
import yang.controller.common.CommonController;
import yang.domain.common.Another;
import yang.domain.common.SingleQuestion;
import yang.domain.common.TfQuestion;
import yang.domain.teacher.AnotherTaken;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2017/8/24
 * At 21:41
 */
@Controller
@RequestMapping("/question")
public class QuestionController extends CommonController {

    /**
     * 转到题目录入页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String questionPage() {
        return "/teacher/question/questionProxy";
    }

    /**
     * 新增选择题
     *
     * @param question
     * @return
     */
    @RequestMapping(value = "/single/insert", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object saveSingleQuestion(@RequestBody SingleQuestion question) {
        String section = question.getSection();
        if (!StringKit.isContainChinese(section)) {
            question.setSection(CommonKit.string2Chinese(section));
        }
        return new ResultBean<>(teacher2QuestionService.insertSingleQuestion(question));
    }

    /**
     * 新增判断题
     *
     * @param question
     * @return
     */
    @RequestMapping(value = "/tfQuestion/insert", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object saveTfQuestion(TfQuestion question) {
        String section = question.getSection();
        if (!StringKit.isContainChinese(section)) {
            question.setSection(CommonKit.string2Chinese(section));
        }
        return new ResultBean<>(teacher2QuestionService.insertTfQuestion(question));
    }

    /**
     * 新增附加题
     *
     * @param another
     * @return
     */
    @RequestMapping(value = "/another/insert", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object saveAnother(@RequestBody Another another) {
        return new ResultBean<>(teacher2QuestionService.insertAnother(another));
    }

    /**
     * 选择题管理
     *
     * @return
     */
    @RequestMapping(value = "/showSingle", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String singlePage() {
        return "/teacher/question/showSingleProxy";
    }

    /**
     * 按条件查询选择题
     *
     * @param params
     * @param courseId
     * @param section
     * @return
     */
    @RequestMapping(value = "/single/list/{courseId}/{section}", method = RequestMethod.POST)
    @ResponseBody
    public Object selectSingle(@RequestBody Map<String, Object> params,
                               @PathVariable(value = "courseId") String courseId,
                               @PathVariable(value = "section") String section) {
        Map<String, Object> selectOption = new HashMap<String, Object>() {{
            put("courseId", courseId);
            put("section", CommonKit.string2Chinese(section));
        }};
        List<SingleQuestion> singleQuestionList =
                teacher2QuestionService.selectSingleInfo(CommonKit.getOrginMapInfo2Page(params), selectOption);
        return CommonKit.getTakenInfo(singleQuestionList);
    }

    /**
     * 更新选择题
     *
     * @param singleQuestion
     * @return
     */
    @RequestMapping(value = "/single/update", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object updateSingleInfo(@RequestBody SingleQuestion singleQuestion) {
        return new ResultBean<>(teacher2QuestionService.updateSingleInfo(singleQuestion));
    }

    /**
     * 删除选择题
     *
     * @param singleQuestion
     * @return
     */
    @RequestMapping(value = "/single/delete", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object deleteTfInfo(@RequestBody SingleQuestion singleQuestion) {
        return new ResultBean<>(teacher2QuestionService.deleteSingleInfo(singleQuestion));
    }

    /**
     * 判断题管理
     *
     * @return
     */
    @RequestMapping(value = "/showTf", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String tfPage() {
        return "/teacher/question/showTfProxy";
    }

    /**
     * 按条件查询判断题
     *
     * @param params   分页信息
     * @param courseId 课程号
     * @param section  章节信息
     * @return
     */
    @RequestMapping(value = "/tf/list/{courseId}/{section}", method = RequestMethod.POST)
    @ResponseBody
    public Object selectTf(@RequestBody Map<String, Object> params,
                           @PathVariable(value = "courseId") String courseId,
                           @PathVariable(value = "section") String section) {
        Map<String, Object> selectOption = new HashMap<String, Object>() {{
            put("courseId", courseId);
            put("section", CommonKit.string2Chinese(section));
        }};
        List<TfQuestion> tfQuestionList =
                teacher2QuestionService.selectTfInfo(CommonKit.getOrginMapInfo2Page(params), selectOption);
        return CommonKit.getTakenInfo(tfQuestionList);
    }

    /**
     * 更新判断题
     *
     * @param tfQuestion 前台传入的判断题封装信息
     * @return
     */
    @RequestMapping(value = "/tf/update", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object updateTfInfo(@RequestBody TfQuestion tfQuestion) {
        return new ResultBean<>(teacher2QuestionService.updateTfInfo(tfQuestion));
    }

    //删除判断题
    @RequestMapping(value = "/tf/delete", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object deleteTfInfo(@RequestBody TfQuestion tfQuestion) {
        return new ResultBean<>(teacher2QuestionService.deleteTfInfo(tfQuestion));
    }

    /**
     * 附加题编辑界面
     *
     * @return .
     */
    @RequestMapping(value = "/editQuestion", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String editQuestion() {
        return "/teacher/editQuestion/editQuestionProxy";
    }

    /**
     * 自定义查询附加题
     *
     * @return .
     */
    @RequestMapping(value = "/another/list/{courseId}", method = RequestMethod.POST)
    @ResponseBody
    public Object selectWithCourse(@PathVariable(value = "courseId") String courseId) {
        Map<String, Object> info = new HashMap<String, Object>() {{
            put("courseId", courseId);
        }};
        List<AnotherTaken> qiestions = questionService.selectAnotherQuestion(info);
        return CommonKit.getTakenInfo(qiestions);
    }

    /**
     * 更新附加题
     *
     * @return
     */
    @RequestMapping(value = "/another/update", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object saveQuestion(@RequestBody AnotherTaken anotherTaken) {
        return new ResultBean<>(questionService.saveQuestion(anotherTaken));
    }

    /**
     * 删除附加题
     *
     * @return .
     */
    @RequestMapping(value = "/another/delete", method = RequestMethod.DELETE)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object delQuestion(@RequestBody AnotherTaken anotherTaken) {
        Map<String, Object> info = new HashMap<String, Object>() {{
            put("id", anotherTaken.getId());
        }};
        return new ResultBean<>(questionService.delQuestion(info));
    }

}
