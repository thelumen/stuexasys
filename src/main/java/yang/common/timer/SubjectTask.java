package yang.common.timer;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import yang.common.cache.school.SubjectCache;

/**
 * @author yangxuyue
 * @date 2017/12/18.
 * At 11:47
 */
@Component
public class SubjectTask {

    @Scheduled(cron = "0 0/30 ?9-17 * * ?")
    public void run() {
        SubjectCache.deleteExpiredContent(2);
    }

}
