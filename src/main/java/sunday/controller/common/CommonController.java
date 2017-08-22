package sunday.controller.common;

import sunday.service.manager.ManagerService;
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

    @javax.annotation.Resource(name = "managerService")
    protected ManagerService managerService;

}
