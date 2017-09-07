package sunday.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import sunday.common.enums.UpdateType;
import sunday.common.kit.ChapterKit;
import sunday.common.kit.CommonKit;
import sunday.common.kit.TeacherKit;
import sunday.controller.common.CommonController;
import sunday.pojo.school.Another;
import sunday.pojo.school.SingleQuestion;
import sunday.pojo.school.TfQuestion;
import sunday.pojo.student.TfTaken;

import java.util.*;

/**
 * Created by yang on 2017/8/24.
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
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String questionPage() {
        return "/teacher/question/questionProxy";
    }

    /**
     * 转到判断题目查看页
     *
     * @return
     */
    @RequestMapping(value = "/showTf", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String tfPage() {
        return "/teacher/question/showTfProxy";
    }

    /**
     * 转到选择题目查看页
     *
     * @return
     */
    @RequestMapping(value = "/showSingle", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String singlePage() {
        return "/teacher/question/showSingleProxy";
    }


    /**
     * 获取某一课程选择题的章节
     *
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/{courseId}/chapter", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getCourseChapter(@PathVariable("courseId") Integer courseId) {
        //如果courseId为null，则会查询出所有的信息
        if (null == courseId) {
            return null;
        }

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("courseId", courseId);
        }};
        List<SingleQuestion> questions = teacher2QuestionService.selectSingleQuestion(params);
        if (null != questions) {
            //按章节排序
            List<String> target = ChapterKit.bubbleSort(questions);
            List<Map<String, Object>> father = new ArrayList<>();
            TeacherKit.getSelectInfo(target, father);
            return father;
        }
        return null;
    }

    /**
     * 新增选择题
     *
     * @param question
     * @return
     */
    @RequestMapping(value = "/single/insert", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean saveSingleQuestion(@RequestBody SingleQuestion question) {

        return teacher2QuestionService.insertSingleQuestion(question) > 0;
    }

    /**
     * 新增判断题
     *
     * @param question
     * @return
     */
    @RequestMapping(value = "/tfQuestion/insert", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean saveTfQuestion(TfQuestion question) {
        return teacher2QuestionService.insertTfQuestion(question) > 0;
    }

    /**
     * 新增附加题
     *
     * @param another
     * @return
     */
    @RequestMapping(value = "/another/insert", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean saveAnother(@RequestBody Another another) {

        return teacher2QuestionService.insertAnother(another) > 0;
    }


    /**
     * 按条件查询判断题
     *
     * @param params   分页信息
     * @param courseId 课程号
     * @param section  章节信息
     * @return
     */
    @RequestMapping(value = "/tf/loadTf/{courseId}/{section}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectTf(
            @RequestBody Map<String, Object> params,
            @PathVariable(value = "courseId") String courseId,
            @PathVariable(value = "section") String section) {
        Map<String, Object> selectOption = new HashMap<>();
        if ("0".equals(courseId)) {
            selectOption.put("courseId", null);
        } else {
            selectOption.put("courseId", courseId);

        }
        if ("0".equals(section)) {
            selectOption.put("section", null);
        } else {
            selectOption.put("section", Arrays.asList(section.split(",")));
        }
        List<TfQuestion> tfQuestionList = teacher2QuestionService.selectTfInfo(CommonKit.getMapInfo2Page(params), selectOption);
        if (null != tfQuestionList && tfQuestionList.size() != 0) {
            return CommonKit.getTakenInfo(tfQuestionList);
        }
        return null;
    }


    /**
     * 按条件查询选择题
     *
     * @param params   分页信息
     * @param courseId 课程号
     * @param section  章节信息
     * @return
     */
    @RequestMapping(value = "/single/loadSingle/{courseId}/{section}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectSingle(
            @RequestBody Map<String, Object> params,
            @PathVariable(value = "courseId") String courseId,
            @PathVariable(value = "section") String section) {
        Map<String, Object> selectOption = new HashMap<>();
        if ("0".equals(courseId)) {
            selectOption.put("courseId", null);
        } else {
            selectOption.put("courseId", courseId);

        }
        if ("0".equals(section)) {
            selectOption.put("section", null);
        } else {
            selectOption.put("section", Arrays.asList(section.split(",")));
        }
        List<SingleQuestion> singleQuestionList = teacher2QuestionService.selectSingleInfo(CommonKit.getMapInfo2Page(params), selectOption);
        if (null != singleQuestionList && singleQuestionList.size() != 0) {
            return CommonKit.getTakenInfo(singleQuestionList);
        }
        return null;
    }


    /**
     * 判断题的更新操作
     * @param tfQuestion 前台传入的判断题封装信息
     * @return
     */
    @RequestMapping(value = "/tf/update", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean updateTfInfo(@RequestBody TfQuestion tfQuestion) {

        return teacher2QuestionService.updateTfInfo(tfQuestion);
    }


    /**
     * 选择题的更新操作
     * @param singleQuestion 前台传入的判断题封装信息
     * @return
     */
    @RequestMapping(value = "/single/update", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean updateSingleInfo(@RequestBody SingleQuestion singleQuestion) {

        return teacher2QuestionService.updateSingleInfo(singleQuestion);
    }


//    判断题的删除操作
    @RequestMapping(value = "/tf/delete", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean deleteTfInfo(@RequestBody TfQuestion tfQuestion) {
        return teacher2QuestionService.deleteTfInfo(tfQuestion);
    }

    //    选择题的删除操作
    @RequestMapping(value = "/single/delete", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean deleteTfInfo(@RequestBody  SingleQuestion singleQuestion) {
        return teacher2QuestionService.deleteSingleInfo(singleQuestion);
    }
}
