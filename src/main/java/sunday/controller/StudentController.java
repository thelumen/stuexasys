package sunday.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sunday.common.enums.UpdateType;
import sunday.common.kit.ResourceFileKit;
import sunday.common.kit.ShiroKit;
import sunday.controller.common.CommonController;
import sunday.pojo.shiro.ShiroInfo;
import sunday.pojo.student.ExamInfo;
import sunday.pojo.student.GradeInfo;
import sunday.pojo.student.StudentInfo;
import sunday.pojo.student.TestPaper;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/student")
public class StudentController extends CommonController {

    /**
     * 从Session中获取当前登录学生的信息
     *
     * @return 当前登录学生的信息
     */
    private ShiroInfo getCurrentStudent() {
        return (ShiroInfo) ShiroKit.getSession().getAttribute("currentStudent");
    }

    /**
     * 用于获取学生 int 类型的学号
     *
     * @return 当前登录学生的id（int）
     */
    private int getStudentIdWithInt() {
        return getCurrentStudent().getUserId();
    }

    /**
     * 用于获取学生 Map 类型的学号
     *
     * @return 当前登录学生的id（Map）
     */
    private Map<String, Object> getStudentIdWithMap() {
        return new HashMap<String, Object>() {{
            put("studentId", getCurrentStudent().getUserId());
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
        model.addAttribute("studentCourse", studentService.selectCourse(null, getStudentIdWithMap()));
        model.addAttribute("studentGrade", studentService.selectGrade(null, getStudentIdWithMap()));
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
        model.addAttribute("studentExamInfo", studentService.selectExamInfo(null, getStudentIdWithMap()));
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
        model.addAttribute("resourceInfo", ResourceFileKit.getResourceInfo());
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
    public Map<String, Object> readyTest(@RequestBody ExamInfo examInfo, Model model) {
        Map<String, Object> data = new HashMap<>();
        if (!"4".equals(examInfo.getTestNum())) {
            data.put("generalTest", true);
            data.put("examInfo", examInfo.getCourseId() + "_" + examInfo.getContent() + "_" + examInfo.getTestNum());
        } else {
            data.put("generalTest", false);
            data.put("examInfo", examInfo.getCourseId());
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
    public String startTest(Model model, @PathVariable(value = "examInfo") String examInfoInPath) {
        String[] s = examInfoInPath.split("_");
        ExamInfo examInfo = new ExamInfo();
        examInfo.setCourseId(Integer.valueOf(s[0]));
        examInfo.setContent(s[1]);
        examInfo.setTestNum(s[2]);
        TestPaper testPaper = studentService.selectTestPaper(null, examInfo);
        model.addAttribute("exception", "后台数据异常");
        if (null != testPaper) {
            model.addAttribute("testPaper", testPaper);
            return "/student/exam/testProxy";
        } else return "/common/error/error";
    }

    /**
     * 返回 附加题 测试页面
     *
     * @return String
     */
    @RequestMapping(value = "/test/startAnother/{examInfo}", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:student")
    public String startTestAnother(Model model, @PathVariable(value = "examInfo") String examInfoInPath) {
        String[] s = examInfoInPath.split("_");
        ExamInfo examInfo = new ExamInfo();
        examInfo.setCourseId(Integer.valueOf(s[0]));
        model.addAttribute("testPaper", studentService.selectTestPaperAnother(null, getStudentIdWithInt(), examInfo));
        return "/student/exam/testAnotherProxy";
    }

    /**
     * 上传学生测试成绩或者答案
     *
     * @param gradeInfo .
     * @return Map
     */
    @RequestMapping(value = "/uploadGrade", method = RequestMethod.POST)
    @ResponseBody
    public Map uploadGrade(@RequestBody GradeInfo gradeInfo) {
        Map<String, Object> info = new HashMap<>();
        gradeInfo.setStudentId(getStudentIdWithInt());
        if (studentService.insertGrade(gradeInfo)) {
            info.put("issuccess", true);
        } else info.put("issuccess", false);
        return info;
    }

    @RequestMapping(value = "/resources/download/{fileDownloadPath}", method = RequestMethod.GET)
    public void download(@PathVariable(value = "fileDownloadPath") String path,
                         HttpServletResponse response) throws IOException {
        //分解索引号
        String[] fileNum = path.split(",");
        //获取文件信息
        Map<String, Object> fileInfo = ResourceFileKit.selectWithFileNum(Integer.valueOf(fileNum[0]), Integer.valueOf(fileNum[1]));
        //获取绝对路径
        String realPath = (String) fileInfo.get("realPath");
        //通过绝对路径获取 file
        File filePath = new File(realPath);
        //获取得文件名
        String fileName = (String) fileInfo.get("fileName");
        String fileDisplayName = URLEncoder.encode(fileName, "UTF-8");

        //初始化
        response.reset();
        response.setContentType("application/x-download");
        response.addHeader("Content-Disposition", "attachment; filename=\"" + fileDisplayName + "\"");
        ServletOutputStream outp = null;
        FileInputStream in = null;
        try {
            outp = response.getOutputStream();
            in = new FileInputStream(filePath);
            byte[] b = new byte[1024];
            int i;
            while ((i = in.read(b)) > 0) {
                outp.write(b, 0, i);
            }
            outp.flush();
        } catch (Exception e) {
            System.out.println("文件下载失败!");
            e.printStackTrace();
        } finally {
            if (in != null) {
                in.close();
            }
            if (outp != null) {
                outp.close();
            }
        }
    }
}