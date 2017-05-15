package sunday.common.kit;

import org.nutz.lang.Lang;
import org.nutz.log.Logs;

/**
 * Created by yang on 2017/2/8.
 * At 11:50
 */
public final class ClassKit {

    private ClassKit() {
    }

    /**
     * 获取当前类的类名
     * 相互调用时，下一个为这个类的信息
     *
     * @return
     */
    public static String getClassName() {
        StackTraceElement[] sts = Thread.currentThread().getStackTrace();
        if (Lang.isAndroid) {
            for (int i = 0; i < sts.length; i++) {
                if (sts[i].getClassName().equals(Logs.class.getName())) {
                    return sts[i + 1].getClassName();
                }
            }
        }
        return sts[2].getClassName();
    }
}
