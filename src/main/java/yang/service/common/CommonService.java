package yang.service.common;

import org.springframework.beans.factory.annotation.Autowired;
import yang.dao.manager.AdminStudentMapper;
import yang.dao.manager.CourseMapper;
import yang.dao.manager.ManagerMapper;
import yang.dao.manager.SpecialtyMapper;
import yang.dao.shiro.ResourceMapper;
import yang.dao.shiro.RoleMapper;
import yang.dao.student.StudentMapper;
import yang.dao.teacher.*;

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
