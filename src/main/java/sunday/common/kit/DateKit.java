package sunday.common.kit;

import java.text.ParseException;
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
     * @throws ParseException
     */
    public static Date string2Date(String date) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.parse(date);
    }
}
