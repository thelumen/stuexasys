package sunday.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sunday.common.enums.UpdateType;
import sunday.common.kit.ResourceKit;
import sunday.common.kit.ShiroKit;
import sunday.controller.common.CommonController;
import sunday.pojo.student.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/student")
public class StudentController extends CommonController {

    /**
     * 从Session中获取当前登录学生的信息
     *
     * @return 当前登录学生的信息
     */
    private StudentTaken getCurrentStudent() {
        return (StudentTaken) ShiroKit.getSession().getAttribute("currentStudent");
    }

    /**
     * 用于获取学生 int 类型的学号
     *
     * @return 当前登录学生的id（int）
     */
    private int getStudentIdWithInt() {
        return getCurrentStudent().getStudentId();
    }

    /**
     * 用于获取学生 Map 类型的学号
     *
     * @return 当前登录学生的id（Map）
     */
    private Map<String, Object> getStudentIdWithMap() {
        return new HashMap<String, Object>() {{
            put("studentId", getCurrentStudent().getStudentId());
        }};
    }

    /**
     * 用于获取学生 Map 类型的专业号
     *
     * @return 当前登录学生的专业Id(Map)
     */
    private Map<String, Object> getStudentSpecialtyIdWithMap() {
        return new HashMap<String, Object>() {{
            put("specialtyId", getCurrentStudent().getSpecialtyId());
        }};
    }

    /**
     * 转到学生主页
     *
     * @return 主页url
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:student")
    public String main() {
        return "/student/main/mainProxy";
    }

    /**
     * 显示学生主页
     *
     * @return 主页url
     */
    @RequestMapping(value = "/main", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:student")
    public String homepage() {
        return "/student/main/mainProxy";
    }

    /**
     * 转到学生 个人信息 页
     * 向 model 中添加学生的人信息 studentInfo,studentCourse,studentGrade
     *
     * @return 个人信息 url
     */
    @RequestMapping(value = "/personPage", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:student")
    public String personPage(Model model) {
        model.addAttribute("studentCourse", studentService.selectCourse(getStudentIdWithMap()));
        model.addAttribute("studentGrade", studentService.selectGrade(getStudentIdWithMap()));
        model.addAttribute("studentInfo", studentService.selectStudentInfo(null, getStudentIdWithMap()).get(0));
        return "/student/personPage/personPageProxy";
    }

    /**
     * 转到学生 测试 页
     * 向 model 中添加学生的人信息 studentInfo,studentExamInfo
     *
     * @return 测试 url
     */
    @RequestMapping(value = "/exam", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:student")
    public String exam(Model model) {
        model.addAttribute("studentExamInfo", studentService.selectExamInfo(getStudentSpecialtyIdWithMap()));
        return "/student/exam/examProxy";
    }

    /**
     * 转到学生 资源下载 页
     * 向 model 中添加学生的人信息 studentInfo
     *
     * @return 资源下载 url
     */
    @RequestMapping(value = "/resources/download", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:student")
    public String resourceDownload(Model model) {
        model.addAttribute("resourceInfo", ResourceKit.getResourceInfo());
        return "/student/resourcesDownload/resourcesDownloadProxy";
    }

    /**
     * 更新学生个人信息
     *
     * @return 成功信号
     */
    @RequestMapping(value = "/uploadInfo", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:student")
    @ResponseBody
    public Map<String, Object> updateStudentInfo(@RequestBody StudentInfo studentInfo) {
        Map<String, Object> msg = new HashMap<String, Object>() {{
            put("isSuccess", false);
        }};
        studentInfo.setStudentId(getStudentIdWithInt());
        studentInfo.setUpdateType(UpdateType.StuSet);
        if (studentService.update(studentInfo)) {
            msg.put("isSuccess", true);
        }
        return msg;
    }

    /**
     * 返回 测试题 试卷开始路径
     *
     * @param examInfo .
     * @return 测试页面
     */
    @RequestMapping(value = "/test/ready", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> readyTest(@RequestBody ExamInfo examInfo) {
        Map<String, Object> data = new HashMap<>();
        if (!"4".equals(examInfo.getTestNum())) {
            data.put("generalTest", true);
            data.put("examInfo", examInfo.getCourseId() + "_" + examInfo.getContent() + "_" + examInfo.getTestNum() + "_" + examInfo.getCourseName());
        } else {
            data.put("generalTest", false);
            data.put("examInfo", examInfo.getCourseId() + "_" + examInfo.getCourseName());
        }
        return data;
    }

    /**
     * 返回 普通测试 试题页面
     *
     * @return url
     */
    @RequestMapping(value = "/test/start/{examInfo}", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:student")
    public String startTest(Model model, @PathVariable(value = "examInfo") String examInfoInPath) throws IOException {
        String[] s = examInfoInPath.split("_");
        String s3 = new String(s[3].getBytes("iso8859-1"), "utf-8");
        ExamInfo examInfo = new ExamInfo();
        examInfo.setCourseId(Integer.valueOf(s[0]));
        examInfo.setContent(s[1]);
        examInfo.setTestNum(s[2]);
        examInfo.setCourseName(s3);
        TestPaper testPaper = studentService.selectQuestion(examInfo);
        ResourceKit.backUpExamTaken(testPaper, s3, getCurrentStudent().getSpecialtyName(), getStudentIdWithInt());
        model.addAttribute("testPaper", testPaper);
        return "/student/exam/testProxy";
    }

    /**
     * 返回 附加题 测试页面
     *
     * @return String
     */
    @RequestMapping(value = "/test/startAnother/{examInfo}", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:student")
    public String startTestAnother(Model model, @PathVariable(value = "examInfo") String examInfoInPath) throws IOException {
        String[] s = examInfoInPath.split("_");
        ExamInfo examInfo = new ExamInfo();
        examInfo.setCourseId(Integer.valueOf(s[0]));
        examInfo.setCourseName(s[1]);
        examInfo.setTestNum("4");
        TestPaper testPaper = studentService.selectTestPaperAnother(getStudentIdWithInt(), examInfo);
        ResourceKit.backUpExamTaken(testPaper, s[1], getCurrentStudent().getSpecialtyName(), getStudentIdWithInt());
        model.addAttribute("testPaper", testPaper);
        return "/student/exam/testAnotherProxy";
    }

    /**
     * 上传学生测试成绩或者答案
     *
     * @param gradeInfo .
     * @return Map
     */
    @RequestMapping(value = "/uploadGrade", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:student")
    @ResponseBody
    public Map uploadGrade(@RequestBody GradeInfo gradeInfo) {
        Map<String, Object> info = new HashMap<>();
        Map<String, Object> params = getStudentSpecialtyIdWithMap();
        params.put("courseId", gradeInfo.getCourseId());
        List<ExamInfo> examInfos = studentService.selectExamInfo(params);
        if (examInfos.get(0).getTest() == 0) {
            info.put("overtime", true);
            info.put("issuccess", false);
            return info;
        }
        gradeInfo.setStudentId(getStudentIdWithInt());
        if (Integer.valueOf(gradeInfo.getTestNum()) != 4) {
            String[] an = gradeInfo.getAnswer();
            String[] result = gradeInfo.getResult().split(",");
            int testRight = 0;  //测试题总正确数
            int single = 0;     //选择题总正确数
            int tf = 0;         //判断题总正确数
            for (int i = 1; i < 26; i++) {
                int count = i - 1;
                if (i <= 20) {
                    String realAnS = "j";
                    if (Integer.valueOf(an[i]) % 5 == 0) {
                        realAnS = "A";
                    } else if (Integer.valueOf(an[i]) % 5 == 1) {
                        realAnS = "B";
                    } else if (Integer.valueOf(an[i]) % 5 == 2) {
                        realAnS = "C";
                    } else if (Integer.valueOf(an[i]) % 5 == 3) {
                        realAnS = "D";
                    }
                    if (realAnS.equals(result[count])) {
                        testRight++;
                        single++;
                    }
                } else {
                    String realAnT = "j";
                    if (Integer.valueOf(an[i]) % 3 == 1) {
                        realAnT = "0";
                    } else if (Integer.valueOf(an[i]) % 3 == 2) {
                        realAnT = "1";
                    }
                    if (realAnT.equals(result[count])) {
                        testRight++;
                        tf++;
                    }
                }
            }
            int totalGrade = testRight * 4;
            gradeInfo.setGrade(totalGrade);
            info.put("grade", totalGrade);
            info.put("single", single);
            info.put("tf", tf);
        }
        ResourceKit.backUpExamInfo(gradeInfo, getCurrentStudent().getSpecialtyName());//备份
        if (studentService.insertGrade(gradeInfo)) {
            info.put("issuccess", true);
        } else {
            info.put("issuccess", false);
        }
        return info;
    }

    /**
     * 文件下载
     *
     * @param path     路径
     * @param response 返回数据流
     * @throws IOException 异常
     */
    @RequestMapping(value = "/resources/download/{fileDownloadPath}", method = RequestMethod.GET)
    public void download(@PathVariable(value = "fileDownloadPath") String path,
                         HttpServletResponse response) throws IOException {
        //分解索引号
        String[] fileNum = path.split(",");
        //获取文件信息
        Map<String, Object> fileInfo = ResourceKit.selectWithFileNum(Integer.valueOf(fileNum[0]), Integer.valueOf(fileNum[1]));
        //获取绝对路径
        String realPath = (String) fileInfo.get("realPath");
        String fileName = (String) fileInfo.get("fileName");

        ResourceKit.download(response, realPath, fileName);
    }
}