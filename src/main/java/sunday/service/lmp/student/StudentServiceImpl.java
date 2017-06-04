package sunday.service.lmp.student;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.common.kit.EncryptKit;
import sunday.mapper.student.StudentMapper;
import sunday.pojo.school.Student;
import sunday.pojo.student.*;
import sunday.service.student.StudentService;

import java.util.*;

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
    public TestPaper selectTestPaper(Page page, ExamInfo examInfo) {
        Map<String, String> changed = new HashMap<String, String>() {{
            put("1", "第一章");
            put("2", "第二章");
            put("3", "第三章");
            put("4", "第四章");
            put("5", "第五章");
            put("6", "第六章");
            put("7", "第七章");
            put("8", "第八章");
            put("9", "第九章");
            put("10", "第十章");
            put("11", "第十一章");
            put("12", "第十二章");
        }};
        String[] strArray = examInfo.getContent().split(",");
        StringBuilder sectionInfo = new StringBuilder();

        for (int i = 0; i < strArray.length; ) {
            strArray[i] = changed.get(strArray[i]);
            sectionInfo.append(strArray[i]);
            i++;
            if (i != strArray.length) {
                sectionInfo.append(",");
            }
        }

        Map<String, Object> testInfo = new HashMap<String, Object>() {{
            put("courseId", examInfo.getCourseId());
            put("section", sectionInfo);
        }};
        List<SingleTaken> singleTakenList = studentMapper.selectQuestionBaseSingle(testInfo);
        List<TfTaken> tfTakenList = studentMapper.selectQuestionBaseTf(testInfo);


        TestPaper testPaper = new TestPaper();
        testPaper.setSingleTakenList(singleTakenList);
        testPaper.setTfTakenList(tfTakenList);
        return testPaper;
    }

    @Override
    public TestPaper selectTestPaperAnother(Page page, ExamInfo examInfo) {
        Map<String, Object> testInfo = new HashMap<String, Object>() {{
            put("courseId", examInfo.getCourseId());
        }};
        List<AnotherQuestionTaken> anotherQuestionTakenList = studentMapper.selectQuestionBaseAnother(testInfo);
        TestPaper testPaper = new TestPaper();
        testPaper.setAnotherQuestionTaken(anotherQuestionTakenList.get((int) (Math.random()) * anotherQuestionTakenList.size()));
        if (testPaper.getAnotherQuestionTaken() != null) {
            return testPaper;
        }
        return null;
    }

    public List<ExamInfo> selectExamInfo(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<ExamTaken> examTakens = studentMapper.selectExamInfo(params);
        if (null != examTakens && examTakens.size() > 0) {
            List<ExamInfo> examInfoList = new ArrayList<>();
            /*每一条ExamTaken中有四次测试信息
            从中抽取当前考试信息并写入ExamInfo中
            （ 附加题章节数设为 0 ）
            * */
            for (ExamTaken examTaken : examTakens) {
                ExamInfo examInfo = new ExamInfo();
                examInfo.setCourseId(examTaken.getCourseId());
                examInfo.setCourseName(examTaken.getCourseName());
                examInfo.setTest(examTaken.getTest());
                if (1 == examTaken.getSign4()) {
                    examInfo.setContent("0");//附加题章节数设为0
                    examInfo.setDate(examTaken.getDate4());
                    examInfo.setTestNum("测试四");
                } else if (1 == examTaken.getSign3()) {
                    examInfo.setContent(examTaken.getContent3());
                    examInfo.setDate(examTaken.getDate3());
                    examInfo.setTestNum("测试三");
                } else if (1 == examTaken.getSign2()) {
                    examInfo.setContent(examTaken.getContent2());
                    examInfo.setDate(examTaken.getDate2());
                    examInfo.setTestNum("测试二");
                } else if (1 == examTaken.getSign1()) {
                    examInfo.setContent(examTaken.getContent1());
                    examInfo.setDate(examTaken.getDate1());
                    examInfo.setTestNum("测试一");
                }
                examInfoList.add(examInfo);
            }
            examInfoList.sort((o1, o2) -> {
                if (o1.getTest() > o2.getTest()) {
                    return 1;
                }
                if (o1.getTest() == o2.getTest()) {
                    return 0;
                }
                return -1;
            });
            long i=0;
            for (ExamInfo examInfo:examInfoList){
                i++;
                examInfo.setId(i);
            }
            return examInfoList;
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
        if (count > 0) {
            Integer returnRow = studentMapper.update(params);
            return returnRow > 0;
        } else return count == 0;
    }
}
