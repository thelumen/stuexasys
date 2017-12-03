import org.junit.Test;
import yang.common.base.ResultBean;
import yang.common.kit.EncryptKit;

import static java.lang.System.out;

/**
 * @author yangxuyue
 * @date 2017/7/30.
 * At 18:19
 */
public class OrdinaryTest {


    @Test
    public void t1() {
        out.println(EncryptKit.md5("111"));
    }

}
