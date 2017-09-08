package sunday.common.enums;

/**
 * 用户类型
 * name:用户名称
 * num:权限级别
 * url:首页地址
 * Created by yang on 2017/5/22.
 * At 14:41
 */
public enum UserTypeEnum {

    MANAGER("管理员", "2", "/manager/main/mainProxy"),
    TEACHER("教师", "1", "/teacher/main/mainProxy"),
    STUDENT("学生", "0", "/student/main/mainProxy");

    private final String name;
    private final String num;
    private final String url;

    private UserTypeEnum(String name, String num, String url) {
        this.name = name;
        this.num = num;
        this.url = url;
    }

    public String getName() {
        return name;
    }

    public String getNum() {
        return num;
    }

    public String getUrl() {
        return url;
    }
}
