package sunday.common.kit;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;

/**
 * Created by yang on 2017/5/22.
 * At 15:15
 */
public final class ShiroKit {

    private static final Logger LOGGER = LogKit.getLogger();

    private ShiroKit() {
    }

    /**
     * 获取subje
     *
     * @return
     */
    public static Subject getSubject() {
        return SecurityUtils.getSubject();
    }

    /**
     * 登录
     *
     * @param account  账号+用户类型
     * @param password 密码
     * @return
     */
    public static boolean login(String account, String password) {
        boolean isSuccess = false;
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(account, EncryptKit.md5(password));
        try {
            subject.login(token);
            if (subject.isAuthenticated()) {
                isSuccess = true;
            }
        } catch (IncorrectCredentialsException e) {
            isSuccess = false;
            String msg = "密码错误！";
            LOGGER.error(msg);
        } catch (ExcessiveAttemptsException e) {
            isSuccess = false;
            String msg = "登录失败次数过多！";
            LOGGER.error(msg);
        } catch (LockedAccountException e) {
            isSuccess = false;
            String msg = "帐号已被锁定！";
            LOGGER.error(msg);
        } catch (DisabledAccountException e) {
            isSuccess = false;
            String msg = "帐号已被禁用！";
            LOGGER.error(msg);
        } catch (ExpiredCredentialsException e) {
            isSuccess = false;
            String msg = "帐号已过期！";
            LOGGER.error(msg);
        } catch (UnknownAccountException e) {
            isSuccess = false;
            String msg = "帐号不存在！";
            LOGGER.error(msg);
        } catch (UnauthorizedException e) {
            isSuccess = false;
            String msg = "没有得到授权！";
            LOGGER.error(msg);
        }
        return isSuccess;
    }
}
