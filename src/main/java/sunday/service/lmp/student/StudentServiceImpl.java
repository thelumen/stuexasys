package sunday.service.lmp.student;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.common.kit.EncryptKit;
import sunday.mapper.student.StudentMapper;
import sunday.pojo.school.Student;
import sunday.pojo.student.CourseTaken;
import sunday.pojo.student.GradeTaken;
import sunday.pojo.student.StudentInfo;
import sunday.pojo.student.StudentTaken;
import sunday.service.student.StudentService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/22.
 * At 17:35
 */
@Service("studentService")
public class StudentServiceImpl implements StudentService {

    @javax.annotation.Resource(name = "studentMapper")
    private StudentMapper studentMapper;

    @Override
    public List<Student> select(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<Student> students = studentMapper.select(params);
        if (null != students && students.size() > 0) {
            return students;
        }
        return null;
    }

    @Override
    public List<StudentTaken> selectStudentInfo(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<StudentTaken> students = studentMapper.selectStudentInfo(params);
        if (null != students && students.size() > 0) {
            return students;
        }
        return null;
    }

    @Override
    public List<GradeTaken> selectGrade(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<GradeTaken> gradeTakens = studentMapper.selectGrade(params);
        if (null != gradeTakens && gradeTakens.size() > 0) {
            return gradeTakens;
        }
        return null;
    }

    @Override
    public List<CourseTaken> selectCourse(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<CourseTaken> courseTakens = studentMapper.selectCourse(params);
        if (null != courseTakens && courseTakens.size() > 0) {
            return courseTakens;
        }
        return null;
    }

    @Override
    @Transactional
    public int insertStudent(Student student) {
        return studentMapper.insertStudent(student);
    }

    @Override
    public int insertGrade(Map<String, Object> params) {
        return studentMapper.insertGrade(params);
    }

    @Override
    public int insertStudentSpecialty(Student student) {
        return studentMapper.insertStudentSpecialty(student);
    }

    @Override
    public Boolean update(StudentInfo studentInfo) {
        int count = 0;
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", studentInfo.getStudentId());
        }};
        List<StudentTaken> studentTakens = studentMapper.selectStudentInfo(params);
        if (null != studentInfo.getOldPassword()) {//判断旧密码是否填写
            if (!studentInfo.getOldPassword().equals(studentInfo.getNewPassword())) {//判断填写的新旧密码是否不同
                if (EncryptKit.md5(studentInfo.getOldPassword()).equals
                        (studentTakens.get(0).getPassword())) {//判断输入的旧密码是否与数据库中的数据相同
                    params.put("password", EncryptKit.md5(studentInfo.getNewPassword()));
                    count++;
                }
            }
        }
        //判断号码是否更改
        if (null != studentInfo.getCellphone()) {
            if (!studentInfo.getCellphone().equals(studentTakens.get(0).getCellphone())) {
                params.put("cellphone", studentInfo.getCellphone());
                count++;
            }
        }
        //判断性别是否更改
        if (null != studentInfo.getGender()) {
            if (!studentInfo.getGender().equals(studentTakens.get(0).getGender())) {
                params.put("gender", studentInfo.getGender());
                count++;
            }
        }
        //判断邮箱是否更改
        if (null != studentInfo.getEmail()) {
            if (!studentInfo.getEmail().equals(studentTakens.get(0).getEmail())) {
                params.put("email", studentInfo.getEmail());
                count++;
            }
        }
        //判断是否有更改
        if (count>0){
            Integer returnRow=studentMapper.update(params);
            return returnRow>0;
        }else return count==0;
    }
}
