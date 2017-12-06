package yang.common.kit;

import yang.domain.student.StudentTaken;

import java.util.HashMap;
import java.util.Map;

/**
 * @author yangxuyue
 * @date 2017/12/5.
 * At 21:09
 */
public final class StudentKit {

    /**
     * 从Session中获取当前登录学生的信息
     *
     * @return 当前登录学生的信息
     */
    public static StudentTaken getCurrentStudent() {
        return (StudentTaken) ShiroKit.getSession().getAttribute("currentStudent");
    }

    /**
     * 用于获取学生 int 类型的学号
     *
     * @return 当前登录学生的id（int）
     */
    public static int getStudentIdWithInt() {
        return getCurrentStudent().getStudentId();
    }

    /**
     * 用于获取学生 Map 类型的学号
     *
     * @return 当前登录学生的id（Map）
     */
    public static Map<String, Object> getStudentIdWithMap() {
        return new HashMap<String, Object>() {{
            put("studentId", getCurrentStudent().getStudentId());
        }};
    }

    /**
     * 用于获取学生 Map 类型的专业号
     *
     * @return 当前登录学生的专业Id(Map)
     */
    public static Map<String, Object> getStudentSpecialtyIdWithMap() {
        return new HashMap<String, Object>() {{
            put("specialtyId", getCurrentStudent().getSpecialtyId());
        }};
    }
}
