import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sunday.controller.common.CommonController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/24.
 * At 12:34
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:/config/spring/spring-*.xml"})
public class SpringTest extends CommonController {

    @Test
    public void t1() {
        Map<String, Object> params = new HashMap<>();
        params.put("courseId", 10000000);
        List<String> sectionInfo = new ArrayList<>();
        sectionInfo.add("第一章");
        sectionInfo.add("第五章");
        sectionInfo.add("第六章");
        params.put("sectionList", sectionInfo);
        //System.out.println(studentService.selectQuestion(params));
    }
}
