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
    private static final Logger logger = LogKit.getLogger();

    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {
        String stackTrace = ExceptionUtils.getStackTrace(e);

        if (e instanceof org.apache.shiro.authz.AuthorizationException) {
            logger.info("没有权限!");
        } else if (e instanceof org.apache.shiro.authz.UnauthenticatedException) {
            logger.info("未登录!");
        } else {
            logger.error(stackTrace);
        }

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("exception", stackTrace.replaceAll("\r\n", "<br/>"));

        String view = "/shiro/error/defaultError";

        if (e instanceof org.apache.shiro.authz.UnauthenticatedException) {
            //未登录
            view = "/users/login";
        } else if (e instanceof org.apache.shiro.authz.AuthorizationException) {
            //没有权限
            view = "/shiro/error/unauthorized";
        }

        return new ModelAndView(view, model);
    }
}
