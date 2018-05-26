package yang.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yang.common.base.ResultBean;
import yang.common.kit.*;
import yang.controller.common.CommonController;
import yang.domain.common.Student;
import yang.domain.student.CourseTaken;
import yang.domain.student.ExamInfo;
import yang.domain.student.GradeInfo;
import yang.domain.student.TestPaper;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
        model.addAttribute("studentInfo", studentService.selectStudentInfo(null, StudentKit.getStudentIdWithMap()).get(0));
        return "/student/personPage/personPageProxy";
    }

    /**
     * 加载学生学年信息下拉菜单
     *
     * @return .
     */
    @RequestMapping(value = "/year", method = RequestMethod.GET)
    @ResponseBody
    public Object getStudentYear() {
        return StudentKit.makeStudentYear();
    }

    /**
     * 查询学生课程
     *
     * @param params 分页信息
     * @param year   查询年号
     * @return 对应的课程表
     */
    @RequestMapping(value = "/year/{type}/{year}", method = RequestMethod.POST)
    @ResponseBody
    public Object getStudentYearCourse(@RequestBody Map<String, Object> params,
                                       @PathVariable(value = "type") String type,
                                       @PathVariable(value = "year") int year) throws ParseException {
        CourseTaken courseTaken = new CourseTaken();
        //默认显示当前学期课程表
        if (0 == year) {
            year = StudentKit.judgeSection() - 1;//结束年号减一获取开始年号
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        courseTaken.setStudentId(StudentKit.getStudentIdWithInt());
        courseTaken.setStartTime(sdf.parse(String.valueOf(year) + "-08-01"));
        courseTaken.setEndTime(sdf.parse(String.valueOf(year + 1) + "-08-01"));
        switch (type) {
            case "course":
                return CommonKit.getTakenInfo(studentService.selectCourse(CommonKit.getMapInfo2Page(params), courseTaken));
            case "grade":
                return CommonKit.getTakenInfo(studentService.selectGrade(CommonKit.getMapInfo2Page(params), courseTaken));
            default:
                return null;
        }
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
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:student")
    @ResponseBody
    public Object updateStudentInfo(@RequestBody Student student) {
        student.setStudentId(StudentKit.getStudentIdWithInt());
        String oldPwd = student.getOldPassword().trim();
        String newPwd = student.getPassword().trim();
        if (StringKit.isBank(oldPwd) && StringKit.isNotBank(newPwd)) {
            return new ResultBean<>("请填写您现在的密码:)");
        }
        if (StringKit.isNotBank(oldPwd) && StringKit.isBank(newPwd)) {
            return new ResultBean<>("如果您不需要修改密码，请将“旧密码”一栏置空：)");
        }
        if (StringKit.isBank(oldPwd) && StringKit.isBank(newPwd)) {
            student.setPassword(null);
        }
        if (StringKit.isNotBank(oldPwd) && StringKit.isNotBank(newPwd)) {
            if (newPwd.length() < 3) {
                return new ResultBean<>("新密码至少3位！");
            }
            Map<String, Object> params = new HashMap<String, Object>() {{
                put("studentId", student.getStudentId());
            }};
            List<Student> students = studentService.select(null, params);
            if (null == students) {
                return new ResultBean<>("您的账号出现问题！请联系管理员..");
            }
            Student s = students.get(0);
            if (s.getPassword().equals(EncryptKit.md5(student.getOldPassword()))) {
                student.setPassword(EncryptKit.md5(newPwd));
            } else {
                return new ResultBean<>("原密码不正确！");
            }
        }

        return new ResultBean<>(studentService.updateStudent(student));
    }

    /**
     * 返回 测试题 试卷开始路径
     *
     * @param examInfo .
     * @return 测试页面
     */
    @RequestMapping(value = "/test/ready", method = RequestMethod.POST)
    @ResponseBody
    public Object readyTest(@RequestBody ExamInfo examInfo) {
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
        TestPaper testPaper = studentService.selectQuestion(examInfo, StudentKit.getStudentIdWithInt());
        if (null != testPaper) {
            ResourceKit.backUpExamTaken(testPaper, s[3], StudentKit.getCurrentStudent().getSpecialtyName(), StudentKit.getStudentIdWithInt());
        }
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
        if (null != testPaper) {
            ResourceKit.backUpExamTaken(testPaper, s[3], StudentKit.getCurrentStudent().getSpecialtyName(), StudentKit.getStudentIdWithInt());
        }
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
    public Object uploadGrade(@RequestBody GradeInfo gradeInfo) throws IOException, ClassNotFoundException {
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
        info.put("issuccess", studentService.insertGrade(gradeInfo, StudentKit.getCurrentStudent().getSpecialtyName()));
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