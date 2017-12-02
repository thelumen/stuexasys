package yang.common.kit;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/9/10.
 * At 17:50
 */
public final class ChapterKit {
    private ChapterKit() {
    }

    //章节数组
    public static final String[] CHAPTERS = {"第一章", "第二章", "第三章",
            "第四章", "第五章", "第六章", "第七章", "第八章", "第九章", "第十章",
            "第十一章", "第十二章", "第十三章", "第十四章", "第十五章", "第十六章"};

    /**
     * 获取指定数量的章节数
     *
     * @param index
     * @return
     */
    public static String[] getLimitedChapters(int index) {
        if (index <= 0 || index > 16) {
            return new String[0];
        }

        String[] targetArray = new String[index];
        System.arraycopy(CHAPTERS, 0, targetArray, 0, index);
        return targetArray;
    }

    /**
     * 获取章节select
     *
     * @param srcArray
     * @return
     */
    public static List<Map<String, Object>> getChapterInSelect(String... srcArray) {
        List<Map<String, Object>> father = new ArrayList<>();
        for (String chapterName : srcArray) {
            Map<String, Object> child = new HashMap<String, Object>() {
                private static final long serialVersionUID = -8907869205729845500L;

                {
                    put("id", CommonKit.chinese2CharNumber(chapterName));
                    put("text", chapterName);
                }
            };
            father.add(child);
        }
        return father;
    }

    /**
     * 数字型章节格式转中文型
     *
     * @param StringArray 数字型章节的集合
     * @return .
     */
    public static List<String> getChapterTransport(String... StringArray) {
        List<String> transportList = new ArrayList<>();
        for (String numOfStringArray : StringArray) {
            transportList.add(CHAPTERS[Integer.valueOf(numOfStringArray) - 1]);
        }
        return transportList;
    }
}
