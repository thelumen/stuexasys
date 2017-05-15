package sunday.common.kit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by yang on 2017/2/8.
 * At 11:49
 */
public final class LogKit {

    private LogKit() {
    }

    /**
     * 获取当前类日志
     *
     * @return
     */
    public static Logger getLogger() {
        return LoggerFactory.getLogger(ClassKit.getClassName());
    }
}
