package sunday.controller.common;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ExceptionHandler;
import sunday.common.kit.LogKit;
import sunday.service.manager.AdminStudentService;
import sunday.service.manager.CourseService;
import sunday.service.manager.SpecialtyService;
import sunday.service.shiro.RoleService;
import sunday.service.student.StudentService;
import sunday.service.teacher.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by yang on 2017/6/16.
 * At 9:52
 */
public class CommonController {

    protected static final Logger LOGGER = LogKit.getLogger();

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
    protected RoleService roleService;
    @Autowired
    protected AdminStudentService adminStudentService;
    @Autowired
    protected CourseService courseService;
    @Autowired
    protected SpecialtyService specialtyService;

    /**
     * 统一异常处理
     *
     * @param request
     * @param response
     * @param exception
     */
    @ExceptionHandler
    public String exceptionHandler(HttpServletRequest request, HttpServletResponse response, Exception exception) {
        LOGGER.error("Exception Excute：", exception);
        request.setAttribute("exception", exception.toString());

        if (null != request.getHeader("X-Requested-With") && request.getHeader("X-Requested-With").equalsIgnoreCase("XMLHttpRequest")) {
            request.setAttribute("requestHeader", "ajax");
        }

        return "/common/error/error";
    }
}
