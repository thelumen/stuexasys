package yang.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import yang.common.base.ResultBean;
import yang.common.kit.CommonKit;
import yang.common.kit.StringKit;
import yang.controller.common.CommonController;
import yang.domain.common.Another;
import yang.domain.common.Course;
import yang.domain.common.SingleQuestion;
import yang.domain.common.TfQuestion;
import yang.domain.teacher.AnotherTaken;

import java.util.ArrayList;
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

    ///**
    // * 获取某一课程选择题的章节
    // *
    // * @param courseId
    // * @return
    // */
    //@RequestMapping(value = "/{courseId}/chapter", method = RequestMethod.GET)
    //@ResponseBody
    //public List<Map<String, Object>> getCourseChapter(@PathVariable("courseId") Integer courseId) {
    //    //如果courseId为null，则会查询出所有的信息
    //    if (null == courseId) {
    //        return null;
    //    }
    //    Map<String, Object> params = new HashMap<String, Object>() {{
    //        put("courseId", courseId);
    //    }};
    //    List<Course> courses = courseService.select(params);
    //    if (null != courses) {
    //        int chapterNum = courses.get(0).getChapterNum();
    //        String[] target = ChapterKit.getLimitedChapters(chapterNum);
    //
    //        return ChapterKit.getChapterInSelect(target);
    //    }
    //    return null;
    //}

    /**
     * 转到题目编辑界面
     *
     * @return .
     */
    @RequestMapping(value = "/editQuestion", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
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
     * 更新附加题
     *
     * @return
     */
    @RequestMapping(value = "/questionSave", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean saveQuestion(@RequestBody AnotherTaken anotherTaken) {
        return questionService.saveQuestion(anotherTaken);
    }

    /**
     * 删除附加题题目
     *
     * @return .
     */
    @RequestMapping(value = "/questionDel", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean delQuestion(@RequestBody AnotherTaken anotherTaken) {
        return questionService.delQuestion(new HashMap<String, Object>() {{
            put("id", anotherTaken.getId());
        }});
    }

    /**
     * 转到判断题目查看页
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
    @RequestMapping(value = "/tf/loadTf/{courseId}/{section}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectTf(@RequestBody Map<String, Object> params,
                                        @PathVariable(value = "courseId") String courseId, @PathVariable(value = "section") String section) {
        if ("null".equals(courseId) || "null".equals(section)) {
            return CommonKit.getTakenInfo(null);
        }
        Map<String, Object> selectOption = new HashMap<String, Object>() {{
            put("courseId", courseId);
            put("section", CommonKit.string2Chinese(section));
        }};
        List<TfQuestion> tfQuestionList = teacher2QuestionService.selectTfInfo(CommonKit.getOrginMapInfo2Page(params), selectOption);
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
    public boolean updateTfInfo(@RequestBody TfQuestion tfQuestion) {
        return teacher2QuestionService.updateTfInfo(tfQuestion);
    }


    //    判断题的删除操作
    @RequestMapping(value = "/tf/delete", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean deleteTfInfo(@RequestBody TfQuestion tfQuestion) {
        return teacher2QuestionService.deleteTfInfo(tfQuestion);
    }

    //    选择题的删除操作
    @RequestMapping(value = "/single/delete", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean deleteTfInfo(@RequestBody SingleQuestion singleQuestion) {
        return teacher2QuestionService.deleteSingleInfo(singleQuestion);
    }
}
