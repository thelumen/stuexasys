package sunday.service.common;

import org.springframework.beans.factory.annotation.Autowired;
import sunday.mapper.manager.AdminStudentMapper;
import sunday.mapper.manager.CourseMapper;
import sunday.mapper.manager.ManagerMapper;
import sunday.mapper.manager.SpecialtyMapper;
import sunday.mapper.shiro.ResourceMapper;
import sunday.mapper.shiro.RoleMapper;
import sunday.mapper.student.StudentMapper;
import sunday.mapper.teacher.*;

/**
 * Created by yang on 2017/8/31.
 * At 8:30
 */
public class CommonService {

    @Autowired
    protected Specialty2CourseMapper specialty2CourseMapper;

    @Autowired
    protected Student2ExamMapper student2ExamMapper;

    @Autowired
    protected Student2GradeMapper student2GradeMapper;

    @Autowired
    protected Teacher2QuestionMapper teacher2QuestionMapper;

    @Autowired
    protected TeacherMapper teacherMapper;

    @Autowired
    protected StudentMapper studentMapper;

    @Autowired
    protected ResourceMapper resourceMapper;

    @Autowired
    protected RoleMapper roleMapper;

    @Autowired
    protected SpecialtyMapper specialtyMapper;

    @Autowired
    protected ManagerMapper managerMapper;

    @Autowired
    protected CourseMapper courseMapper;

    @Autowired
    protected QuestionMapper questionMapper;

    @Autowired
    protected AdminStudentMapper adminStudentMapper;
}
