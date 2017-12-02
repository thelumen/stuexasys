package yang.common.kit;

import org.apache.commons.lang3.StringUtils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

    /**
     * 判断字符串是否包含中文
     *
     * @param src
     * @return
     */
    public static boolean isContainChinese(String src) {
        Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
        Matcher m = p.matcher(src);

        return m.find();
    }

}
