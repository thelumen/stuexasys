package sunday.common.kit;

import sunday.pojo.teacher.Teacher;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    /**
     * 设置select2所需要的数据格式
     *
     * @param target
     * @param father
     */
    public static void getSelectInfo(List<String> target, List<Map<String, Object>> father) {
        for (String chapterName : target) {
            Map<String, Object> child = new HashMap<String, Object>() {{
                put("id", chapterName);
                put("text", chapterName);
            }};
            father.add(child);
        }
    }
}
