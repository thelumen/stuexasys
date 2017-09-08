package sunday.common.kit;

import sunday.pojo.school.Student;

/**
 * Created by yang on 2017/9/8.
 * At 11:00
 */
public final class StudentKit {
    private StudentKit() {
    }

    /**
     * 获取当前学生id
     *
     * @return
     */
    public static Integer getCurrentStudentId() {

        return ((Student) ShiroKit.getSession().getAttribute("currentStudent")).getStudentId();
    }

    /**
     * 获取当前登录学生信息
     *
     * @return
     */
    public static Student getCurrentStudent() {
        return ((Student) ShiroKit.getSession().getAttribute("currentStudent"));
    }

}
