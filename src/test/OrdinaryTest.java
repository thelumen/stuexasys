import org.junit.Test;
import sunday.common.kit.DateKit;
import sunday.common.kit.ResourceFileKit;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

/**
 * Created by 花间一壶酒 on 2017/7/30.
 */
public class OrdinaryTest {

    @Test
    public void t4() {

    }

    @Test
    public void t3() {
        List<Map<String, Object>> testList = ResourceFileKit.getResourceInfo();
        assert testList != null;
        testList.toString();
    }

    @Test
    public void t2() throws ParseException {
        String resultTime = DateKit.date2String(System.currentTimeMillis());
        System.out.println(resultTime);
    }
}
