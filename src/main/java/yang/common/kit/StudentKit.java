package yang.common.kit;

import yang.domain.student.StudentTaken;

import java.util.*;

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

    /**
     * 根据学生学号生成学期号
     *
     * @return [{id=2014, text=2014-2015}, {id=2015, text=2015-2016}]
     */
    public static List<Map<String, Object>> makeStudentYear() {
        List<Map<String, Object>> yearList = new ArrayList<>();
        Map<String, Object> year;
        int startYear = Integer.valueOf(String.valueOf(getStudentIdWithInt()).substring(0, 2)) + 2000;//截取学号前两位，组装成入学年
        int endYear = judgeSection();
        for (; startYear < endYear; endYear--) {
            year = new HashMap<>();
            year.put("id", endYear - 1);
            year.put("text", endYear - 1 + "-" + endYear);
            yearList.add(year);
        }
        return yearList;
    }

    /**
     * 获取当前时间
     *
     * @param until 希望获取的时间类型
     * @return int 类型的返回值
     */
    public static int getParentTime(String until) {
        Calendar calendar = Calendar.getInstance();
        switch (until) {
            case "year":
                return calendar.get(Calendar.YEAR);
            case "month":
                return calendar.get(Calendar.MONTH);// 0 代表一月 11 代表十二月
            default:
                return 0;
        }
    }

    /**
     * 根据当前月份判断所属的结束学期年号
     *
     * @return 年号
     */
    public static int judgeSection() {
        int parentYear = getParentTime("year");
        return getParentTime("month") > 8 ? parentYear + 1 : parentYear;
    }
}
