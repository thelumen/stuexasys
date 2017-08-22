package sunday.controller;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sunday.common.kit.*;
import sunday.controller.common.CommonController;
import sunday.pojo.dto.GradePercent;
import sunday.pojo.school.*;
import sunday.pojo.teacher.*;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * Created by yang on 2017/5/25.
 * At 10:09
 */
@Controller
@RequestMapping("/teacher")
public class TeacherController extends CommonController {

    /**
     * 获取当前登录教师id
     *
     * @return
     */
    private Integer getCurrentTeacherId() {
        return ((Teacher) ShiroKit.getSession().getAttribute("currentTeacher")).getTeacherId();
    }

    /**
     * 修改教师信息
     *
     * @param teacher
     * @return
     */
    @RequestMapping(value = "/updateInfo", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> updateInfo(@RequestBody Teacher teacher) {
        Map<String, Object> info = new HashMap<>();

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", teacher.getTeacherId());
        }};
        List<Teacher> teachers = teacherService.select(null, params);
        if (null != teachers) {
            Teacher t = teachers.get(0);
            //后台接收的密码是加密了的
            if (!teacher.getPassword().equals(t.getPassword())) {
                String password = teacher.getPassword();
                teacher.setPassword(EncryptKit.md5(password));
            } else {
                teacher.setPassword(null);
            }
            if (teacherService.update(teacher)) {
                info.put("isSuccess", true);
            } else {
                info.put("isSuccess", false);
            }
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 转到教师主页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String main() {
        return "/teacher/main/mainProxy";
    }

    /**
     * 转到附加题评分页
     *
     * @return
     */
    @RequestMapping(value = "/another", method = RequestMethod.GET)
    @RequiresAuthentication
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
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("courseId", courseId);
            put("specialtyId", specialtyId);
        }};
        List<AnotherTaken> takens = teaQueService.selectAnother(params);
        if (null != takens) {
            return takens;
        }
        return null;
    }

    /**
     * 查询单个学生附加题答题情况
     *
     * @param content
     * @return
     */
    @RequestMapping(value = "/student/another/{content}", method = RequestMethod.POST)
    @ResponseBody
    public AnotherTaken getStudentResult(@PathVariable("content") String content) {
        String[] ele = content.split("&");
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("id", Long.valueOf(ele[0]));
            put("courseId", ele[1]);
            put("studentId", ele[2]);
        }};
        List<AnotherTaken> takens = teaQueService.selectAnother(params);
        if (null != takens) {
            return takens.get(0);
        }
        return null;
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
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> recordGrade4(@PathVariable("studentId") Integer studentId,
                                            @PathVariable("courseId") Integer courseId,
                                            @PathVariable("score") int score) {
        Map<String, Object> info = new HashMap<>();
        //前台不做了，后台修改数据
        if (score > 100) {
            score = 100;
        }
        if (stuGraService.updateAnother(studentId, courseId, score)) {
            info.put("isSuccess", true);
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 转到题目录入页
     *
     * @return
     */
    @RequestMapping(value = "/question", method = RequestMethod.GET)
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
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("courseId", courseId);
        }};
        List<SingleQuestion> questions = teaQueService.selectSingleQuestion(params);
        if (null != questions) {
            //按章节排序
            List<String> target = ChapterKit.bubbleSort(questions);
            List<Map<String, Object>> father = new ArrayList<>();
            for (String chapterName : target) {
                Map<String, Object> child = new HashMap<String, Object>() {{
                    put("id", chapterName);
                    put("text", chapterName);
                }};
                father.add(child);
            }
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
    @RequestMapping(value = "/saveSingleQuestion", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> saveSingleQuestion(@RequestBody SingleQuestion question) {
        Map<String, Object> info = new HashMap<>();
        if (teaQueService.insertSingleQuestion(question) > 0) {
            info.put("isSuccess", true);
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 新增判断题
     *
     * @param question
     * @return
     */
    @RequestMapping(value = "/saveTfQuestion", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> saveTfQuestion(@RequestBody TfQuestion question) {
        Map<String, Object> info = new HashMap<>();
        if (teaQueService.insertTfQuestion(question) > 0) {
            info.put("isSuccess", true);
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 新增判断题
     *
     * @param another
     * @return
     */
    @RequestMapping(value = "/saveAnother", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> saveAnother(@RequestBody Another another) {
        Map<String, Object> info = new HashMap<>();
        if (teaQueService.insertAnother(another) > 0) {
            info.put("isSuccess", true);
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 转到资源上传页
     *
     * @return
     */
    @RequestMapping(value = "/resource", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String resourcePage() {
        return "/teacher/resource/resourceProxy";
    }

    /**
     * 获取学科目录文件名select
     *
     * @return
     */
    @RequestMapping(value = "/directory", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getDirectories() {
        List<String> directories = ResourceFileKit.getHomeDirectories();
        if (null != directories) {
            List<Map<String, Object>> target = new ArrayList<>();
            for (String directoryFileName : directories) {
                Map<String, Object> child = new HashMap<String, Object>() {{
                    put("id", directoryFileName);
                    put("text", directoryFileName);
                }};
                target.add(child);
            }
            return target;
        }
        return null;
    }

    /**
     * 上传文件
     *
     * @param directoryName HOME文件下某一文件夹名
     * @param files         上传的文件
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/{directoryName}/upload", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> uploadFiles(@PathVariable("directoryName") String directoryName,
                                           @RequestParam("files") List<MultipartFile> files) throws IOException {
        Map<String, Object> info = new HashMap<>();
        String directory = new String(directoryName.getBytes("iso8859-1"), "utf-8");
        //HOME主目录下的某一directory
        String realPath = ResourceFileKit.getHome() + "/" + directory;
        File child = new File(realPath);
        if (!child.exists()) {
            child.mkdir();
        }
        if (null != files && files.size() > 0) {
            for (MultipartFile file : files) {
                file.transferTo(new File(realPath + "/" + file.getOriginalFilename()));
            }
            info.put("isSuccess", true);
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 返回某一文件目录类所有普通文件信息
     *
     * @param directoryName
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/{directoryName}/files", method = RequestMethod.POST)
    @ResponseBody
    public List<Map<String, Object>> getFiles(@PathVariable("directoryName") String directoryName) throws UnsupportedEncodingException {
        String directory = new String(directoryName.getBytes("iso8859-1"), "utf-8");
        String deepPath = ResourceFileKit.getHome() + "/" + directory;
        File home = new File(deepPath);
        if (home.exists()) {
            if (home.isDirectory()) {
                File[] children = home.listFiles();
                if (null != children && children.length > 0) {
                    List<Map<String, Object>> father = new ArrayList<>();
                    for (File file : children) {
                        if (file.isFile()) {
                            Map<String, Object> child = new HashMap<String, Object>() {{
                                put("name", file.getName());
                                put("path", ResourceFileKit.getRelativePath(directory, file.getPath()));
                            }};
                            father.add(child);
                        }
                    }
                    return father;
                }
            }
        }
        return null;
    }

    /**
     * 转到考试信息页
     *
     * @return
     */
    @RequestMapping(value = "/exam", method = RequestMethod.GET)
    @RequiresAuthentication
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
    @RequestMapping(value = "/takeExamInfo/{courseId}/{specialtyId}", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> takeExamInfo(@PathVariable("courseId") Integer courseId,
                                            @PathVariable("specialtyId") Integer specialtyId) {
        Map<String, Object> info = new HashMap<>();

        Map<String, Object> specouInfo = new HashMap<String, Object>() {{
            put("courseId", courseId);
            put("specialtyId", specialtyId);
        }};
        List<ExamTaken> examTakens = stuExaService.selectExamTaken(null, specouInfo);
        if (null != examTakens) {
            info.put("isSuccess", false);
            return info;
        }

        ExamTaken exam = new ExamTaken();
        exam.setCourseId(courseId);
        exam.setSpecialtyId(specialtyId);
        exam.setStarted(1);

        stuExaService.insertExamInfo(exam);

        info.put("isSuccess", true);
        return info;
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
            put("teacherId", getCurrentTeacherId());
        }};
        List<ExamTaken> examTakens = stuExaService.selectExamTaken(CommonKit.getMapInfo2Page(params), teacherInfo);
        if (null != examTakens) {
            return CommonKit.getTakenInfo(examTakens);
        }
        return null;
    }

    /**
     * **
     * 获取modal中table的考试信息
     *
     * @return
     */
    @RequestMapping(value = "/getModalTableExamInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getTableExamInfo() {
        List<ExamTaken> examTakens = stuExaService.selectTableExamInfo();
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
    @RequestMapping(value = "/updateExamInfo", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> getChapter(@RequestBody ExamTaken examInfo) throws UnsupportedEncodingException {
        Map<String, Object> info = new HashMap<>();
        //sign信号只有一个为1才能被保存
        int[] signs = {examInfo.getSign1(), examInfo.getSign2(), examInfo.getSign3(), examInfo.getSign4()};
        int i = 0;
        for (Integer b : signs) {
            if (b == 1) {
                i++;
            }
        }
        if (i == 1) {
            stuExaService.updateExamInfo(examInfo);
            info.put("isSuccess", true);
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 删除考试信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/examInfo/delete/{id}", method = RequestMethod.DELETE)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> deleteExamInfo(@PathVariable("id") String id) {
        Map<String, Object> info = new HashMap<>();
        if (stuExaService.deleteExamInfo(id)) {
            info.put("isSuccess", true);
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 开启考试
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/examStart/{id}", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> examStart(@PathVariable("id") String id) {
        Map<String, Object> info = new HashMap<>();
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("id", id);
            put("test", 1);
        }};
        if (stuExaService.startOrCloseExam(params)) {
            info.put("isSuccess", true);
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 关闭考试
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/examClose/{id}", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> examClose(@PathVariable("id") String id) {
        Map<String, Object> info = new HashMap<>();
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("id", id);
            put("test", 0);
        }};
        if (stuExaService.startOrCloseExam(params)) {
            info.put("isSuccess", true);
        } else {
            info.put("isSuccess", false);
        }
        return info;
    }

    /**
     * 转到成绩统计页面
     *
     * @return
     */
    @RequestMapping(value = "/student/grade", method = RequestMethod.GET)
    @RequiresAuthentication
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
    @RequestMapping(value = "/student/assignGrades", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String assignGrades(GradePercent percentInfo) {
        float p1 = 0.0f, p2 = 0.0f, p3 = 0.0f, p4 = 0.0f;
        if (!percentInfo.getPercent1().equals("")) {
            p1 = Float.parseFloat(percentInfo.getPercent1()) / 100.0f;
        }
        if (!percentInfo.getPercent2().equals("")) {
            p2 = Float.parseFloat(percentInfo.getPercent2()) / 100.0f;
        }
        if (!percentInfo.getPercent3().equals("")) {
            p3 = Float.parseFloat(percentInfo.getPercent3()) / 100.0f;
        }
        if (!percentInfo.getPercent4().equals("")) {
            p4 = Float.parseFloat(percentInfo.getPercent4()) / 100.0f;
        }

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("specialtyId", percentInfo.getSpecialtyId());
            put("courseId", percentInfo.getCourseId());
        }};
        List<GradeTaken> studentGrades = stuGraService.selectGradeTaken(null, params);
        for (GradeTaken studentGrade : studentGrades) {
            float total;
            total = studentGrade.getGrade1() * p1 + studentGrade.getGrade2() * p2 + studentGrade.getGrade3() * p3 + studentGrade.getGrade4() * p4;
            //采用四舍五入方式计算总成绩
            studentGrade.setTotal(Math.round(total));

            stuGraService.updateGrade(studentGrade);
        }

        return "/teacher/grade/gradeProxy";
    }

    /**
     * 获取指定专业学生的成绩
     *
     * @param specialtyId
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/grade/{specialtyId}/{courseId}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getGradeBySpecialtyId(@PathVariable("specialtyId") Integer specialtyId,
                                                     @PathVariable("courseId") Integer courseId) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("specialtyId", specialtyId);
            put("courseId", courseId);
        }};
        List<GradeTaken> gradeTakens = stuGraService.selectGradeTaken(null, params);
        return CommonKit.getTakenInfo(gradeTakens);
    }

    /**
     * 获取所教专业所有学生的成绩信息
     *
     * @return
     */
    @RequestMapping(value = "/student/grade/all", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getAllStudentGrade(@RequestBody Map<String, Object> params) {
        //封装list
        List<GradeTaken> target = new ArrayList<>();

        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
        }};
        List<CourseTaken> courseTakens = speCouService.selectCourseTaken(CommonKit.getMapInfo2Page(params), teacherInfo);
        if (null == courseTakens) {
            return null;
        }
        for (CourseTaken course : courseTakens) {
            teacherInfo.put("specialtyName", course.getSpecialtyName());
            teacherInfo.put("courseId", course.getCourseId());
            List<GradeTaken> gradeTakens = stuGraService.selectGradeTaken(null, teacherInfo);
            //本可不用，但是没有学生-专业表数据导致出现java.lang.NullPointerException
            if (null == gradeTakens) {
                continue;
            }
            target.addAll(gradeTakens);
        }

        return CommonKit.getTakenInfo(target);
    }

    /**
     * 转到选课页
     *
     * @return
     */
    @RequestMapping(value = "/cource", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String coursePage() {
        return "/teacher/course/courseProxy";
    }

    /**
     * 选课
     *
     * @param courseTaken
     * @return
     */
    @RequestMapping(value = "/takeCourse", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> takeCourse(@RequestBody CourseTaken courseTaken) {
        Map<String, Object> info = new HashMap<>();
        courseTaken.setTeacherId(getCurrentTeacherId());
        if (speCouService.insertCourseTaken(courseTaken) > 0) {
            info.put("isSuccess", true);
        }
        return info;
    }

    /**
     * 展示教师选课情况
     *
     * @param params
     * @return
     */
    @RequestMapping(value = "/tlcls", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getTakenInfo(@RequestBody Map<String, Object> params) {
        Map<String, Object> teacherInfo = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
        }};
        List<CourseTaken> courses = speCouService.selectCourseTaken(CommonKit.getMapInfo2Page(params), teacherInfo);

        //添加teacherId并且设置课程教学状态
        Date currentTime = new Date();
        for (CourseTaken info : courses) {
            if (info.getEndtime().compareTo(currentTime) >= 0 && currentTime.compareTo(info.getStarttime()) >= 0) {
                info.setOn("教学中");
            }
            if (currentTime.compareTo(info.getStarttime()) < 0) {
                info.setOn("未开始");
            }
            if (info.getEndtime().compareTo(currentTime) < 0) {
                info.setOn("已结课");
            }
        }

        return CommonKit.getTakenInfo(courses);
    }

    /**
     * 删除选课信息
     *
     * @param content
     * @return
     */
    @RequestMapping(value = "/course/delete/{content}", method = RequestMethod.DELETE)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Map<String, Object> editCourseTaken(@PathVariable("content") String content) throws UnsupportedEncodingException {
        Map<String, Object> info = new HashMap<>();
        //此数组有三个数值，teacherId+courseName+specialtyName
        //这种写法并不好
        String[] target = new String(content.getBytes("ISO8859-1"), "utf-8").split("&");

        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", target[0]);
            put("courseName", target[1]);
            put("specialtyName", target[2]);
        }};

        if (speCouService.deleteTakenInfo(params)) {
            info.put("isSuccess", true);
        }
        return info;
    }

    /**
     * 获取某一教师所教全部课程select
     *
     * @return
     */
    @RequestMapping(value = "/getCourse", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getCoursesFromTeacher() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
        }};
        return getCourses(params);
    }

    /**
     * 获取全部课程select
     *
     * @return
     */
    @RequestMapping(value = "/getCourses", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getAllCourses() {
        return getCourses(null);
    }

    /**
     * 自定义查询课程select
     *
     * @param params
     * @return
     */
    private List<Map<String, Object>> getCourses(Map<String, Object> params) {
        List<Course> courses;
        if (null != params) {
            courses = speCouService.selectCourse(params);
        } else {
            courses = speCouService.selectAllCourses();
        }
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
     * 获取某一教师所教的一门课的全部专业
     *
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/getSpecialties/{courseId}", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getSpecialtyByTeacherIdAndCourseId(@PathVariable("courseId") Integer courseId) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
            put("courseId", courseId);
        }};
        return getSpecialties(params);
    }

    /**
     * 获取某一教师所教全部专业select
     *
     * @return
     */
    @RequestMapping(value = "/getSpecialty", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getSpecialtiesFromTeacher() {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("teacherId", getCurrentTeacherId());
        }};
        return getSpecialties(params);
    }

    /**
     * 获取全部专业select
     *
     * @return
     */
    @RequestMapping(value = "/getSpecialties", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getAllSpecialties() {
        return getSpecialties(null);
    }

    /**
     * 自定义查询专业select
     *
     * @param params
     * @return
     */
    private List<Map<String, Object>> getSpecialties(Map<String, Object> params) {
        List<Specialty> specialties;
        if (null != params) {
            specialties = speCouService.selectSpecialty(params);
        } else {
            //查询全部专业
            specialties = speCouService.selectAllSpecialties();
        }
        if (null != specialties) {
            List<Map<String, Object>> father = new ArrayList<>();
            for (Specialty specialty : specialties) {
                Map<String, Object> child = new HashMap<String, Object>() {{
                    put("id", specialty.getSpecialtyId());
                    put("text", specialty.getName());
                }};
                father.add(child);
            }
            return father;
        }
        return null;
    }

}
