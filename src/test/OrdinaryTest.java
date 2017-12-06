import org.junit.Test;
import yang.common.base.ResultBean;
import yang.common.kit.EncryptKit;

import java.io.File;

import static java.lang.System.out;

/**
 * @author yangxuyue
 * @date 2017/7/30.
 * At 18:19
 */
public class OrdinaryTest {
    @Test
    public void t2() {
        File file = new File("E:\\搬移文件\\Desktop\\测试.xls");
        out.println(file.getPath());
        out.println(file.getAbsolutePath());
        out.println(file.getName());

    }

    @Test
    public void t1() {
        out.println(EncryptKit.md5("111"));
    }

}
