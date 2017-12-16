package yang.common.cache;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author yangxuyue
 * @date 2017/12/16.
 * At 11:16
 */
public final class SubjectCache {
    /**
     * key：课程+章节，value：题目
     */
    private static Map<String, QuestionBank> courseAndQuestionMap = new ConcurrentHashMap<>();

    /**
     * 题库映射时间
     */
    private static Map<String, LocalDateTime> subject2Time = new ConcurrentHashMap<>();

    /**
     * 设置 课程（加章节）-题目
     *
     * @param chapterInCourseName
     * @param question
     */
    public static void setContent(String chapterInCourseName, QuestionBank question) {
        if (null == question) {
            return;
        }
        //键相同可以被覆盖
        courseAndQuestionMap.put(chapterInCourseName, question);
        subject2Time.put(chapterInCourseName, LocalDateTime.now());
    }

    /**
     * 获取题目
     *
     * @param courseAndChapterName
     * @return
     */
    public static QuestionBank getContent(String courseAndChapterName) {
        return courseAndQuestionMap.get(courseAndChapterName);
    }

    /**
     * 删除超出指定时间内的题目内容
     *
     * @param hour
     */
    public static void deleteExpiredContent(int hour) {
        if (hour < 0) {
            throw new IllegalArgumentException();
        }
        LocalDateTime oldDateTime;
        for (Map.Entry<String, LocalDateTime> entry : subject2Time.entrySet()) {
            oldDateTime = entry.getValue();
            //如果超出指定时间，则删除题目内容
            if (oldDateTime.plusHours(hour).compareTo(LocalDateTime.now()) < 0) {
                courseAndQuestionMap.remove(entry.getKey());
            }
        }
    }

}
