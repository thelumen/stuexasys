package sunday.common.kit;

import sunday.pojo.manager.Manager;

/**
 * Created by yang on 2017/8/28.
 * At 21:53
 */
public final class ManagerKit {
    private ManagerKit() {
    }

    /**
     * 获取当前管理员身份id
     *
     * @return
     */
    public static Integer getCurrentManagerId() {

        return ((Manager) ShiroKit.getSession().getAttribute("currentManager")).getManagerId();
    }

    /**
     * 获取当前登录管理员信息
     *
     * @return
     */
    public static Manager getCurrentManager() {
        return ((Manager) ShiroKit.getSession().getAttribute("currentManager"));
    }

}
