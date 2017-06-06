package sunday.common.kit;

import sunday.pojo.student.SingleTaken;
import sunday.pojo.student.TfTaken;

import java.util.List;
import java.util.Map;

/**
 * Created by 花间一壶酒 on 2017/6/6.
 */
public final class MakeTestPaperKit {

    private MakeTestPaperKit() {
    }

    /**
     * 传入一个按难度排序的 singleTakenList 和三个用来存储难度区间的 map
     * @param testList   singleTakenList .
     * @param Question_1 简单 难度区间.
     * @param Question_2 中等 难度区间.
     * @param Question_3 困难 难度区间.
     */
    public static void makeStartEndMap_s(List<SingleTaken> testList,
                                       Map<String, Integer> Question_1,
                                       Map<String, Integer> Question_2,
                                       Map<String, Integer> Question_3) {
        /*
        用三个Map将不同难度的题的标号的 起始(start) 与 结束(end) 位置标出
        */
        int count_s = 0;
        Boolean startNotFind_s = true;//起始值 未找到(true)
        for (SingleTaken testTaken : testList) {
            if (startNotFind_s && testTaken.getLevels() == 2) {
                Question_2.put("start", count_s);
                startNotFind_s = false;//起始值 已找到(false)
            }
            //查找结束值 找到后结束循环
            if (testTaken.getLevels() == 3) {
                Question_2.put("end", count_s - 1);
                break;
            }
            count_s++;
        }
        //简单难度的起始值为 0 , 结束值 等于 中等难度的起始值-1
        Question_1.put("start", 0);
        Question_1.put("end", Question_2.get("start") - 1);
        //困难难度的结束值为 列表长度-1, 起始值 等于 中等难度的结束值+1
        Question_3.put("start", (Question_2.get("end") + 1));
        Question_3.put("end", testList.size() - 1);
    }

    /**
     * 传入一个按难度排序的 TftakenList 和三个用来存储难度区间的 map
     * @param testList   TftakenList .
     * @param Question_1 简单 难度区间.
     * @param Question_2 中等 难度区间.
     * @param Question_3 困难 难度区间.
     */
    public static void makeStartEndMap_t(List<TfTaken> testList,
                                         Map<String, Integer> Question_1,
                                         Map<String, Integer> Question_2,
                                         Map<String, Integer> Question_3) {
        /*
        用三个Map将不同难度的题的标号的 起始(start) 与 结束(end) 位置标出
        */
        int count_s = 0;
        Boolean startNotFind_s = true;//起始值 未找到(true)
        for (TfTaken testTaken : testList) {
            if (startNotFind_s && testTaken.getLevels() == 2) {
                Question_2.put("start", count_s);
                startNotFind_s = false;//起始值 已找到(false)
            }
            //查找结束值 找到后结束循环
            if (testTaken.getLevels() == 3) {
                Question_2.put("end", count_s - 1);
                break;
            }
            count_s++;
        }
        //简单难度的起始值为 0 , 结束值 等于 中等难度的起始值-1
        Question_1.put("start", 0);
        Question_1.put("end", Question_2.get("start") - 1);
        //困难难度的结束值为 列表长度-1, 起始值 等于 中等难度的结束值+1
        Question_3.put("start", (Question_2.get("end") + 1));
        Question_3.put("end", testList.size() - 1);
    }
}
