import org.junit.Test;
import yang.common.kit.EncryptKit;

import java.util.*;

import static java.lang.System.out;

/**
 * @author yangxuyue
 * @date 2017/7/30.
 * At 18:19
 */
public class OrdinaryTest {
    @Test
    public void t2() {
        List<Map<String, Object>> yearList = new ArrayList<>();
        Map<String, Object> year;
        String studentId = "" + 140401050;
        int startYear = Integer.valueOf(studentId.substring(0, 2)) + 2000;//截取学号前两位，组装成入学年
        Calendar calendar = Calendar.getInstance();
        int parentYear = calendar.get(Calendar.YEAR);
        int parentMouth = calendar.get(Calendar.MONTH);// 0 代表一月 11 代表十二月
        int endYear = parentMouth > 8 ? parentYear + 1 : parentYear;// 获取学期结束年
        for (; startYear < endYear; startYear++) {
            year = new HashMap<>();
            year.put("id", startYear);
            year.put("text", startYear + "-" + (startYear + 1));
            yearList.add(year);
        }
        out.println(Arrays.toString(yearList.toArray()));
    }

    @Test
    public void t1() {
        out.println(EncryptKit.md5("111"));
    }

}
