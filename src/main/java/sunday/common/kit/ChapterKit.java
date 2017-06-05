package sunday.common.kit;

import sunday.pojo.school.SingleQuestion;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 目前只用于选择题
 * Created by yang on 2017/4/28.
 * At 12:46
 */
public final class ChapterKit {
    private ChapterKit() {
    }

    //冒泡排序
    public static ArrayList<SingleQuestion> bubbleSort(List<SingleQuestion> chapters) {
        SingleQuestion[] chaptersArray = (SingleQuestion[]) chapters.toArray(new SingleQuestion[chapters.size()]);
        for (int i = 0; i < chaptersArray.length - 1; i++) {
            for (int j = chaptersArray.length - 1; j > i; j--) {
                char char1 = chaptersArray[j].getSection().charAt(1);
                char char2 = chaptersArray[j - 1].getSection().charAt(1);
                if (ChapterKit.string2int(char1) < ChapterKit.string2int(char2)) {
                    swap(chaptersArray, j - 1, j);
                }
            }
        }
        return new ArrayList<SingleQuestion>(Arrays.asList(chaptersArray));
    }

    //冒泡排序——转换
    public static void swap(SingleQuestion[] chapters, int i, int j) {
        SingleQuestion chapter = chapters[i];
        chapters[i] = chapters[j];
        chapters[j] = chapter;
    }

    //字母一至八转换成数字
    public static int string2int(char target) {
        int result = 0;
        switch (String.valueOf(target)) {
            case "一":
                result = 1;
                break;
            case "二":
                result = 2;
                break;
            case "三":
                result = 3;
                break;
            case "四":
                result = 4;
                break;
            case "五":
                result = 5;
                break;
            case "六":
                result = 6;
                break;
            case "七":
                result = 7;
                break;
            case "八":
                result = 8;
                break;
            case "九":
                result = 9;
                break;
            case "十":
                result = 10;
                break;
        }
        return result;
    }
}
