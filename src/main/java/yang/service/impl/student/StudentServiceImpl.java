package yang.service.impl.student;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yang.common.enums.DeleteType;
import yang.common.kit.ChapterKit;
import yang.common.kit.EncryptKit;
import yang.common.kit.LogKit;
import yang.dao.student.StudentMapper;
import yang.domain.common.Student;
import yang.domain.student.*;
import yang.service.student.StudentService;

import java.util.*;

/**
 * @author yang
 * @date 2017/5/22
 * At 17:35
 */
@Service("studentService")
public class StudentServiceImpl implements StudentService {
    private static final Logger LOGGER = LogKit.getLogger();

    @Autowired
    protected StudentMapper mapper;

    @Override
    public List<StudentTaken> selectStudentInfo(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<StudentTaken> students = mapper.selectStudentInfo(params);
        if (null != students && students.size() > 0) {
            return students;
        }
        return null;
    }

    @Override
    public List<GradeTaken> selectGrade(Map<String, Object> params) {
        List<GradeTaken> gradeTakens = mapper.selectGrade(params);
        if (null != gradeTakens && gradeTakens.size() > 0) {
            return gradeTakens;
        }
        return null;
    }

    @Override
    public List<CourseTaken> selectCourse(Map<String, Object> params) {
        List<CourseTaken> courseTakens = mapper.selectCourse(params);
        if (null != courseTakens && courseTakens.size() > 0) {
            return courseTakens;
        }
        return null;
    }

    @Override
    public TestPaper selectTestPaperAnother(int studentId, ExamInfo examInfo) {
        TestPaper testPaper = new TestPaper();
        Map<String, Object> testInfo = new HashMap<String, Object>() {{
            put("studentId", studentId);
            put("courseId", examInfo.getCourseId());
        }};
        AnotherTestTaken anotherTestTaken = mapper.selectStudentAnotherQuestionInfo(testInfo);
        List<AnotherTestTaken> anotherTestTakens = mapper.selectQuestionBaseAnother(testInfo);
        //判断此学生之前有无作答，有就加载同一题并加载其之前作答的答案
        if (null != anotherTestTaken) {
            long anotherQuestionId = anotherTestTaken.getId();
            String studentLastAnswer = anotherTestTaken.getResult();
            for (AnotherTestTaken anotherTestTaken1 : anotherTestTakens) {
                if (anotherTestTaken1.getId() == anotherQuestionId) {
                    anotherTestTaken1.setResult(studentLastAnswer);
                    testPaper.setAnotherQuestionTaken(anotherTestTaken1);
                }
            }
        } else {//没有就从题库中随机加载一题
            testPaper.setAnotherQuestionTaken(anotherTestTakens.get((int) (Math.random() * anotherTestTakens.size())));
        }
        testPaper.setTestNum(examInfo.getTestNum());
        testPaper.setCourseName(examInfo.getCourseName());
        if (testPaper.getAnotherQuestionTaken() != null) {
            return testPaper;
        }
        return null;
    }

    @Override
    public List<ExamInfo> selectExamInfo(Map<String, Object> params) {
        List<ExamTaken> examTakens = mapper.selectExamInfo(params);
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
                examInfo.setTest(examTaken.getStarted());
                if (null != examTaken.getSign4() && 1 == examTaken.getSign4()) {
                    examInfo.setContent("0");//附加题章节数设为0
                    examInfo.setDate(examTaken.getDate4());
                    examInfo.setTestNum("测试四");
                } else if (null != examTaken.getSign3() && 1 == examTaken.getSign3()) {
                    examInfo.setContent(examTaken.getContent3());
                    examInfo.setDate(examTaken.getDate3());
                    examInfo.setTestNum("测试三");
                } else if (null != examTaken.getSign2() && 1 == examTaken.getSign2()) {
                    examInfo.setContent(examTaken.getContent2());
                    examInfo.setDate(examTaken.getDate2());
                    examInfo.setTestNum("测试二");
                } else if (null != examTaken.getSign1() && 1 == examTaken.getSign1()) {
                    examInfo.setContent(examTaken.getContent1());
                    examInfo.setDate(examTaken.getDate1());
                    examInfo.setTestNum("测试一");
                }
                examInfoList.add(examInfo);
            }
            examInfoList.sort((o1, o2) -> {
                if (o1.getTest() > o2.getTest()) {
                    return -1;
                }
                if (Objects.equals(o1.getTest(), o2.getTest())) {
                    return 0;
                }
                return 1;
            });
            long i = 0;
            for (ExamInfo examInfo : examInfoList) {
                i++;
                examInfo.setId(i);
            }
            return examInfoList;
        }
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean insertGrade(GradeInfo gradeInfo) {
        boolean changedRow;
        Map<String, Object> uploadGrade = new HashMap<String, Object>() {{
            put("Id", gradeInfo.getId());
            put("courseId", gradeInfo.getCourseId());
            put("studentId", gradeInfo.getStudentId());
        }};
        switch (gradeInfo.getTestNum()) {
            case "1":
                uploadGrade.put("grade1", gradeInfo.getGrade());
                if (mapper.selectGradeInfo(uploadGrade).size() == 0) {
                    if (!(mapper.insertGrade(uploadGrade) > 0)) {
                        LOGGER.debug("学生课程与成绩关联数据添加失败");
                    }
                }
                changedRow = mapper.updateGrade(uploadGrade) > 0;
                break;
            case "2":
                uploadGrade.put("grade2", gradeInfo.getGrade());
                if (mapper.selectGradeInfo(uploadGrade).size() == 0) {
                    if (!(mapper.insertGrade(uploadGrade) > 0)) {
                        LOGGER.debug("学生课程与成绩关联数据添加失败");
                    }
                }
                changedRow = mapper.updateGrade(uploadGrade) > 0;
                break;
            case "3":
                uploadGrade.put("grade3", gradeInfo.getGrade());
                if (mapper.selectGradeInfo(uploadGrade).size() == 0) {
                    if (!(mapper.insertGrade(uploadGrade) > 0)) {
                        LOGGER.debug("学生课程与成绩关联数据添加失败");
                    }
                }
                changedRow = mapper.updateGrade(uploadGrade) > 0;
                break;
            case "4":
                uploadGrade.put("result", gradeInfo.getResult());
                try {
                    changedRow = mapper.insertAnotherResult(uploadGrade) > 0;
                } catch (DataAccessException e) {
                    changedRow = mapper.updateAnotherResult(uploadGrade) > 0;
                }
                break;
            default:
                return false;
        }
        return changedRow;
    }

    @Override
    public boolean update(StudentInfo studentInfo) {
        int count = 0;
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", studentInfo.getStudentId());
        }};

        List<StudentTaken> studentTaken = mapper.selectStudentInfo(params);
        //判断密码更改
        switch (studentInfo.getUpdateType()) {
            case StuSet://学生设置密码处理
                if (null != studentInfo.getOldPassword()) {//判断旧密码是否填写
                    if (!studentInfo.getOldPassword().equals(studentInfo.getNewPassword())) {//判断填写的新旧密码是否不同
                        if (EncryptKit.md5(studentInfo.getOldPassword()).equals
                                (studentTaken.get(0).getPassword())) {//判断输入的旧密码与数据库中的数据是否相同
                            params.put("password", EncryptKit.md5(studentInfo.getNewPassword()));
                            count++;
                        }
                    }
                }
                break;
            case StuFind://学生密码找回处理
                break;
            case AdminSet://管理员设置密码处理
                if (!EncryptKit.md5(studentInfo.getPassword()).equals
                        (studentTaken.get(0).getPassword())) {//判断输入的旧密码是否与数据库中的数据相同
                    params.put("password", EncryptKit.md5(studentInfo.getPassword()));
                    count++;
                }
                break;
            default:
                break;
        }
        //判断姓名更改
        if (null != studentInfo.getName()) {
            if (!studentInfo.getName().equals(studentTaken.get(0).getName())) {
                params.put("name", studentInfo.getName());
                count++;
            }
        }
        //判断专业更改
        if (null != studentInfo.getSpecialtyId()) {
            if (!studentInfo.getSpecialtyId().equals(studentTaken.get(0).getSpecialtyId())) {
                params.put("specialtyId", studentInfo.getSpecialtyId());
                count++;
            }
        }
        //判断号码更改
        if (null != studentInfo.getCellphone()) {
            if (!studentInfo.getCellphone().equals(studentTaken.get(0).getCellphone())) {
                params.put("cellphone", studentInfo.getCellphone());
                count++;
            }
        }
        //判断性别更改
        if (null != studentInfo.getGender()) {
            if (!studentInfo.getGender().equals(studentTaken.get(0).getGender())) {
                params.put("gender", studentInfo.getGender());
                count++;
            }
        }
        //判断邮箱更改
        if (null != studentInfo.getEmail()) {
            if (!studentInfo.getEmail().equals(studentTaken.get(0).getEmail())) {
                params.put("email", studentInfo.getEmail());
                count++;
            }
        }
        //判断是否有更改
        if (count > 0) {
            return mapper.update(params) > 0;
        } else {
            return count == 0;
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean delete(Map<String, Object> params) {
        switch ((DeleteType) params.get("deleteType")) {
            case DeleteWithStudentId:
                return mapper.delete(params) > 0;
            case DeleteWithSpecialtyId:
                return mapper.selectStudentInfo(params).size() <= 0 || mapper.delete(params) > 0;
            default:
                return false;
        }
    }

    @Override
    public TestPaper selectQuestion(ExamInfo examInfo) {
        if (examInfo == null) {
            return null;
        }
        String[] strArray = examInfo.getContent().split(",");
        //将得到的 章节(sectionInfo) 字符串与其他 参数(examInfo) 发往数据库进行查询 并按 难度(levels) 排序
        Map<String, Object> testInfo = new HashMap<>();
        testInfo.put("courseId", examInfo.getCourseId());
        testInfo.put("sectionList", ChapterKit.getChapterTransport(strArray));
        //返回 按章节查询出的全部 选择题（singleTakenList） 和 判断题 （tfTakenList）
        List<SingleTaken> singleTakenList = mapper.selectQuestionOfSingle(testInfo);
        List<TfTaken> tfTakenList = mapper.selectQuestionOfTf(testInfo);
        //判断返回题目数是否足够
        if (singleTakenList.size() != 20 || tfTakenList.size() != 5) {
            LOGGER.debug("组题出现异常");
            return null;
        }
        //对返回的答案进行加密
        int a = 35;
        int b = 36;
        int c = 37;
        int d = 38;
        for (SingleTaken singleTaken : singleTakenList) {
            singleTaken.setRealAnswer(singleTaken.getResult());
            switch (singleTaken.getResult()) {
                case "A":
                    singleTaken.setResult("" + a);
                    a += 5;
                    break;
                case "B":
                    singleTaken.setResult("" + b);
                    b += 5;
                    break;
                case "C":
                    singleTaken.setResult("" + c);
                    c += 5;
                    break;
                case "D":
                    singleTaken.setResult("" + d);
                    d += 5;
                    break;
                default:
                    break;
            }
        }
        int t = 7;
        int f = 5;
        for (TfTaken tfTaken : tfTakenList) {
            tfTaken.setRealAnswer(tfTaken.getResult());
            switch (tfTaken.getResult()) {
                case (0):
                    tfTaken.setResult(t);
                    t += 3;//1
                    break;
                case (1):
                    tfTaken.setResult(f);
                    f += 3;//2
                    break;
                default:
                    break;
            }
        }
        //将得到的 选择题(testSingleList) 和 判断题(testTfList) 整合到 一个对象（testPaper） 中返回
        TestPaper testPaper = new TestPaper();
        testPaper.setCourseName(examInfo.getCourseName());
        testPaper.setSingleTakenList(singleTakenList);
        testPaper.setTfTakenList(tfTakenList);
        testPaper.setTestNum(examInfo.getTestNum());
        return testPaper;
    }

    @Override
    public List<Student> select(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<Student> students = mapper.select(params);
        if (null != students && students.size() > 0) {
            return students;
        }
        return null;
    }

    @Override
    public boolean insert(Student student) {
        return mapper.insert(student) > 0;
    }

    @Override
    public boolean updateStudent(Student student) {
        return mapper.updateStudent(student) > 0;
    }

    @Override
    public boolean deleteStudent(Map<String, Object> params) {
        return mapper.deleteStudent(params) > 0;
    }
}