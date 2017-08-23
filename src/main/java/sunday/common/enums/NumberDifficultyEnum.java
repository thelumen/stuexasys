package sunday.common.enums;

/**
 * Created by 花间一壶酒 on 2017/6/5.
 */
public enum NumberDifficultyEnum {

    Single_1("简单", 4), Single_2("中等", 14), Single_3("困难", 2),
    Tf_1("简单", 1), Tf_2("中等", 3), Tf_3("困难", 1),Total_Single("选择题总量",20),Total_Tf("判断题总量",5);

    private final String difficulty;
    private final int numbers;

    NumberDifficultyEnum(String difficulty, int numbers) {
        this.difficulty = difficulty;
        this.numbers = numbers;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public int getNumbers() {
        return numbers;
    }
}
