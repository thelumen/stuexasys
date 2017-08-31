package sunday.service.lmp.student;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sunday.common.enums.NumberDifficultyEnum;
import sunday.common.kit.EncryptKit;
import sunday.common.kit.MakeTestPaperKit;
import sunday.common.kit.RandomKit;
import sunday.pojo.school.Student;
import sunday.pojo.student.*;
import sunday.service.common.CommonService;
import sunday.service.student.StudentService;

import java.util.*;

/**
 * Created by yang on 2017/5/22.
 * At 17:35
 */
@Service("studentService")
public class StudentServiceImpl extends CommonService implements StudentService {

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
        if (examInfo == null) return null;
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
            put("13", "第十三章");
            put("14", "第十四章");
            put("15", "第十五章");
            put("16", "第十六章");
        }};
        String[] strArray = examInfo.getContent().split(",");
        List<String> sectionInfo = new ArrayList<>();
        /*
        拼接 章节(sectionInfo) 字符串用于查询
        */
        for (int i = 0; i < strArray.length; i++) {
            strArray[i] = changed.get(strArray[i]);
            sectionInfo.add(strArray[i]);
        }
        /*
        将得到的 章节(sectionInfo) 字符串与其他 参数(examInfo) 发往数据库进行查询 并按 难度(levels) 排序
        返回 按章节查询出的全部 选择题（singleTakenList） 和 判断题 （tfTakenList）
        */
        Map<String, Object> testInfo = new HashMap<String, Object>() {{
            put("courseId", examInfo.getCourseId());
            put("sectionList", sectionInfo);
        }};
        List<SingleTaken> singleTakenList = studentMapper.selectQuestionBaseSingle(testInfo);
        List<TfTaken> tfTakenList = studentMapper.selectQuestionBaseTf(testInfo);
        //判断返回值不为空 且 选择题数量大于配置枚举中最小数量 判断题数量大于配置枚举最小数量
        if (null != singleTakenList && null != tfTakenList) {
            if (singleTakenList.size() >= NumberDifficultyEnum.Total_Single.getNumbers() && tfTakenList.size() >= NumberDifficultyEnum.Total_Tf.getNumbers()) {
                /*
                用三个Map将不同难度的题的标号的 起始(start) 与 结束(end) 位置标出
                传入选择题列表
                */
                Map<String, Integer> single_1 = new HashMap<>();
                Map<String, Integer> single_2 = new HashMap<>();
                Map<String, Integer> single_3 = new HashMap<>();
                MakeTestPaperKit.makeStartEndMap_s(singleTakenList, single_1, single_2, single_3);
                Map<String, Integer> tf_1 = new HashMap<>();
                Map<String, Integer> tf_2 = new HashMap<>();
                Map<String, Integer> tf_3 = new HashMap<>();
                MakeTestPaperKit.makeStartEndMap_t(tfTakenList, tf_1, tf_2, tf_3);
                /*
                按难度分别通过对应的 方法(randomSet) 与 map(single_1) 产生 随机数组(set_s_1)
                */
                HashSet<Integer> set_s_1 = new HashSet<>();
                HashSet<Integer> set_s_2 = new HashSet<>();
                HashSet<Integer> set_s_3 = new HashSet<>();
                HashSet<Integer> set_t_1 = new HashSet<>();
                HashSet<Integer> set_t_2 = new HashSet<>();
                HashSet<Integer> set_t_3 = new HashSet<>();
                RandomKit.randomSet(single_1.get("start"), single_1.get("end"), NumberDifficultyEnum.Single_1.getNumbers(), set_s_1);
                RandomKit.randomSet(single_2.get("start"), single_2.get("end"), NumberDifficultyEnum.Single_2.getNumbers(), set_s_2);
                RandomKit.randomSet(single_3.get("start"), single_3.get("end"), NumberDifficultyEnum.Single_3.getNumbers(), set_s_3);
                RandomKit.randomSet(tf_1.get("start"), tf_1.get("end"), NumberDifficultyEnum.Tf_1.getNumbers(), set_t_1);
                RandomKit.randomSet(tf_2.get("start"), tf_2.get("end"), NumberDifficultyEnum.Tf_2.getNumbers(), set_t_2);
                RandomKit.randomSet(tf_3.get("start"), tf_3.get("end"), NumberDifficultyEnum.Tf_3.getNumbers(), set_t_3);
                /*
                按上述得到的随机数组从全部列表中得到返回列表
                */
                List<SingleTaken> testSingleList = new ArrayList<>();
                List<TfTaken> testTfList = new ArrayList<>();
                for (Integer aQuestion : set_s_1) {
                    testSingleList.add(singleTakenList.get(aQuestion));
                }
                for (Integer aQuestion : set_s_2) {
                    testSingleList.add(singleTakenList.get(aQuestion));
                }
                for (Integer aQuestion : set_s_3) {
                    testSingleList.add(singleTakenList.get(aQuestion));
                }
                for (Integer aQuestion : set_t_1) {
                    testTfList.add(tfTakenList.get(aQuestion));
                }
                for (Integer aQuestion : set_t_2) {
                    testTfList.add(tfTakenList.get(aQuestion));
                }
                for (Integer aQuestion : set_t_3) {
                    testTfList.add(tfTakenList.get(aQuestion));
                }
                /*
                将得到的 选择题(testSingleList) 和 判断题(testTfList) 整合到 一个对象（testPaper） 中返回
                */
                TestPaper testPaper = new TestPaper();
                testPaper.setSingleTakenList(testSingleList);
                testPaper.setTfTakenList(testTfList);
                testPaper.setTestNum(examInfo.getTestNum());
                return testPaper;
            }
            System.out.println("选择题或判断题List返回值长度小于最小长度");
            return null;
        }
        System.out.println("选择题或判断题List返回值为空");
        return null;
    }

    @Override
    public TestPaper selectTestPaperAnother(Page page, int studentId, ExamInfo examInfo) {
        TestPaper testPaper = new TestPaper();
        Map<String, Object> testInfo = new HashMap<String, Object>() {{
            put("studentId", studentId);
            put("courseId", examInfo.getCourseId());
        }};
        AnotherTestTaken anotherTestTaken = studentMapper.selectStudentAnotherQuestionInfo(testInfo);
        List<AnotherTestTaken> anotherTestTakens = studentMapper.selectQuestionBaseAnother(testInfo);

        if (null != anotherTestTaken) {
            long anotherQuestionId = anotherTestTaken.getId();
            String studentLastAnswer = anotherTestTaken.getResult();
            for (AnotherTestTaken anotherTestTaken1 : anotherTestTakens) {
                if (anotherTestTaken1.getId() == anotherQuestionId) {
                    anotherTestTaken1.setResult(studentLastAnswer);
                    testPaper.setAnotherQuestionTaken(anotherTestTaken1);
                }
            }
        } else {
            testPaper.setAnotherQuestionTaken(anotherTestTakens.get((int) (Math.random() * anotherTestTakens.size())));
        }
        testPaper.setTestNum(examInfo.getTestNum());
        if (testPaper.getAnotherQuestionTaken() != null) {
            return testPaper;
        }
        return null;
    }

    @Override
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
                if (Objects.equals(o1.getTest(), o2.getTest())) {
                    return 0;
                }
                return -1;
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
    @Transactional
    public int insertStudent(Student student) {
        return studentMapper.insertStudent(student);
    }

    @Override
    public int insertStudentRole(Student student) {
        return studentMapper.insertStudentRole(student);
    }

    @Override
    public boolean insertGrade(GradeInfo gradeInfo) {
        boolean changedRow = false;
        Map<String, Object> uploadGrade = new HashMap<String, Object>() {{
            put("Id", gradeInfo.getId());
            put("courseId", gradeInfo.getCourseId());
            put("studentId", gradeInfo.getStudentId());
        }};
        switch (gradeInfo.getTestNum()) {
            case "1":
                uploadGrade.put("grade1", gradeInfo.getGrade());
                if (studentMapper.insertGrade(uploadGrade) == 0) {
                    studentMapper.updateGrade(uploadGrade);
                }
                changedRow = true;
                break;
            case "2":
                uploadGrade.put("grade2", gradeInfo.getGrade());
                if (studentMapper.updateGrade(uploadGrade) == 0) {
                    studentMapper.insertGrade(uploadGrade);
                }
                changedRow = true;
                break;
            case "3":
                uploadGrade.put("grade3", gradeInfo.getGrade());
                if (studentMapper.updateGrade(uploadGrade) == 0) {
                    studentMapper.insertGrade(uploadGrade);
                }
                changedRow = true;
                break;
            case "4":
                uploadGrade.put("result", gradeInfo.getResult());
                if (studentMapper.insertAnotherResult(uploadGrade) > 0) {
                    studentMapper.updateAnotherResult(uploadGrade);
                    changedRow = true;
                }
                break;
        }
        return changedRow;
    }

    @Override
    public boolean update(StudentInfo studentInfo) {
        int count = 0;
        Map<String, Object> params = new HashMap<String, Object>() {{
            put("studentId", studentInfo.getStudentId());
        }};

        List<StudentTaken> studentTakens = studentMapper.selectStudentInfo(params);

        switch (studentInfo.getUpdateType()) {
            case StuSet://学生设置密码处理
                if (null != studentInfo.getOldPassword()) {//判断旧密码是否填写
                    if (!studentInfo.getOldPassword().equals(studentInfo.getNewPassword())) {//判断填写的新旧密码是否不同
                        if (EncryptKit.md5(studentInfo.getOldPassword()).equals
                                (studentTakens.get(0).getPassword())) {//判断输入的旧密码是否与数据库中的数据是否相同
                            params.put("password", EncryptKit.md5(studentInfo.getNewPassword()));
                            count++;
                        }
                    }
                }
                break;
            case StuFind://学生密码找回处理
                break;
            case AdminSet://管理员设置密码处理
                if (EncryptKit.md5(studentInfo.getPassword()).equals
                        (studentTakens.get(0).getPassword())) {//判断输入的旧密码是否与数据库中的数据是否相同
                    params.put("password", EncryptKit.md5(studentInfo.getOldPassword()));
                    count++;
                }
                break;
            default:
                break;
        }
        //判断专业是否更改
        if (null != studentInfo.getSpecialtyId()) {
            if (!studentInfo.getSpecialtyId().equals(studentTakens.get(0).getSpecialtyId())) {
                params.put("specialtyId", studentInfo.getSpecialtyId());
                count++;
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
            return studentMapper.update(params) > 0;
        } else return count == 0;
    }

    @Override
    public boolean delete(StudentInfo studentInfo) {
        return studentMapper.delete(new HashMap<String, Object>() {{
            put("studentId", studentInfo.getStudentId());
        }}) > 0;
    }
}
