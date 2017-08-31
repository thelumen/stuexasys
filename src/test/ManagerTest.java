import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.common.kit.EncryptKit;
import sunday.controller.common.CommonController;
import sunday.pojo.manager.Manager;
import sunday.pojo.school.Specialty;
import sunday.service.common.CommonService;

/**
 * Created by yang on 2017/8/22.
 * At 20:53
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:/config/spring/spring-*.xml"})
public class ManagerTest extends CommonController {

    @Test
    public void t2() {
        Specialty s = new Specialty();
        s.setSpecialtyId(111111);
        s.setName("19计算机");
        System.out.print(specialtyService.insert(s) > 0);
    }

    //测试新增管理员
    @Test
    public void t1() {
        Manager manager = new Manager();
        manager.setManagerId(19950221);
        manager.setName("杨徐越");
        manager.setPassword(EncryptKit.md5("19950221"));
        managerService.insert(manager);
    }
}
