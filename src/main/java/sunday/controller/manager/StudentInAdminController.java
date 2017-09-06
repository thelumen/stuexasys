package sunday.controller.manager;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sunday.common.enums.DeleteType;
import sunday.common.enums.MessageInfo;
import sunday.common.enums.UpdateType;
import sunday.common.kit.CommonKit;
import sunday.common.kit.EncryptKit;
import sunday.controller.common.CommonController;
import sunday.pojo.student.StudentInfo;
import sunday.pojo.student.StudentTaken;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;

/**
 * Created by yang on 2017/8/29.
 * At 7:34
 */
@Controller
@RequestMapping("/admin/student")
public class StudentInAdminController extends CommonController {

    /**
     * 返回学生编辑页面
     *
     * @return .
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:manager")
    public String EditStudent() {
        return "/manager/student/studentProxy";
    }

    /**
     * 初始化学生信息表
     *
     * @param params       分页参数.
     * @param selectOption 预留显示.
     * @return 格式化的信息.
     */
    @RequestMapping(value = "/initStudentTable/{selectOption}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> initStudentTable(@RequestBody Map<String, Object> params,
                                                @PathVariable(value = "selectOption") Integer selectOption) {
        Map<String, Object> selectOptionMap = new HashMap<>();
        if (selectOption == 1) {
            selectOptionMap.put("specialtyId", new ArrayList<String>() {{
                add("100000");
            }});
        }
        List<StudentTaken> studentTakenList = studentService.selectStudentInfo(CommonKit.getMapInfo2Page(params), selectOptionMap);
        if (null != studentTakenList && studentTakenList.size() != 0) {
            return CommonKit.getTakenInfo(studentTakenList);
        }
        return null;
    }

    /**
     * 保存学生信息的修改
     *
     * @param studentInfo .
     * @return .
     */
    @RequestMapping(value = "/studentInfoSave", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:manager")
    @ResponseBody
    public boolean saveStudentInfo(@RequestBody StudentInfo studentInfo) {
        studentInfo.setUpdateType(UpdateType.AdminSet);
        return studentService.update(studentInfo);
    }

    /**
     * 删除学生
     *
     * @param studentInfo .
     * @return .
     */
    @RequestMapping(value = "/studentInfoDel", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public boolean deleteStudent(@RequestBody StudentInfo studentInfo) {
        return studentService.delete(new HashMap<String, Object>() {{
            put("deleteType", DeleteType.DeleteWithStudentId);
            put("studentId", studentInfo.getStudentId());
        }});
    }

    /**
     * 删除专业
     *
     * @param specialtyId .
     * @return .
     */
    @RequestMapping(value = "/specialtyDel/{specialtyId}", method = RequestMethod.POST)
    @ResponseBody
    public boolean deleteStudentWithSpecialty(@PathVariable(value = "specialtyId") String specialtyId) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("deleteType", DeleteType.DeleteWithSpecialtyId);
            put("specialtyId", Arrays.asList(specialtyId.split(",")));
        }};
        boolean successDelStudent = studentService.delete(params);
        boolean successDelSpecialty = adminStudentService.deleteSpecialty(params);
        return (successDelSpecialty && successDelStudent);
    }

    /**
     * 加载专业信息
     *
     * @return .
     */
    @RequestMapping(value = "/specialtyGet", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> loadSpecialty() {
        return adminStudentService.selectSpecialty();
    }

    /**
     * 查找学生信息
     *
     * @param params      分页信息.
     * @param specialtyId 专业信息.
     * @param studentId   学号.
     * @return .
     */
    @RequestMapping(value = "/loadStudent/{specialtyId}/{studentId}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectStudent(
            @RequestBody Map<String, Object> params,
            @PathVariable(value = "specialtyId") String specialtyId,
            @PathVariable(value = "studentId") String studentId) {
        Map<String, Object> selectOption = new HashMap<>();
        if ("0".equals(specialtyId)) {
            selectOption.put("specialtyId", null);
        } else {
            selectOption.put("specialtyId", Arrays.asList(specialtyId.split(",")));
        }
        if ("0".equals(studentId)) {
            selectOption.put("studentId", null);
        } else {
            selectOption.put("studentId", studentId);
        }
        return CommonKit.getTakenInfo(studentService.selectStudentInfo(CommonKit.getMapInfo2Page(params), selectOption));
    }


    /**
     * 上传学生表处理
     *
     * @param files Excel( xls类型 )
     * @return .
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public int uploadStudentHandle(@RequestParam("files") MultipartFile files) {
        if (null != files) {
            try {
                //files.transferTo(new File(ResourceFileKit.getHome() + File.separator + files.getOriginalFilename()));
                InputStream input = files.getInputStream();//IOException
                jxl.Workbook workbook = Workbook.getWorkbook(input);//BiffException
                Sheet sheet_0 = workbook.getSheet(0);//获取第一章工作表
                Map<String, Object> uploadStudentInfo = new HashMap<String, Object>() {{
                    put("specialtyId", Integer.valueOf(sheet_0.getCell(3, 0).getContents()));
                    put("specialtyName", sheet_0.getCell(1, 0).getContents());
                }};
                List<StudentTaken> studentUploadList = new ArrayList<>();
                for (int j = 2; j < sheet_0.getRows(); j++) {
                    StudentTaken studentTaken = new StudentTaken();
                    studentTaken.setStudentId(Integer.valueOf(sheet_0.getCell(0, j).getContents()));
                    studentTaken.setName(sheet_0.getCell(1, j).getContents());
                    studentTaken.setGender(sheet_0.getCell(2, j).getContents());
                    String initPassword = sheet_0.getCell(3, j).getContents();//如果未设置初始密码则使用学号替代
                    if (!"".equals(initPassword)) {
                        studentTaken.setPassword(EncryptKit.md5(initPassword));
                    } else {
                        studentTaken.setPassword(EncryptKit.md5(sheet_0.getCell(0, j).getContents()));
                    }
                    studentUploadList.add(studentTaken);
                }
                uploadStudentInfo.put("studentUploadList", studentUploadList);
                return adminStudentService.uploadStudentHandle(uploadStudentInfo).getMessageId();
            } catch (IOException | BiffException e) {
                e.printStackTrace();
                return MessageInfo.OperationFailed.getMessageId();
            }
        }
        return MessageInfo.OperationFailed.getMessageId();
    }
}
