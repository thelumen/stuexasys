package yang.controller.manager;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import yang.common.base.ResultBean;
import yang.common.enums.DeleteType;
import yang.common.enums.UpdateType;
import yang.common.kit.CommonKit;
import yang.common.kit.EncryptKit;
import yang.controller.common.CommonController;
import yang.domain.common.Specialty;
import yang.domain.common.Student;
import yang.domain.student.StudentInfo;
import yang.domain.student.StudentTaken;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;

/**
 * @author yang
 * @date 2017/8/29
 * At 7:34
 */
@Controller
@RequestMapping("/admin/student")
public class StudentInAdminController extends CommonController {

    /**
     * 返回学生编辑页面
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:manager")
    public String editStudent() {
        return "/manager/student/studentProxy";
    }

    /**
     * 默认加载专业号为100000学生
     *
     * @param params 分页参数.
     * @return 格式化的信息.
     */
    @RequestMapping(value = "/default/list", method = RequestMethod.POST)
    @ResponseBody
    public Object initStudentTable(@RequestBody Map<String, Object> params) {
        Map<String, Object> selectOptionMap = new HashMap<String, Object>() {{
            put("specialtyId", new ArrayList<String>() {{
                add("100000");
            }});
        }};
        List<StudentTaken> studentTakenList = studentService.selectStudentInfo(CommonKit.getMapInfo2Page(params), selectOptionMap);
        return CommonKit.getTakenInfo(studentTakenList);
    }

    /**
     * 更新学生
     *
     * @param studentInfo .
     * @return .
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:manager")
    @ResponseBody
    public Object saveStudentInfo(@RequestBody StudentInfo studentInfo) {
        studentInfo.setUpdateType(UpdateType.AdminSet);
        return new ResultBean<>(studentService.update(studentInfo));
    }

    /**
     * 删除学生
     *
     * @param studentInfo .
     * @return .
     */
    @RequestMapping(value = "/delete", method = RequestMethod.DELETE)
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public Object deleteStudent(@RequestBody StudentInfo studentInfo) {
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("deleteType", DeleteType.DeleteWithStudentId);
            put("studentId", studentInfo.getStudentId());
        }};
        return new ResultBean<>(studentService.delete(params));
    }

    /**
     * 查找学生信息
     *
     * @param params      分页信息.
     * @param specialtyId 专业信息.
     * @param studentId   学号.
     * @return .
     */
    @RequestMapping(value = "/list/{specialtyId}/{studentId}", method = RequestMethod.POST)
    @ResponseBody
    public Object selectStudent(@RequestBody Map<String, Object> params,
                                @PathVariable(value = "specialtyId") String specialtyId,
                                @PathVariable(value = "studentId") String studentId) {
        Map<String, Object> info = new HashMap<>();
        if (!"null".equals(specialtyId)) {
            info.put("specialtyId", Arrays.asList(specialtyId.split(",")));
        }
        if (!"null".equals(studentId)) {
            info.put("studentId", studentId);
        }
        List<StudentTaken> studentInfos = studentService.selectStudentInfo(CommonKit.getOrginMapInfo2Page(params), info);
        return CommonKit.getTakenInfo(studentInfos);
    }

    /**
     * 上传学生表
     *
     * @param file
     * @return
     * @throws IOException
     * @throws BiffException
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:admin")
    @ResponseBody
    public Object uploadStudentHandle(@RequestParam("files") MultipartFile file) throws IOException, BiffException {
        try (InputStream input = file.getInputStream();) {
            Workbook workbook = Workbook.getWorkbook(input);
            Sheet sheet = workbook.getSheet(0);
            //总行数
            int rows = sheet.getRows();
            if (Objects.equals(sheet.getCell(0, rows - 1).getContents().trim(), "") ||
                    Objects.equals(sheet.getCell(1, rows - 1).getContents().trim(), "") ||
                    Objects.equals(sheet.getCell(2, rows - 1).getContents().trim(), "") ||
                    Objects.equals(sheet.getCell(3, rows - 1).getContents().trim(), "")
                    ) {
                return new ResultBean<>("请确保Excel文件的数据内容填写正确与完整！");
            }

            Set<Specialty> specialties = new HashSet<>();
            List<Student> students = new ArrayList<>();
            Set<Student> checkStudents = new HashSet<>();

            Specialty specialty;
            Student student;
            for (int i = 1; i < rows; i++) {
                String studentId = sheet.getCell(0, i).getContents().trim();
                String studentName = sheet.getCell(1, i).getContents().trim();
                String gender = sheet.getCell(2, i).getContents().trim();
                String specialtyName = sheet.getCell(3, i).getContents().trim();

                if (Objects.equals(studentId, "") || Objects.equals(studentName, "")
                        || Objects.equals(gender, "") || Objects.equals(specialtyName, "")) {
                    return new ResultBean<>("请确保在第" + (i + 1) + "行：学生的学号，姓名，性别和专业填写完整！");
                }

                //新增专业
                Integer specialtyId = Integer.valueOf(studentId.substring(0, 6));
                specialty = new Specialty();
                specialty.setSpecialtyId(specialtyId);
                specialty.setName(specialtyName);

                specialties.add(specialty);

                //新增学生
                student = new Student();
                student.setStudentId(Integer.valueOf(studentId));
                student.setName(studentName);
                student.setPassword(EncryptKit.md5(studentId));
                student.setGender(gender);
                student.setSpecialtyId(specialtyId);

                students.add(student);
            }

            checkStudents.addAll(students);

            int totalStudents = students.size();
            int realStudents = checkStudents.size();
            if (totalStudents != realStudents) {
                return new ResultBean<>("学生中有学号重复的！");
            }

            //更新专业
            List<Specialty> specialtiesInDB = specialtyService.select(null);
            for (Specialty s : specialties) {
                if (null == specialtiesInDB || !specialtiesInDB.contains(s)) {
                    specialtyService.insert(s);
                }
            }

            //更新学生
            List<Student> studentsInDB = studentService.select(null, null);
            for (Student s : students) {
                if (null == studentsInDB || !studentsInDB.contains(s)) {
                    studentService.insert(s);
                }
            }

            return new ResultBean<>(true);
        }
    }

}
