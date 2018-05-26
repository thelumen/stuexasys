package yang.common.cache;

import yang.common.kit.FileKit;
import yang.domain.student.ExamInfo;
import yang.domain.student.TestPaper;

import java.util.Arrays;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * 考试题缓存类
 * <p>
 * Created by 花间一壶酒 on 2017/12/16.
 */
public class EQCache {

    private static Map<String, Object> questionCache = new ConcurrentHashMap<>();

    /**
     * 获取题目缓存
     *
     * @param examInfo 考试信息.
     * @return 考试内容.
     */
    public static TestPaper getQuestionCache(ExamInfo examInfo) {
        Objects.requireNonNull(examInfo);
        return (TestPaper) FileKit.deepCopy(questionCache.get(getQuestionKeyFromExamInfo(examInfo)));
    }

    /**
     * 设置题目缓存
     *
     * @param examInfo  考试信息.
     * @param testPaper 考试内容.
     */
    public static void setQuestionCache(ExamInfo examInfo, TestPaper testPaper) {
        Objects.requireNonNull(examInfo);
        Objects.requireNonNull(testPaper);
        String key = getQuestionKeyFromExamInfo(examInfo);
        questionCache.put(key, FileKit.deepCopy(testPaper));
        //定义删除方法
        Runnable runnable = () -> questionCache.remove(key);
        ScheduledExecutorService service = Executors.newSingleThreadScheduledExecutor();
        //设置cache两小时后执行删除方法
        service.schedule(runnable, 2, TimeUnit.HOURS);
    }

    /**
     * 根据考试信息生成键值
     *
     * @param examInfo 考试信息.
     * @return 信息键值.
     */
    private static String getQuestionKeyFromExamInfo(ExamInfo examInfo) {
        return examInfo.getCourseId().toString() + Arrays.toString(examInfo.getContent().split(","));
    }

    /**
     * 获取学生题目缓存
     *
     * @param examInfo 考试信息.
     * @return 考试内容.
     */
    public static TestPaper getStudentQuestionCache(ExamInfo examInfo, int studentId) {
        Objects.requireNonNull(examInfo);
        return (TestPaper) FileKit.deepCopy(questionCache.get(getStudentQuestionKeyFromExamInfo(examInfo, studentId)));
    }

    /**
     * 设置学生题目缓存
     *
     * @param examInfo  考试信息.
     * @param studentId 学生id
     * @param testPaper 考试内容.
     */
    public static void setStudentQuestionCache(ExamInfo examInfo, int studentId, TestPaper testPaper) {
        Objects.requireNonNull(examInfo);
        Objects.requireNonNull(testPaper);
        String key = getStudentQuestionKeyFromExamInfo(examInfo,studentId);
        questionCache.put(key, FileKit.deepCopy(testPaper));
        //定义删除方法
        Runnable runnable = () -> questionCache.remove(key);
        ScheduledExecutorService service = Executors.newSingleThreadScheduledExecutor();
        //设置cache两小时后执行删除方法
        service.schedule(runnable, 2, TimeUnit.HOURS);
    }

    /**
     * 根据考试信息与学生id生成键值
     *
     * @param examInfo 考试信息.
     * @return 信息键值.
     */
    private static String getStudentQuestionKeyFromExamInfo(ExamInfo examInfo, int studentId) {
        return examInfo.getCourseId().toString() + Arrays.toString(examInfo.getContent().split(",")) + studentId;
    }
}
