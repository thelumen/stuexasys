import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.common.kit.EncryptKit;
import sunday.pojo.manager.Manager;
import sunday.service.manager.ManagerService;

/**
 * Created by yang on 2017/8/22.
 * At 20:53
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:/config/spring/spring-*.xml"})
public class ManagerTest {
    @javax.annotation.Resource(name = "managerService")
    private ManagerService managerService;

    //测试新增管理员
    @Test
    public void t1(){
        Manager manager=new Manager();
        manager.setManagerId(19950221);
        manager.setName("杨徐越");
        manager.setPassword(EncryptKit.md5("19950221"));
        managerService.insert(manager);
    }
}
