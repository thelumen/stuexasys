package sunday.common.exception;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.slf4j.Logger;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
import sunday.common.kit.LogKit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * shiro的异常捕获处理
 * Created by yang on 2017/2/8.
 * At 13:22
 */
public class ShiroHandlerExceptionResolver implements HandlerExceptionResolver {
    private static final Logger LOGGER = LogKit.getLogger();

    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {
        ModelAndView mav = new ModelAndView();

        String stackTrace = ExceptionUtils.getStackTrace(e);

        if (e instanceof org.apache.shiro.authz.AuthorizationException) {
            LOGGER.info("没有权限!---即授权失败");
        } else {
            LOGGER.error(stackTrace);
        }


        mav.addObject("exception", stackTrace.replaceAll("\r\n", "<br/>"));

        //授权失败页面
        String view = "/common/error/error";

        if (e instanceof org.apache.shiro.authz.UnauthenticatedException) {
            //未登录
            view = "/common/user/login";
        } else if (e instanceof org.apache.shiro.authz.AuthorizationException) {
            //没有权限
            mav.addObject("exception", "该用户没有权限!");
            view = "/common/error/error";
        }

        mav.setViewName(view);

        return mav;
    }
}
