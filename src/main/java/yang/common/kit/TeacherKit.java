package yang.common.kit;

import yang.domain.teacher.Teacher;

/**
 * Created by yang on 2017/8/24.
 * At 22:46
 */
public final class TeacherKit {
    private TeacherKit() {
    }

    /**
     * 获取当前登录教师id
     *
     * @return
     */
    public static Integer getCurrentTeacherId() {
        return ((Teacher) ShiroKit.getSession().getAttribute("currentTeacher")).getTeacherId();
    }

}
