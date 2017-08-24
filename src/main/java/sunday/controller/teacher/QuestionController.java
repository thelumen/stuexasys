package sunday.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import sunday.common.kit.ChapterKit;
import sunday.common.kit.TeacherKit;
import sunday.controller.common.CommonController;
import sunday.pojo.school.Another;
import sunday.pojo.school.SingleQuestion;
import sunday.pojo.school.TfQuestion;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/24.
 * At 21:41
 */
@Controller
@RequestMapping("/question")
public class QuestionController extends CommonController{

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
        List<SingleQuestion> questions = teaQueService.selectSingleQuestion(params);
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

        return teaQueService.insertSingleQuestion(question) > 0;
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
    public boolean saveTfQuestion(@RequestBody TfQuestion question) {

        return teaQueService.insertTfQuestion(question) > 0;
    }

    /**
     * 新增判断题
     *
     * @param another
     * @return
     */
    @RequestMapping(value = "/another/insert", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean saveAnother(@RequestBody Another another) {

        return teaQueService.insertAnother(another) > 0;
    }


}
