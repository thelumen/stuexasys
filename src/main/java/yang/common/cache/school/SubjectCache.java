package yang.common.cache.school;

import yang.domain.common.SingleQuestion;
import yang.domain.common.TfQuestion;

import java.time.LocalDateTime;
import java.util.List;
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
        QuestionBank bank = courseAndQuestionMap.get(courseAndChapterName);
        if (null == bank) {
            return null;
        }
        //组题后题目数目不够将会返回null
        return resetContent(bank);
    }


    private static QuestionBank resetContent(QuestionBank bank) {
        QuestionBank newBank = new QuestionBank();

        final List<SingleQuestion> singleList = bank.getSingleQuestions();
        List<TfQuestion> tfList;

        //singleList.stream().filter(question->question.getLevels()==1).collect()

        return null;
    }

    private enum SubjectEnum {
        /**
         * 选择题&判断题的题型难度Enum
         */
        SINGLE_QUESTION_SIMPLE(5),
        SINGLE_QUESTION_NORMAL(10),
        SINGLE_QUESTION_DIFFICULTY(5),

        TF_QUESTION_SIMPLE(2),
        TF_QUESTION_NORMAL(2),
        TF_QUESTION_DIFFICULTY(1);

        Integer number;

        SubjectEnum(Integer number) {
            this.number = number;
        }

        public Integer getNumber() {
            return number;
        }
    }

    /**
     * 定时器执行任务
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
