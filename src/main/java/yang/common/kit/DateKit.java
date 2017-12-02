package yang.common.kit;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by yang on 2017/5/25.
 * At 15:52
 */
public final class DateKit {
    private DateKit() {
    }

    /**
     * yyyy-MM-dd 类型字符串转date
     *
     * @param date
     * @return
     */
    public static Date string2Date(String date) {
        Date resultDate = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
            resultDate = sdf.parse(date);
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return resultDate;
    }

    /**
     * 将时间戳（String）格式化成 yyyy-MM-dd HH-mm-ss
     *
     * @param stringTime 时间戳类型
     * @return yyyy-MM-dd HH-mm-ss.
     */
    public static String date2String(String stringTime) {
        long longTime = new Long(stringTime);
        return date2String(longTime);
    }

    /**
     * 将时间戳（long）格式化成 yyyy-MM-dd HH-mm-ss
     *
     * @param longTime 时间戳类型
     * @return yyyy-MM-dd HH-mm-ss.
     */
    public static String date2String(long longTime) {
        Date date = new Date(longTime);
        return date2String(date);
    }


    /**
     * 将date 格式化为 yyyy-MM-dd HH-mm-ss
     *
     * @param date 日期类型
     * @return yyyy-MM-dd HH-mm-ss.
     */
    public static String date2String(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(date);
    }
}
