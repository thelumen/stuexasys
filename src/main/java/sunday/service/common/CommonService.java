package sunday.service.common;

import sunday.mapper.manager.AdminStudentMapper;
import sunday.mapper.manager.CourseMapper;
import sunday.mapper.manager.ManagerMapper;
import sunday.mapper.manager.SpecialtyMapper;
import sunday.mapper.shiro.ResourceMapper;
import sunday.mapper.shiro.RoleMapper;
import sunday.mapper.student.StudentMapper;
import sunday.mapper.teacher.*;
import sunday.service.manager.CourseService;

/**
 * Created by yang on 2017/8/31.
 * At 8:30
 */
public class CommonService {

    @javax.annotation.Resource(name = "specialty2CourseMapper")
    protected Specialty2CourseMapper specialty2CourseMapper;

    @javax.annotation.Resource(name = "student2ExamMapper")
    protected Student2ExamMapper student2ExamMapper;

    @javax.annotation.Resource(name = "student2GradeMapper")
    protected Student2GradeMapper student2GradeMapper;

    @javax.annotation.Resource(name = "teacher2QuestionMapper")
    protected Teacher2QuestionMapper teacher2QuestionMapper;

    @javax.annotation.Resource(name = "teacherMapper")
    protected TeacherMapper teacherMapper;

    @javax.annotation.Resource(name = "studentMapper")
    protected StudentMapper studentMapper;

    @javax.annotation.Resource(name = "resourceMapper")
    protected ResourceMapper resourceMapper;

    @javax.annotation.Resource(name = "roleMapper")
    protected RoleMapper roleMapper;

    @javax.annotation.Resource(name = "specialtyMapper")
    protected SpecialtyMapper specialtyMapper;

    @javax.annotation.Resource(name = "managerMapper")
    protected ManagerMapper managerMapper;

    @javax.annotation.Resource(name = "courseMapper")
    protected CourseMapper courseMapper;

    @javax.annotation.Resource(name = "questionMapper")
    protected QuestionMapper questionMapper;

    @javax.annotation.Resource(name = "adminStudentMapper")
    protected AdminStudentMapper adminStudentMapper;
}
