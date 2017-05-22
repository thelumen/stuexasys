package sunday.common.kit;

import sunday.common.enums.UserTypeEnum;

/**
 * Created by yang on 2017/5/22.
 * At 14:50
 */
public final class TypeValidateKit {

    private TypeValidateKit() {
    }

    /**
     * 验证登录用户类型
     *
     * @param userType
     * @return
     */
    public static String validateUserType(String userType) {
        String type = "";
        for (UserTypeEnum user : UserTypeEnum.values()) {
            if (user.getName().equals(userType)) {
                type = user.getNum();
            }
        }
        return type;
    }
}
