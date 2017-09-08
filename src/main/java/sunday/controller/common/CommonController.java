package sunday.controller.common;

import org.springframework.beans.factory.annotation.Autowired;
import sunday.service.manager.AdminStudentService;
import sunday.service.manager.CourseService;
import sunday.service.manager.ManagerService;
import sunday.service.manager.SpecialtyService;
import sunday.service.shiro.ResourceService;
import sunday.service.shiro.RoleService;
import sunday.service.student.StudentService;
import sunday.service.teacher.*;

/**
 * Created by yang on 2017/6/16.
 * At 9:52
 */
public class CommonController {
    @Autowired
    protected TeacherService teacherService;

    @Autowired
    protected Specialty2CourseService specialty2CourseService;

    @Autowired
    protected Student2GradeService student2GradeService;

    @Autowired
    protected Student2ExamService student2ExamService;

    @Autowired
    protected Teacher2QuestionService teacher2QuestionService;

    @Autowired
    protected StudentService studentService;

    @Autowired
    protected ManagerService managerService;

    @Autowired
    protected RoleService roleService;

    @Autowired
    protected ResourceService resourceService;

    @Autowired
    protected AdminStudentService adminStudentService;

    @Autowired
    protected CourseService courseService;

    @Autowired
    protected SpecialtyService specialtyService;

    @Autowired
    protected QuestionService questionService;
}
