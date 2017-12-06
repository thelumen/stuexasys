package yang.common.enums;

/**
 *
 * @author yang
 * @date 2017/8/29
 * At 17:43
 */
public enum RoleEnum {
    /**
     * 超管，普通管理员，教师，学生
     */
    SUPER_MANAGER(1), MANAGER(2), TEACHER(3), STUDENT(4);

    private Integer roleId;

    RoleEnum(int roleId) {
        this.roleId = roleId;
    }

    public Integer getRoleId() {
        return roleId;
    }
}
