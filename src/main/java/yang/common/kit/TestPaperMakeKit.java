package yang.common.kit;

import org.slf4j.Logger;
import yang.common.enums.QuestionType;
import yang.domain.student.SingleTaken;
import yang.domain.student.TfTaken;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 根据给定题库组题
 * <p>
 * Created by 花间一壶酒 on 2017/12/16.
 */
public final class TestPaperMakeKit {

    private static final Logger LOGGER = LogKit.getLogger();

    /**
     * 组题方法
     *
     * @param randList     原始题目集合.
     * @param questionType 题目类型枚举.
     * @param <T>          题目类型.
     * @return 题目类型集合.
     */
    public static <T> List<?> randQuestion(List<T> randList, QuestionType questionType) {
        if (null == randList) {
            LOGGER.error("传入的原始题目集合为空,发生在类{}的 randQuestion 方法", ClassKit.getClassName());
            return null;
        }
        List<SingleTaken> singleQuestionList = null;
        List<TfTaken> tfQuestionList = null;
        //根据题目类型进行初始化
        switch (questionType) {
            case Single:
                singleQuestionList = (List<SingleTaken>) randList;
                break;
            case TF:
                tfQuestionList = (List<TfTaken>) randList;
                break;
            default:
                LOGGER.error("传入的题目类型错误,发生在类{}的 randQuestion 方法", ClassKit.getClassName());
                return null;
        }
        List<Integer> EList = new ArrayList<>();//Easy
        List<Integer> NList = new ArrayList<>();//Normal
        List<Integer> DList = new ArrayList<>();//Difficulty
        //根据题目难度将位置存入不同的难度集合中
        for (int i = 0; i < randList.size(); i++) {
            switch ((questionType.getMsg().equals("选择题") ? singleQuestionList.get(i).getLevels() : tfQuestionList.get(i).getLevels())) {
                case 1:
                    EList.add(i);
                    break;
                case 2:
                    NList.add(i);
                    break;
                case 3:
                    DList.add(i);
                    break;
                default:
                    LOGGER.warn("传入的原始题目集合中的第{}元素存在非法难度等级，发生在类{}的 randQuestion 方法", i, ClassKit.getClassName());
            }
        }

        List<Integer> ERandList;
        List<Integer> NRandList;
        List<Integer> DRandList;
        //对位置集合进行随机获取，产生随机位置集合
        switch (questionType) {
            case Single:
                List<SingleTaken> sQList = new ArrayList<>();
                if ((ERandList = randList(EList, randNumber(0, EList.size(), QuestionType.Single_E.getNumber()))) == null) {
                    LOGGER.error("简单难度的选择题组题失败，发生在类{}的 randQuestion 方法", ClassKit.getClassName());
                    return null;
                }
                if ((NRandList = randList(NList, randNumber(0, NList.size(), QuestionType.Single_N.getNumber()))) == null) {
                    LOGGER.error("普通难度的选择题组题失败，发生在类{}的 randQuestion 方法", ClassKit.getClassName());
                    return null;
                }
                if ((DRandList = randList(DList, randNumber(0, DList.size(), QuestionType.Single_D.getNumber()))) == null) {
                    LOGGER.error("困难难度的选择题组题失败，发生在类{}的 randQuestion 方法", ClassKit.getClassName());
                    return null;
                }
                for (Integer questionNumber : ERandList) sQList.add(singleQuestionList.get(questionNumber));
                for (Integer questionNumber : NRandList) sQList.add(singleQuestionList.get(questionNumber));
                for (Integer questionNumber : DRandList) sQList.add(singleQuestionList.get(questionNumber));
                return sQList;
            case TF:
                List<TfTaken> tQList = new ArrayList<>();

                if ((ERandList = randList(EList, randNumber(0, EList.size(), QuestionType.TF_E.getNumber()))) == null) {
                    LOGGER.error("简单难度的判断题组题失败，发生在类{}的 randQuestion 方法", ClassKit.getClassName());
                    return null;
                }
                if ((NRandList = randList(NList, randNumber(0, NList.size(), QuestionType.TF_N.getNumber()))) == null) {
                    LOGGER.error("普通难度的判断题组题失败，发生在类{}的 randQuestion 方法", ClassKit.getClassName());
                    return null;
                }
                if ((DRandList = randList(DList, randNumber(0, DList.size(), QuestionType.TF_D.getNumber()))) == null) {
                    LOGGER.error("困难难度的判断题组题失败，发生在类{}的 randQuestion 方法", ClassKit.getClassName());
                    return null;
                }
                //遍历随机位置集合，将被选择的元素添加到最终的返回集合中
                for (Integer questionNumber : ERandList) tQList.add(tfQuestionList.get(questionNumber));
                for (Integer questionNumber : NRandList) tQList.add(tfQuestionList.get(questionNumber));
                for (Integer questionNumber : DRandList) tQList.add(tfQuestionList.get(questionNumber));
                return tQList;
        }
        return null;
    }

    /**
     * 获取某正数区间内的多个随机不重复的整数
     *
     * @param startNum 起始值.
     * @param endNum   结束值.
     * @param randNum  随机个数.
     * @return 结果数集.
     */
    private static Set<Integer> randNumber(int startNum, int endNum, int randNum) {
        if ((endNum - startNum + 1) < randNum || endNum <= startNum || randNum < 1 || startNum < 0 || endNum < 1) {
            LOGGER.error("传入的参数存在错误，发生在类{}的 randNumber 方法", ClassKit.getClassName());
            return null;
        }
        Set<Integer> resultSet = new HashSet<>();
        while (resultSet.size() != randNum) {
            resultSet.add((int) (Math.random() * (endNum - startNum) + startNum));
        }
        return resultSet;
    }

    /**
     * 根据set获取List中的指定元素并以List返回
     *
     * @param randList 初始List
     * @param randSet  指定的元素
     * @param <T>      singleQuestionList 和 tfQuestionList
     * @return 最终获取的List
     */
    private static <T> List<T> randList(List<T> randList, Set<Integer> randSet) {
        if (null == randList || null == randSet) {
            LOGGER.error("空对象传入，发生在类{}的 randList 方法", ClassKit.getClassName());
            return null;
        }
        if (randList.size() == randSet.size()) {
            return randList;
        }
        if (randList.size() < randSet.size()) {
            LOGGER.error("企图获取的数量大于传入的数量，发生在类{}的 randList 方法", ClassKit.getClassName());
            return null;
        }
        List<T> resultList = new ArrayList<>();
        for (Integer i : randSet) {
            resultList.add(randList.get(i));
        }
        return resultList;
    }
}
