package sunday.controller.common;

import sunday.service.manager.AdminStudentService;
import sunday.service.manager.ManagerService;
import sunday.service.shiro.ResourceService;
import sunday.service.shiro.RoleService;
import sunday.service.student.StudentService;
import sunday.service.teacher.*;

/**
 * Created by yang on 2017/6/16.
 * At 9:52
 */
public class CommonController {
    @javax.annotation.Resource(name = "teacherService")
    protected TeacherService teacherService;

    @javax.annotation.Resource(name = "specialty2CourseService")
    protected Specialty2CourseService specialty2CourseService;

    @javax.annotation.Resource(name = "student2GradeService")
    protected Student2GradeService student2GradeService;

    @javax.annotation.Resource(name = "student2ExamService")
    protected Student2ExamService student2ExamService;

    @javax.annotation.Resource(name = "teacher2QuestionService")
    protected Teacher2QuestionService teacher2QuestionService;

    @javax.annotation.Resource(name = "studentService")
    protected StudentService studentService;

    @javax.annotation.Resource(name = "managerService")
    protected ManagerService managerService;

    @javax.annotation.Resource(name = "roleService")
    protected RoleService roleService;

    @javax.annotation.Resource(name = "resourceService")
    protected ResourceService resourceService;

    @javax.annotation.Resource(name = "adminStudentService")
    protected AdminStudentService adminStudentService;

}
