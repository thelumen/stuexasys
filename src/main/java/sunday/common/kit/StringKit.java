package sunday.common.kit;

import org.apache.commons.lang3.StringUtils;

/**
 * Created by yang on 2017/5/22.
 * At 15:17
 */
public final class StringKit {
    private StringKit() {
    }

    /**
     * 去掉左右的空格
     *
     * @param str
     * @return
     */
    public static String trim(String str) {
        return StringUtils.trim(str);
    }
}
