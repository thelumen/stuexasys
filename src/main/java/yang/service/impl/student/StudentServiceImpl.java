package yang.service.impl.student;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yang.common.cache.EQCache;
import yang.common.enums.DeleteType;
import yang.common.enums.QuestionType;
import yang.common.kit.ChapterKit;
import yang.common.kit.EncryptKit;
import yang.common.kit.GetTest;
import yang.common.kit.LogKit;
import yang.dao.student.StudentMapper;
import yang.domain.common.Student;
import yang.domain.student.*;
import yang.domain.teacher.GradeTaken;
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
    private final Object object = new Object();

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
    public List<GradeTaken> selectGrade(Page page, Map<String, Object> params) {
        if (null != page) {
            PageHelper.startPage(page.getPageNum(), page.getPageSize(), page.getOrderBy());
        }
        List<GradeTaken> gradeTakens = mapper.selectGrade(params);
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
        List<GradeInfo> gradeTakenList;
        int grade = gradeInfo.getGrade();
        switch (gradeInfo.getTestNum()) {
            case "1":
                uploadGrade.put("grade1", grade);
                gradeTakenList = mapper.selectGradeInfo(uploadGrade);
                if (gradeTakenList.size() == 0) {
                    if (!(mapper.insertGrade(uploadGrade) > 0)) {
                        LOGGER.debug("学生课程与成绩关联数据添加失败");
                    }
                }
                changedRow = gradeTakenList.get(0).getGrade1() >= grade || mapper.updateGrade(uploadGrade) > 0;
                break;
            case "2":
                uploadGrade.put("grade2", grade);
                gradeTakenList = mapper.selectGradeInfo(uploadGrade);
                if (gradeTakenList.size() == 0) {
                    if (!(mapper.insertGrade(uploadGrade) > 0)) {
                        LOGGER.debug("学生课程与成绩关联数据添加失败");
                    }
                }
                changedRow = gradeTakenList.get(0).getGrade2() >= grade || mapper.updateGrade(uploadGrade) > 0;
                break;
            case "3":
                uploadGrade.put("grade3", grade);
                gradeTakenList = mapper.selectGradeInfo(uploadGrade);
                if (gradeTakenList.size() == 0) {
                    if (!(mapper.insertGrade(uploadGrade) > 0)) {
                        LOGGER.debug("学生课程与成绩关联数据添加失败");
                    }
                }
                changedRow = gradeTakenList.get(0).getGrade3() >= grade || mapper.updateGrade(uploadGrade) > 0;
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
        Objects.requireNonNull(examInfo);
        TestPaper testPaper = EQCache.getQuestionCache(examInfo);
        if (testPaper == null) {
            synchronized (object) {
                testPaper = EQCache.getQuestionCache(examInfo);
                if (null == testPaper) {
                    String[] sectionArray = examInfo.getContent().split(",");
                    Map<String, Object> testInfo = new HashMap<>();
                    testInfo.put("courseId", examInfo.getCourseId());
                    testInfo.put("sectionList", ChapterKit.getChapterTransport(sectionArray));

                    List<SingleTaken> singleTakenList = mapper.selectQuestionOfSingle(testInfo);
                    List<TfTaken> tfTakenList = mapper.selectQuestionOfTf(testInfo);

                    testPaper = new TestPaper();
                    testPaper.setSingleTakenList(singleTakenList);
                    testPaper.setTfTakenList(tfTakenList);

                    EQCache.setQuestionCache(examInfo, testPaper);
                }
            }
        }

        List<SingleTaken> singleTakenList = (List<SingleTaken>) GetTest.randQuestion(testPaper.getSingleTakenList(), QuestionType.Single);
        List<TfTaken> tfTakenList = (List<TfTaken>) GetTest.randQuestion(testPaper.getTfTakenList(), QuestionType.TF);

        //null值判断
        if (null == singleTakenList) {
            LOGGER.debug("选择题组题出现问题");
            return null;
        }
        if (null == tfTakenList) {
            LOGGER.debug("判断题组题出现问题");
            return null;
        }
        //判断返回题目数是否足够
        if (singleTakenList.size() != 20) {
            LOGGER.debug("返回选择题题目数不足");
            return null;
        }
        if (tfTakenList.size() != 5) {
            LOGGER.debug("返回判断题题目数不足");
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
        TestPaper returnPaper = new TestPaper();
        returnPaper.setCourseName(examInfo.getCourseName());
        returnPaper.setSingleTakenList(singleTakenList);
        returnPaper.setTfTakenList(tfTakenList);
        returnPaper.setTestNum(examInfo.getTestNum());

        return returnPaper;
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