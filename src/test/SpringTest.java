import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.controller.common.CommonController;

/**
 * Created by yang on 2017/5/24.
 * At 12:34
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:/config/spring/spring-*.xml"})
public class SpringTest extends CommonController {

    @Test
    public void t1() {

    }
}
