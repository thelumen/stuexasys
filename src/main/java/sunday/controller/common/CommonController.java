package sunday.controller.common;

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

    @javax.annotation.Resource(name = "speCouService")
    protected SpeCouService speCouService;

    @javax.annotation.Resource(name = "stuGraService")
    protected StuGraService stuGraService;

    @javax.annotation.Resource(name = "stuExaService")
    protected StuExaService stuExaService;

    @javax.annotation.Resource(name = "teaQueService")
    protected TeaQueService teaQueService;

    @javax.annotation.Resource(name = "studentService")
    protected StudentService studentService;

    @javax.annotation.Resource(name = "managerService")
    protected ManagerService managerService;

    @javax.annotation.Resource(name = "roleService")
    protected RoleService roleService;

    @javax.annotation.Resource(name = "resourceService")
    protected ResourceService resourceService;

}
