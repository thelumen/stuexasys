package yang.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yang.common.enums.UpdateType;
import yang.common.kit.FileKit;
import yang.common.kit.ResourceKit;
import yang.common.kit.StudentKit;
import yang.controller.common.CommonController;
import yang.domain.student.ExamInfo;
import yang.domain.student.GradeInfo;
import yang.domain.student.StudentInfo;
import yang.domain.student.TestPaper;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author jiangrijiu
 */
@Controller
@RequestMapping(value = "/student")
public class StudentController extends CommonController {

    /**
     * 转到学生主页
     *
     * @return 主页url
     */
    @RequestMapping(value = "/main")
    @RequiresPermissions(value = "shiro:sys:student")
    public String main() {
        return "/student/main/mainProxy";
    }

    /**
     * 转到学生 个人信息 页
     * 向 model 中添加学生的人信息 studentInfo,studentCourse,studentGrade
     *
     * @return 个人信息 url
     */
    @RequestMapping(value = "/info", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:student")
    public String personPage(Model model) {
        model.addAttribute("studentCourse", studentService.selectCourse(StudentKit.getStudentIdWithMap()));
        model.addAttribute("studentGrade", studentService.selectGrade(StudentKit.getStudentIdWithMap()));
        model.addAttribute("studentInfo", studentService.selectStudentInfo(null, StudentKit.getStudentIdWithMap()).get(0));
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
        model.addAttribute("studentExamInfo", studentService.selectExamInfo(StudentKit.getStudentSpecialtyIdWithMap()));
        return "/student/exam/examProxy";
    }

    /**
     * 转到学生 资源下载 页
     * 向 model 中添加学生的人信息 studentInfo
     *
     * @return 资源下载 url
     */
    @RequestMapping(value = "/resource", method = RequestMethod.GET)
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
        studentInfo.setStudentId(StudentKit.getStudentIdWithInt());
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
        ExamInfo examInfo = new ExamInfo();
        examInfo.setCourseId(Integer.valueOf(s[0]));
        examInfo.setContent(s[1]);
        examInfo.setTestNum(s[2]);
        examInfo.setCourseName(s[3]);
        TestPaper testPaper = studentService.selectQuestion(examInfo);
        ResourceKit.backUpExamTaken(testPaper, s[3], StudentKit.getCurrentStudent().getSpecialtyName(), StudentKit.getStudentIdWithInt());
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
        TestPaper testPaper = studentService.selectTestPaperAnother(StudentKit.getStudentIdWithInt(), examInfo);
        ResourceKit.backUpExamTaken(testPaper, s[1], StudentKit.getCurrentStudent().getSpecialtyName(), StudentKit.getStudentIdWithInt());
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
    public Map uploadGrade(@RequestBody GradeInfo gradeInfo) throws IOException, ClassNotFoundException {
        Map<String, Object> info = new HashMap<>();
        Map<String, Object> params = StudentKit.getStudentSpecialtyIdWithMap();
        params.put("courseId", gradeInfo.getCourseId());
        List<ExamInfo> examInfos = studentService.selectExamInfo(params);
        if (examInfos.get(0).getTest() == 0) {
            info.put("overtime", true);
            info.put("issuccess", false);
            return info;
        }
        gradeInfo.setStudentId(StudentKit.getStudentIdWithInt());
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
                        realAnT = "错误";
                    } else if (Integer.valueOf(an[i]) % 3 == 2) {
                        realAnT = "正确";
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
        ResourceKit.backUpExamInfo(gradeInfo, StudentKit.getCurrentStudent().getSpecialtyName());
        info.put("issuccess", studentService.insertGrade(gradeInfo));
        return info;
    }

    /**
     * 文件下载
     *
     * @param path
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/resource/{filePath}", method = RequestMethod.GET)
    public void download(@PathVariable(value = "filePath") String path,
                         HttpServletResponse response) throws IOException {
        String realPath = path.replace('_', '/');

        int index = realPath.lastIndexOf("/");
        String relativePath = realPath.substring(0, index);
        String fileNameWithoutExtension = realPath.substring(index + 1);

        List<File> files = FileKit.getFiles(relativePath);
        for (File f : files) {
            String fileName = f.getName();
            String realName = fileName.substring(0, fileName.lastIndexOf("."));
            if (realName.equals(fileNameWithoutExtension)) {
                ResourceKit.download(response, f.getPath(), f.getName());
                break;
            }
        }
    }
}