package sunday.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import sunday.common.kit.ChapterKit;
import sunday.common.kit.CommonKit;
import sunday.common.kit.TeacherKit;
import sunday.controller.common.CommonController;
import sunday.pojo.school.Another;
import sunday.pojo.school.Course;
import sunday.pojo.school.SingleQuestion;
import sunday.pojo.school.TfQuestion;
import sunday.pojo.teacher.AnotherTaken;

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
     * 转到题目编辑界面
     *
     * @return .
     */
    @RequestMapping(value = "/editQuestion", method = RequestMethod.GET)
    public String editQuestion() {
        return "/teacher/editQuestion/editQuestionProxy";
    }

    /**
     * 获取课程列表
     *
     * @return .
     */
    @RequestMapping(value = "/courseGet", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getCourse() {
        List<Course> courses = specialty2CourseService.selectAllCourses();
        if (null != courses) {
            List<Map<String, Object>> father = new ArrayList<>();
            for (Course course : courses) {
                Map<String, Object> child = new HashMap<String, Object>() {{
                    put("id", course.getCourseId());
                    put("text", course.getName());
                }};
                father.add(child);
            }
            return father;
        }
        return null;
    }

    /**
     * 根据课程查询简答题
     *
     * @return .
     */
    @RequestMapping(value = "/questionLoad/{courseId}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectWithCourse(@PathVariable(value = "courseId") String courseId) {
        return CommonKit.getTakenInfo(questionService.selectAnotherQuestion(new HashMap<String, Object>() {{
            put("courseId", courseId);
        }}));
    }

    /**
     * 保存题目更改
     *
     * @return .
     */
    @RequestMapping(value = "/questionSave", method = RequestMethod.POST)
    @ResponseBody
    public boolean saveQuestion(@RequestBody AnotherTaken anotherTaken) {
        return questionService.saveQuestion(anotherTaken);
    }

    /**
     * 删除题目
     *
     * @return .
     */
    @RequestMapping(value = "/questionDel", method = RequestMethod.POST)
    @ResponseBody
    public boolean delQuestion(@RequestBody AnotherTaken anotherTaken) {
        return questionService.delQuestion(new HashMap<String, Object>() {{
            put("id", anotherTaken.getId());
        }});
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

            return TeacherKit.getSelectInfo(target);
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
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean saveTfQuestion(@RequestBody TfQuestion question) {

        return teacher2QuestionService.insertTfQuestion(question) > 0;
    }

    /**
     * 新增判断题
     *
     * @param another
     * @return
     */
    @RequestMapping(value = "/another/insert", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean saveAnother(@RequestBody Another another) {

        return teacher2QuestionService.insertAnother(another) > 0;
    }

}
