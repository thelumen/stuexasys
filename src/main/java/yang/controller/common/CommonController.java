package yang.controller.common;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ExceptionHandler;
import yang.common.kit.LogKit;
import yang.service.manager.AdminStudentService;
import yang.service.manager.CourseService;
import yang.service.manager.SpecialtyService;
import yang.service.shiro.RoleService;
import yang.service.student.StudentService;
import yang.service.teacher.*;

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
    @Autowired
    protected QuestionService questionService;

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
