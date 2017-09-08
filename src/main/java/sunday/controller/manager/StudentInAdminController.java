package sunday.controller.manager;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
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
import sunday.pojo.school.Specialty;
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
    @RequestMapping(value = "/initTable/{selectOption}", method = RequestMethod.POST)
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
    @RequestMapping(value = "/infoSave", method = RequestMethod.POST)
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
    @RequestMapping(value = "/infoDel", method = RequestMethod.POST)
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
    @RequestMapping(value = "/specialty", method = RequestMethod.GET)
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
                InputStream input = files.getInputStream();//IOException
                Workbook workbook = Workbook.getWorkbook(input);//BiffException
                Sheet sheet_0 = workbook.getSheet(0);//获取第一章工作表

                int rows = sheet_0.getRows();//获取总行数
                if (!(Objects.equals(sheet_0.getCell(0, rows).getContents(), "") ||
                        Objects.equals(sheet_0.getCell(1, rows).getContents(), "") ||
                        Objects.equals(sheet_0.getCell(2, rows).getContents(), "") ||
                        Objects.equals(sheet_0.getCell(3, rows).getContents(), ""))
                        ) {
                    Set<String> specialtySet = new HashSet<>();
                    List<Specialty> specialtyList = new ArrayList<>();
                    List<StudentTaken> studentUploadList = new ArrayList<>();

                    for (int k = 1; k < rows; k++) {
                        //专业处理
                        int specialtyNumInSet = specialtySet.size();//获取当前 set 的大小
                        specialtySet.add(sheet_0.getCell(3, k).getContents());
                        Integer specialtyId = Integer.valueOf(sheet_0.getCell(0, k).getContents().substring(0, 6));//截取学号前六位
                        if (specialtyNumInSet < specialtySet.size()) {//判断是否添加了新数据
                            Specialty specialty = new Specialty();
                            specialty.setSpecialtyId(specialtyId);
                            specialty.setName(specialtyId.toString().substring(0, 2) + specialtySet.toArray()[0]);//在专业前拼接学号前两位
                            specialtyList.add(specialty);
                        }
                        //学生信息处理
                        StudentTaken studentTaken = new StudentTaken();
                        studentTaken.setStudentId(Integer.valueOf(sheet_0.getCell(0, k).getContents()));
                        studentTaken.setName(sheet_0.getCell(1, k).getContents());
                        studentTaken.setGender(sheet_0.getCell(2, k).getContents());
                        studentTaken.setSpecialtyId(specialtyId);
                        studentTaken.setPassword(EncryptKit.md5(sheet_0.getCell(0, k).getContents()));//初始密码为学号
                        studentUploadList.add(studentTaken);
                    }

                    Map<String, Object> uploadStudentInfo = new HashMap<String, Object>() {{
                        put("specialtyInfo", specialtyList);
                        put("studentUploadList", studentUploadList);
                    }};
                    return adminStudentService.uploadStudentHandle(uploadStudentInfo).getMessageId();
                }
            } catch (IOException | BiffException e) {
                e.printStackTrace();
                return MessageInfo.OperationFailed.getMessageId();
            }
        }
        return MessageInfo.OperationFailed.getMessageId();
    }
}
